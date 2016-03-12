//
//  MessageFrameModel.m
//  机器人聊天
//
//  Created by 谢飞 on 15/8/30.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "MessageFrameModel.h"
#import "Constant.h"
#import "MessageModel.h"
#import <UIKit/UIKit.h>
@implementation MessageFrameModel

- (void)setMessage:(MessageModel *)message
{
    _message = message;
    
    CGFloat padding = 10;
    //1. 时间
    if (message.hideTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = bScreenWidth;
        CGFloat timeH = bNormalH;
        
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    
    
    
    //2.头像
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconW = bIconW;
    CGFloat iconH = bIconH;
    
    if (message.type == MessageModelMe) {//自己发的
        
        iconX = bScreenWidth - iconW - padding;
        
    }else{//别人发的
        iconX = padding;
    }
    
    _iconF =  CGRectMake(iconX, iconY, iconW, iconH);
    
    //3.正文
    CGFloat textX;
    CGFloat textY = CGRectGetMaxY(_timeF);
    
    CGSize textMaxSize = CGSizeMake(150, MAXFLOAT);
    CGSize textRealSize = [message.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bBtnFont} context:nil].size;
    
    CGSize btnSize = CGSizeMake(textRealSize.width + 40, textRealSize.height + 40);
    
    if (message.type == MessageModelMe) {
        textX = bScreenWidth - iconW - padding*2 - btnSize.width;
    }else{
        textX = padding*2 + iconW;
    }

    _textViewF = (CGRect){{textX,textY},btnSize};
    
    //4.cell高度
    
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    CGFloat textMaxY = CGRectGetMaxY(_textViewF);
    
    _cellH = MAX(iconMaxY, textMaxY);
    
    
}

@end
