//
//  MessageCell.h
//  机器人聊天
//
//  Created by 谢飞 on 15/8/30.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageFrameModel;
@interface MessageCell : UITableViewCell

+ (instancetype)messageCellWithTableView:(UITableView *)tableview;

//frame 的模型
@property (nonatomic, strong)MessageFrameModel *frameMessage;

@end
