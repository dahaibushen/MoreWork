//
//  NSTimer+gcd.h
//  2121
//
//  Created by hu on 2019/4/22.
//  Copyright © 2019 huyiyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TimerBlock)(void);

@interface NSTimer (gcd)

//该类是NSTimer 类型，但是该方法是GCD定时器

@property(nonatomic,copy)TimerBlock block;


/**
 @prama 创建定时器 dispatch_source 必须是一个成员变量不然创建即释放
 引用的文件需要创建如下对象
 dispatch_queue_t queue = dispatch_get_main_queue();
 self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
 */
+(void)startGCDTimer:(dispatch_source_t)source withBlock:(TimerBlock)block;

/**
 @prama 定时器取消
 */
+(void)cancelGCDTime:(dispatch_source_t)source;

@end

NS_ASSUME_NONNULL_END
