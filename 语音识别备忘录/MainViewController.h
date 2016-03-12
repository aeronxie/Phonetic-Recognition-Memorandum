//
//  MainViewController.h
//  语音识别备忘录
//
//  Created by Fay on 15/7/27.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITableViewController
@property(nonatomic,strong) NSMutableArray *noteArray;//备忘数组
@property(nonatomic,strong) NSMutableArray *dateArray;//时间数组
@property(nonatomic,strong) NSMutableArray *countDateArray;//倒计时数组
@end
