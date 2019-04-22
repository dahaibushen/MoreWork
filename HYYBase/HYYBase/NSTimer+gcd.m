//
//  NSTimer+gcd.m
//  2121
//
//  Created by hu on 2019/4/22.
//  Copyright © 2019 huyiyong. All rights reserved.
//

#import "NSTimer+gcd.h"


@implementation NSTimer (gcd)

+(void)startGCDTimer:(dispatch_source_t)source withBlock:(TimerBlock)block {

     dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(source, start, interval, 0);
    dispatch_source_set_event_handler(source, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
        
            block();
            
        });
    });
    dispatch_resume(source);
}

+(void)cancelGCDTime:(dispatch_source_t)source{
     dispatch_source_cancel(source);
}

-(void)setBlock:(TimerBlock)block{
    objc_setAssociatedObject(self, "2222",block , OBJC_ASSOCIATION_COPY);
}

-(TimerBlock)block{
    return objc_getAssociatedObject(self, "2222");
}

@end
