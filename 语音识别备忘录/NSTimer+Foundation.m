//
//  NSTimer+Foundation.m
//  语音识别备忘录
//
//  Created by Fay on 15/8/6.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "NSTimer+Foundation.h"

@implementation NSTimer (Foundation)

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}


@end
