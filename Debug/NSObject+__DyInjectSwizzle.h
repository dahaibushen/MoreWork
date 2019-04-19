//
//  NSObject+__DyInjectSwizzle.h
//  DyInjectService
//
//  Created by Shawn on 2015/10/19.
//  Copyright © 2015年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (__DyInjectSwizzle)

+ (BOOL)___overrideMethod:(SEL)origSel withMethod:(SEL)altSel;

+ (BOOL)___overrideClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;

+ (BOOL)___exchangeMethod:(SEL)origSel withMethod:(SEL)altSel;

+ (BOOL)___exchangeClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;

@end
