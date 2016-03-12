//
//  MessageModel.h
//  机器人聊天
//
//  Created by 谢飞 on 15/8/30.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    MessageModelMe = 0,
    MessageModelrobot
}MessageModelType;
@interface MessageModel : NSObject

//正文
@property (nonatomic, copy)NSString *text;

//时间
@property (nonatomic, copy)NSString *time;

//发送类型
@property (nonatomic, assign)MessageModelType type;

//是否隐藏时间
@property (nonatomic,assign)BOOL hideTime;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end
