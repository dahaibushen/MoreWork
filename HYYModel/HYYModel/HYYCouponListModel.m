//
//  HYYCouponListModel.m
//  HYYModel
//
//  Created by hu on 2019/4/20.
//  Copyright © 2019 huyiyong. All rights reserved.
//

#import "HYYCouponListModel.h"

@implementation HYYCouponListModel

+(Class)classForCollectionProperty:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"unuselist"]||[propertyName isEqualToString:@"uselist"]) {
        return HYYCouponDetailModel.class;
    }
    return nil;
}

@end
