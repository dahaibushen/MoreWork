//
//  XXDebugButton.m
//  Debug
//
//  Created by Shawn on 2017/7/10.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "XXDebugButton.h"

@implementation XXDebugButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(_panGes:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)_panGes:(UIPanGestureRecognizer *)ges
{
    CGPoint point = [ges locationInView:self.superview];
    self.center = point;// CGPointMake(self.center.x + offset.x, self.center.y + offset.y);
}
@end
