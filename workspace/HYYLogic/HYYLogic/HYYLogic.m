//
//  HYYLogic.m
//  HYYLogic
//
//  Created by hu on 2019/4/19.
//  Copyright © 2019 hu. All rights reserved.
//

#import "HYYLogic.h"


@implementation HYYLogic

+(instancetype)shareManager{
    static HYYLogic *logic;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        if (!logic) {
            logic = [[HYYLogic alloc] init];
        }
    });
    return logic;
}



@end
