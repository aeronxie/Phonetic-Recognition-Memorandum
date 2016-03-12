//
//  UIImage+ResizImage.m
//  机器人聊天
//
//  Created by 谢飞 on 15/8/30.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "UIImage+ResizImage.h"

@implementation UIImage (ResizImage)
+ (UIImage *)resizeWithImageName:(NSString *)name {
    
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat w = normal.size.width*0.5;
    CGFloat h = normal.size.height*0.5;
    //传入上下左右不需要拉升的边距，只拉伸/填铺中间部分
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];

}
@end
