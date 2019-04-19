//
//  XXDebugServiceManager.h
//  Debug
//
//  Created by Shawn on 2017/7/7.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXDebugService.h"

@interface XXDebugServiceManager : NSObject

+ (instancetype)shareDebugServiceManager;

@property (nonatomic, copy, readonly) NSArray *debugServiceClasses;

- (void)registerClass:(Class)debugClass;

- (void)unregisterClass:(Class)debugClass;

@end
