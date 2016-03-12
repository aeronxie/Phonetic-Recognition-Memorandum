//
//  MessageCell.m
//  机器人聊天
//
//  Created by 谢飞 on 15/8/30.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "MessageCell.h"
#import "MessageFrameModel.h"
#import "MessageModel.h"
#import "Constant.h"
#import "UIImage+ResizImage.h"
@interface MessageCell()
//时间
@property (nonatomic, weak)UILabel *time;
//正文
@property (nonatomic, weak)UIButton *textView;
//用户头像
@property (nonatomic, weak)UIImageView *icon;

@end

@implementation MessageCell
+ (instancetype)messageCellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"messageCell";
    MessageCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.时间
        UILabel *time = [[UILabel alloc]init];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:time];
        self.time = time;
        
        //1.正文
        UIButton *textView = [[UIButton alloc]init];
        textView.titleLabel.font = bBtnFont;
        textView.titleLabel.numberOfLines = 0;//自动换行
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //1.头像
        UIImageView *icon = [[UIImageView alloc]init];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 25.0;
        icon.layer.borderColor = [UIColor whiteColor].CGColor;
        icon.layer.borderWidth = 1.0;
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

//设置内容和frame
- (void)setFrameMessage:(MessageFrameModel *)frameMessage
{
    _frameMessage = frameMessage;
    
    MessageModel *model = frameMessage.message;
    
    //1.时间
    self.time.frame = frameMessage.timeF;
    self.time.text = model.time;
    
    //2.头像
    self.icon.frame = frameMessage.iconF;
    if (model.type == MessageModelMe) {
        self.icon.image = [UIImage imageNamed:@"me.jpg"];
    }else{
        self.icon.image = [UIImage imageNamed:@"robot.jpg"];
    }
    
    //3.正文
    self.textView.frame = frameMessage.textViewF;
    [self.textView setTitle:model.text forState:UIControlStateNormal];
    
    
    if (model.type == MessageModelMe) {
        
        [self.textView setBackgroundImage:[UIImage resizeWithImageName:@"chat_send_nor"] forState:UIControlStateNormal];
    }else{
        [self.textView setBackgroundImage:[UIImage resizeWithImageName:@"chat_recive_nor"] forState:UIControlStateNormal];
    }
    
}

//返回一个可拉伸的图片



@end
