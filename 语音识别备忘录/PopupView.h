//
//  PopupView.h
//  语音识别备忘录
//
//  Created by Fay on 15/7/28.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupView : UIView
{
    UILabel *_textLabel;
    int     _queueCount;
    
}
@property (strong) UIView*  ParentView;
- (void) setText:(NSString *) text;

@end
