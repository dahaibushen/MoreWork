//
//  XXDebugService.h
//  Debug
//
//  Created by Shawn on 2017/7/7.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

@protocol XXDebugService <NSObject>

@required

+ (UITableViewCell *)debugPreferenceTableView:(UITableView *)tableView cell:(UITableViewCell *)cell;
@optional

/**
 获取debug 服务的 vc,一般用户debug 服务的首页 tableView 点击之后跳转的 vc

 @return UIViewController subclass
 */
+ (Class)debugServicePreferenceViewControllerClass;


+ (NSString *)debugPreferenceTableViewReuseIdentify;

+ (NSUInteger)debugPreferenceLevel;

@end

