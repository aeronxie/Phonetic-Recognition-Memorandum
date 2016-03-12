//
//  MessageFrameModel.h
//  机器人聊天
//
//  Created by 谢飞 on 15/8/30.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MessageModel;
@interface MessageFrameModel : NSObject

//时间的frame
@property (nonatomic, assign,readonly)CGRect timeF;

//正文的frame
@property (nonatomic, assign,readonly)CGRect textViewF;

//图片
@property (nonatomic, assign,readonly)CGRect iconF;

//cell
@property (nonatomic, assign,readonly)CGFloat cellH;

//数据模型
@property (nonatomic, strong)MessageModel *message;
@end
