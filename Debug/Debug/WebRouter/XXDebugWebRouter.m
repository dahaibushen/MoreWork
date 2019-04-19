//
//  XXDebugWebRouter.m
//  Debug
//
//  Created by Shawn on 2017/12/11.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "XXDebugWebRouter.h"
#import "XXDebugServiceManager.h"

@implementation XXDebugWebRouter

+ (void)load
{
    [[XXDebugServiceManager shareDebugServiceManager]registerClass:self];
}

+ (UITableViewCell *)debugPreferenceTableView:(UITableView *)tableView cell:(UITableViewCell *)cell
{
    UITableViewCell *tempCell = [tableView dequeueReusableCellWithIdentifier:[self debugPreferenceTableViewReuseIdentify]];
    if (!tempCell) {
        tempCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[self debugPreferenceTableViewReuseIdentify]];
    }
    tempCell.textLabel.text = @"网页跳转";
    tempCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return tempCell;
}

/**
 获取debug 服务的 vc,一般用户debug 服务的首页 tableView 点击之后跳转的 vc
 
 @return UIViewController subclass
 */
+ (Class)debugServicePreferenceViewControllerClass
{
    return NSClassFromString(@"XXDebugWebRouterViewController");
}


+ (NSString *)debugPreferenceTableViewReuseIdentify
{
    return NSStringFromClass(self);
}

@end
