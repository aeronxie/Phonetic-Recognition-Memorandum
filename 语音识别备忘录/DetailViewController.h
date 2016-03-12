//
//  DetailViewController.h
//  语音识别备忘录
//
//  Created by Fay on 15/7/28.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
@class IFlyRecognizerView;
@class PopupView;

@interface DetailViewController : UIViewController
@property (nonatomic, assign) NSInteger index;
@property (nonatomic,strong) IFlyRecognizerView * iflyRecognizerView;

@property (nonatomic,strong) PopupView          * popView;

@end
