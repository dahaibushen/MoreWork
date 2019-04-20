//
//  HYYModel.m
//  HYYModel
//
//  Created by hu on 2019/4/20.
//  Copyright © 2019 huyiyong. All rights reserved.
//

#import "HYYModel.h"

@implementation HYYModel

+(JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"codeId":@"id"}];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end
