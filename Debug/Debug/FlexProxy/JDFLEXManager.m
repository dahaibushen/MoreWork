//
//  JDHTTPRequestProxyManager.m
//  Debug
//
//  Created by Shawn on 2017/7/7.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "JDFLEXManager.h"
#import "JDFLEXManager.h"
#import "XXDebugServiceManager.h"
#import "FLEXTableViewCell.h"

@implementation JDFLEXManager

+ (void)load
{
    [self shareFLEXManager];
    [[XXDebugServiceManager shareDebugServiceManager]registerClass:self];
}

+ (instancetype)shareFLEXManager
{
    static dispatch_once_t onceToken;
    static JDFLEXManager * manager;
    dispatch_once(&onceToken, ^{
        manager = [[JDFLEXManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _enable = NO;
    }
    return self;
}

#pragma mark -
+ (UITableViewCell *)debugPreferenceTableView:(UITableView *)tableView cell:(UITableViewCell *)cell
{
    FLEXTableViewCell *proxyCell = nil;
    if (![cell isKindOfClass:[FLEXTableViewCell class]]) {
        proxyCell = [[FLEXTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"FLEXTableViewCell"];
    }else
    {
        proxyCell = (FLEXTableViewCell *)cell;
    }
    proxyCell.textLabel.text = @"调试按钮";
   
    proxyCell.debugSwitch.on=[JDFLEXManager shareFLEXManager].enable;
    return proxyCell;
}

+ (NSString *)debugPreferenceTableViewReuseIdentify
{
    return @"FLEXTableViewCell";
}

@end
