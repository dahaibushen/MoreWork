//
//  XXDebugServiceManager.m
//  Debug
//
//  Created by Shawn on 2017/7/7.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "XXDebugServiceManager.h"

@interface XXDebugServiceManager ()
{
    NSMutableArray * _classStringes;
}
@end

@implementation XXDebugServiceManager

+ (instancetype)shareDebugServiceManager
{
    static dispatch_once_t onceToken;
    static XXDebugServiceManager * manager;
    dispatch_once(&onceToken, ^{
        manager = [[XXDebugServiceManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _classStringes = [NSMutableArray array];
    }
    return self;
}

- (void)registerClass:(Class)debugClass
{
    if (!debugClass) {
        return;
    }
    NSString *classString = NSStringFromClass(debugClass);
    @synchronized (_classStringes) {
        if (![_classStringes containsObject:classString]) {
            [_classStringes addObject:classString];
        }
    }
}

- (void)unregisterClass:(Class)debugClass
{
    if (!debugClass) {
        return;
    }
    NSString *classString = NSStringFromClass(debugClass);
    @synchronized (_classStringes) {
        [_classStringes removeObject:classString];
    }
}

- (NSArray *)debugServiceClasses
{
    NSArray * tempArray = nil;
    @synchronized (_classStringes) {
        tempArray = [_classStringes copy];
    }
    return tempArray;
}

@end
