//
//  XXDebugWillPreviewUlrService.m
//  Debug
//
//  Created by HU on 2017/12/26.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "XXDebugSimCrashService.h"
#import "XXDebugServiceManager.h"
#import "NSObject+__DyInjectSwizzle.h"


@implementation XXDebugSimCrashService

+ (void)load
{
    [[XXDebugServiceManager shareDebugServiceManager]registerClass:self];
}

+(instancetype)simCrashService{
    static XXDebugSimCrashService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (service == nil) {
            service = [XXDebugSimCrashService new];
        }
    });
    return service;
}

+ (UITableViewCell *)debugPreferenceTableView:(UITableView *)tableView cell:(UITableViewCell *)cell
{
    UITableViewCell *tempCell = [tableView dequeueReusableCellWithIdentifier:[self debugPreferenceTableViewReuseIdentify]];
    if (!tempCell) {
        tempCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[self debugPreferenceTableViewReuseIdentify]];
    }
    tempCell.textLabel.text = @"点击就闪退，就是任性";
    tempCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return tempCell;
}

/**
 获取debug 服务的 vc,一般用户debug 服务的首页 tableView 点击之后跳转的 vc
 
 @return UIViewController subclass
 */
+ (Class)debugServicePreferenceViewControllerClass
{
    NSMutableArray* list=[NSMutableArray array];
    [list addObject:nil];
    return nil;
}


+ (NSString *)debugPreferenceTableViewReuseIdentify
{
    return NSStringFromClass(self);
}

@end


