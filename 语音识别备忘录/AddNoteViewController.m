//
//  AddNoteViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/7/27.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "AddNoteViewController.h"
#import "MainViewController.h"
#import "Definition.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "PopupView.h"
#import <UIKit/UIKit.h>
#import "UIColor+Hash.h"

@interface AddNoteViewController ()<UIAlertViewDelegate,UITextViewDelegate>
{
    NSDate *_selected;
    UIButton *_saveBtn;
}



@property (weak, nonatomic) IBOutlet UIButton *remindBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *savaFinish;
@property (strong, nonatomic) IBOutlet UIButton *ringhtBtn;
@property (weak, nonatomic) IBOutlet UITextView *mytextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;
@property (strong, nonatomic) IBOutlet UIView *viewCell;
@property (strong, nonatomic) IBOutlet UIButton *finishBtn;
@property (strong, nonatomic) IBOutlet UILabel *countDay;
@property (assign, nonatomic) NSInteger num;

@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorFromHexString:color];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _mytextView.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _popView = [[PopupView alloc] initWithFrame:CGRectMake(100, 150, 0, 0)];
    _popView.ParentView = self.view;
    
    //创建语音听写的对象
    self.iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    
    //delegate需要设置，确保delegate回调可以正常返回
    _iflyRecognizerView.delegate = self;
    
    _savaFinish.enabled = NO;
}

//选择日期
- (IBAction)dateBtn:(UIButton *)sender {
    
    self.datePicker.hidden = NO;
    self.recordBtn.hidden =YES;
    self.remindBtn.hidden = YES;
    self.ringhtBtn.hidden = YES;
    self.viewCell.hidden = NO;
    self.finishBtn.hidden = NO;
    
}

// 取消
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//完成按钮
- (IBAction)finishedBtn:(id)sender {
    
    
    //获取用户选择的日期和时间
    NSDate *selected = [self.datePicker date];
    //创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy年MM月dd日  HH:mm "];
    //使用日期格式器格式化日期、时间·
    //NSString *dateString = [dateFormatter stringFromDate:selected];
    //NSString *message =  [NSString stringWithFormat:@"您选择的日期和时间是：%@", dateString];
    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
    NSInteger interval1 = [zone1 secondsFromGMTForDate:selected];
    NSDate *localTime1 = [selected dateByAddingTimeInterval:interval1];
    
    NSLog(@"%@",localTime1);
    
    
    _selected = selected;
    
    //获取当前系统的时间
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:now];
    NSDate *localTime = [now dateByAddingTimeInterval:interval];
    

    //得到相差秒数
    NSTimeInterval time = [localTime1 timeIntervalSinceDate:localTime];
    
    //推送通知
    UILocalNotification *local = [[UILocalNotification alloc]init];
    local.fireDate = [NSDate dateWithTimeIntervalSinceNow:time];
    local.alertBody = self.mytextView.text;
    local.soundName = @"";
    [local setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] scheduleLocalNotification:local];

    
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)%3600/60;
    
    if (days <= 0&&hours <= 0&&minute <= 0)
    {_countDay.text=@"0天0小时0分钟";}
    
    else{
        _countDay.text=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute];}

    
    self.datePicker.hidden = YES;
    self.recordBtn.hidden =NO;
    self.remindBtn.hidden = NO;
    self.ringhtBtn.hidden = NO;
    self.viewCell.hidden = YES;
    self.finishBtn.hidden = YES;
    _savaFinish.enabled = YES;

}


//帮助按钮
- (IBAction)help:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击语音按钮可以快速语音输入" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
    
    
}


//松开停止录音
- (IBAction)recordBtn:(UIButton *)sender {
    [self startListenning:sender];

    
}

//保存
- (IBAction)savaBtn:(UIBarButtonItem *)sender {
    
    [self saveclicked];
    
    
}


//键盘return事件
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark 保存方法
-(void)saveclicked {
    
    
    NSMutableArray *initNoteArray = [[NSMutableArray alloc]init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"note"] == nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:initNoteArray forKey:@"note"];
        
    }
    
    NSArray *tempNoteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    
    NSMutableArray *mutableNoteArray = [tempNoteArray mutableCopy];
    
    NSString *textstring = [self.mytextView text];
    
    [mutableNoteArray insertObject:textstring atIndex:0];
    
    MainViewController *mainControl = [[MainViewController alloc]init];
    
    mainControl.noteArray = mutableNoteArray;
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableNoteArray forKey:@"note"];
    
    NSMutableArray *initDateArray = [[NSMutableArray alloc]init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"date"]==nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:initDateArray forKey:@"date"];
    
    }
    
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
   
    NSDate *now = [NSDate date];
    
    NSString *datestring = [dateFormatter stringFromDate:now];
    
    [mutableDateArray insertObject:datestring atIndex:0 ];
    
    mainControl.dateArray = mutableDateArray;
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"countdate"] == nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:initDateArray forKey:@"countdate"];
    }
    
    
   
    //创建一个日期格式器
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    //为日期格式器设置格式字符串
    [dateFormatter1 setDateFormat:@"yyyy年MM月dd日  HH:mm "];
    
    

    NSArray *tempCountDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"countdate"];
    
    NSMutableArray *mutableCountDateArray = [tempCountDateArray mutableCopy];
    
    //NSString *countDayString = [dateFormatter1 stringFromDate:_selected];
    
       
    [mutableCountDateArray insertObject:_selected atIndex:0];
    
    mainControl.countDateArray = mutableCountDateArray;
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableCountDateArray forKey:@"countdate"];
    
    
    
    [self.mytextView resignFirstResponder];
    
    UIAlertView *saveAlert = [[UIAlertView alloc]initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    
    [saveAlert show];
    
    
    
}

//点击事件方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    

        
        if (buttonIndex == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
      

}

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    //终止识别
    [_iflyRecognizerView cancel];
    [_iflyRecognizerView setDelegate:nil];
    
    [super viewWillDisappear:animated];
}

/**
 启动按钮响应方法
 */
- (void)startListenning:(id)sender
{
    [_iflyRecognizerView setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    //设置结果数据格式，可设置为json，xml，plain，默认为json。
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    [_iflyRecognizerView start];
    
    NSLog(@"start listenning...");
}

#pragma mark IFlyRecognizerViewDelegate

/** 识别结果回调方法
 @param resultArray 结果列表
 @param isLast YES 表示最后一个，NO表示后面还有结果
 */
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    _mytextView.text = [NSString stringWithFormat:@"%@%@",_mytextView.text,result];

  

}

/** 识别结束回调方法
 @param error 识别错误
 */
- (void)onError:(IFlySpeechError *)error
{
    [self.view addSubview:_popView];
    
    [_popView setText:@"识别结束"];
    
    NSLog(@"errorCode:%d",[error errorCode]);
}



@end
