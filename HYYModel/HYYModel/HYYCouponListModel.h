//
//  HYYCouponListModel.h
//  HYYModel
//
//  Created by hu on 2019/4/20.
//  Copyright © 2019 huyiyong. All rights reserved.
//

#import "HYYModel.h"
#import "HYYCouponDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYYCouponListModel : HYYModel

@property (nonatomic,copy)NSArray <HYYCouponDetailModel*>*unuselist;
@property (nonatomic,copy)NSArray <HYYCouponDetailModel*>*uselist;
@property (nonatomic,copy)NSString *currentIndex;


@end

NS_ASSUME_NONNULL_END
