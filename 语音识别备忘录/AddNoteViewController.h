//
//  AddNoteViewController.h
//  语音识别备忘录
//
//  Created by Fay on 15/7/27.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyRecognizerViewDelegate.h"

@class IFlyRecognizerView;
@class PopupView;
/**
 有UI语音识别demo
 使用该功能仅仅需要四步
 1.创建识别对象；
 2.设置识别参数；
 3.有选择的实现识别回调；
 4.启动识别
 */

@interface AddNoteViewController : UIViewController<IFlyRecognizerViewDelegate>

//带界面的听写识别对象

@property (nonatomic,strong) IFlyRecognizerView * iflyRecognizerView;

@property (nonatomic,strong) PopupView          * popView;

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end
