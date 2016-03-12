//
//  NSTimer+Foundation.h
//  语音识别备忘录
//
//  Created by Fay on 15/8/6.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Foundation)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
