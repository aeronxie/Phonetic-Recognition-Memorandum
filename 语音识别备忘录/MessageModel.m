//
//  MessageModel.m
//  机器人聊天
//
//  Created by 谢飞 on 15/8/30.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    MessageModel *model = [[MessageModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
    
   
}

@end
