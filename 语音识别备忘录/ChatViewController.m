//
//  ChatViewController.m
//  语音识别备忘录
//
//  Created by Fay on 15/9/8.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageModel.h"
#import "MessageCell.h"
#import "MessageFrameModel.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSString *_results;
}
@property (weak, nonatomic) IBOutlet UITextField *inputView;
@property (nonatomic, strong)NSMutableArray *messages;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    
    self.title = @"正在与机器人聊天...";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.inputView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //cell 不可选中
    self.tableView.allowsSelection = NO;
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ali.jpg"]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    //设置做边距
    self.inputView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    //一直显示
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
    
}


//点击右下角的send 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    //发送一条数据
    [self addmessage:textField.text type:MessageModelMe];
    
    //清空表格
    self.inputView.text = @"";
    
    
    return YES;
}



//添加一条聊天信息

- (void)addmessage:(NSString *)text type:(MessageModelType)type
{
    
    if (type == MessageModelMe)
    {
        [self addMessageTest:text type:type];
    }
    
    
    NSString *message = self.inputView.text;
    
    //判断是否为空格
    if (message.length >0 && [message isEqualToString:text])
    {
        NSString *lastUrl = [NSString stringWithFormat:@"http://op.juhe.cn/robot/index?info=%@&key=2be777a4ecb0b45179dbaff56fb711df",message];
        
        
        NSString *changeUrl = [lastUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:changeUrl];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        __weak ChatViewController *weakSelf = self;
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            
            if (connectionError || data == nil) {
                NSLog(@"网络繁忙");
                return;
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            
            NSDictionary *info = dict[@"result"];
            if ([info isEqual:[NSNull null]]) {
                _results = @"对不起，网络开小差啦，请等一会儿~~~";
            }else {
                _results = info[@"text"];
                
                NSLog(@"回复:%@",_results);
            }

            [weakSelf addMessageTest:_results type:MessageModelrobot];
        }];
        
    }
}

//自动回复的消息
- (void)addMessageTest:(NSString *)text type:(MessageModelType)type
{
    
    //1. 添加模型数据
    MessageModel *msg = [[MessageModel alloc]init];
    
    //设置数据的值
    NSDate *date = [NSDate date];
    
    NSDateFormatter  *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM-dd HH:mm:ss"];
    
    
    msg.time =  [formatter stringFromDate:date];
    msg.text = text;
    msg.type = type;
    
    //设置内容的frame
    MessageFrameModel *fm = [[MessageFrameModel alloc]init];
    //将msg 赋值给 fm 中的message
    fm.message = msg;
    [self.messages addObject:fm];
    
    //2.刷新表格
    [self.tableView reloadData];
    
    
    //3. 自动上移
    //移动的位置
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count - 1
                                           inSection:0];
    //真正去是位置 atSrcollPosition :  滚到位置
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}



//当键盘frame 发生改变的时候调用
- (void)keyboardDidChangeFrame:(NSNotification *)noti
{
    
    //改变window的背景颜色
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    //最终键盘的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //键盘实时y
    CGFloat keyY = frame.origin.y;
    
    //屏幕的高度
    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
    
    //动画时间
    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //执行动画
    [UIView animateWithDuration:keyDuration animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, keyY - screenH);
        
        //self.tableView.transform = CGAffineTransformMakeTranslation(0, screenH - keyY);
        
    }];
    
    
    
}

//当tableview 滚动的时候 结束编辑事件  （退出键盘）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}

//- (NSMutableArray *)messages
//{
//    if (_messages == nil) {
//
//        NSArray * array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
//
//        NSMutableArray *messageArr = [NSMutableArray array];
//        for (NSDictionary *dict in array) {
//            MessageModel *messga = [MessageModel messageWithDict:dict];
//
//            //取出上一个模型
//            MessageFrameModel *lastFm = [messageArr lastObject];
//
//            //隐藏时间
//            messga.hideTime = [messga.time isEqualToString:lastFm.message.time];
//
//            MessageFrameModel *fm = [[MessageFrameModel alloc]init];
//            fm.message = messga;
//
//            [messageArr addObject:fm];
//        }
//
//        _messages = messageArr;
//    }
//
//    return _messages;
//}

-(NSMutableArray *)messages {
    
    if (_messages == nil) {
        _messages = [NSMutableArray array];
    }
    
    return _messages;
}


////隐藏状态栏
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

#pragma mark tableview数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFrameModel *model = self.messages[indexPath.row];
    return model.cellH;//cell 的高度
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化cell
    MessageCell *cell = [MessageCell messageCellWithTableView:tableView];
    //取出model
    MessageFrameModel *model = self.messages[indexPath.row];
    //设置model
    cell.frameMessage = model;
    
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
