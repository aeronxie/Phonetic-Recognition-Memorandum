//
//  DetailViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/7/28.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "DetailViewController.h"
#import "MainViewController.h"
#import "AddNoteViewController.h"
#import "PopupView.h"
#import "Definition.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlyRecognizerView.h"


@interface DetailViewController ()<UIAlertViewDelegate,UITextViewDelegate,IFlyRecognizerViewDelegate>

{
    NSDate *_selected;
    UIBarButtonItem *_saveBtn;
}

@property  IBOutlet UITextView *mytextView;
@property (weak, nonatomic) IBOutlet UILabel *countDay;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIView *ViewCell;
@property (weak, nonatomic) IBOutlet UIButton *remindBtn;
@property (weak, nonatomic) IBOutlet UIButton *pictureBtn;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;

//@property UITextView *mytextView;
@end

@implementation DetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [[[NSBundle mainBundle]loadNibNamed:@"DetailViewController" owner:nil options:nil]firstObject];

    }
    return self;
}

//提醒按钮
- (IBAction)remind:(UIButton *)sender {
    
    _ViewCell.hidden = NO;
    _pictureBtn.hidden = NO;
    _finishBtn.hidden = NO;
    _remindBtn.hidden = YES;
    _pictureBtn.hidden = YES;
    _recordBtn.hidden = YES;
    _datePicker.hidden = NO;
    
    
    
}
- (IBAction)help:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击语音按钮可以快速语音输入" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (IBAction)startRecord:(UIButton *)sender {
    
    
    [self startListenning:sender];
    
}

//完成按钮~~
- (IBAction)finished:(UIButton *)sender {
    
    
    
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
    
    
    
    
    //获取当前系统的时间
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:now];
    NSDate *localTime = [now dateByAddingTimeInterval:interval];
    
    
    //得到相差秒数
    NSTimeInterval time = [localTime1 timeIntervalSinceDate:localTime];
    
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)%3600/60;
    
    if (days <= 0&&hours <= 0&&minute <= 0)
    {_countDay.text=@"0天0小时0分钟";}
    
    else{
        _countDay.text=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute];}
    
    _selected = selected;
    self.datePicker.hidden = YES;
    self.recordBtn.hidden =NO;
    self.remindBtn.hidden = NO;
    self.pictureBtn.hidden = NO;
    self.ViewCell.hidden = YES;
    self.finishBtn.hidden = YES;
    
    _saveBtn.enabled = YES;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    //成为第一响应者
    [_mytextView becomeFirstResponder];
    
    _mytextView.delegate = self;
    
    _popView = [[PopupView alloc] initWithFrame:CGRectMake(100, 150, 0, 0)];
    _popView.ParentView = self.view;
    
    //创建语音听写的对象
    self.iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    
    //delegate需要设置，确保delegate回调可以正常返回
    _iflyRecognizerView.delegate = self;

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];
    
    
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    _saveBtn = saveBtn;
    
    saveBtn.enabled = NO;

    self.hidesBottomBarWhenPushed = YES;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    
    
    NSString *oldtext = [array objectAtIndex:_index];
    
    self.mytextView.text = oldtext;
    
    
    NSArray *countDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"countdate"];
    
    
    NSDate *olddate = [countDateArray objectAtIndex:_index];
    
    //获取当前系统的时间
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:now];
    NSDate *localTime = [now dateByAddingTimeInterval:interval];
    
    
    NSLog(@"=========================%@",olddate);
    
    
    
    //得到相差秒数
    NSTimeInterval time = [olddate timeIntervalSinceDate:localTime];
    
    time = time + 28800;
    
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)%3600/60;
    
    if (days <= 0&&hours <= 0&&minute <= 0)
    {_countDay.text=@"0天0小时0分钟";}
    
    else{
        _countDay.text=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute];
    }
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 保存方法
-(void)saveclicked {
    
    NSMutableArray *mutableArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSDate *now = [NSDate date];
    
    NSString *datestring = [dateFormatter stringFromDate:now];
    
    NSString *textstring = [self.mytextView text];
    
    [mutableArray replaceObjectAtIndex:self.index withObject:textstring];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
    
    
    
    //创建一个日期格式器
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    //为日期格式器设置格式字符串
    [dateFormatter1 setDateFormat:@"yyyy年MM月dd日  HH:mm "];
    
    
    
    NSMutableArray *tempCountDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"countdate"];
    
    
    [tempCountDateArray replaceObjectAtIndex:self.index withObject:_selected];
    
    [[NSUserDefaults standardUserDefaults] setObject:tempCountDateArray forKey:@"countdate"];
    
    
    NSLog(@"==================%@",tempCountDateArray);
    
    
    NSMutableArray *mutableDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    
    
    [mutableDateArray replaceObjectAtIndex:self.index withObject:datestring];

    
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
  
    
    
    [self.mytextView resignFirstResponder];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    
    [alert show];
    
    
    
    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self.navigationController popViewControllerAnimated:YES];

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




//返回按钮
- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self saveclicked];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
