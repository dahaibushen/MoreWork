//
//  ProxyTableViewCell.m
//  Debug
//
//  Created by Shawn on 2017/7/7.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "FLEXTableViewCell.h"
#import "JDFLEXManager.h"
#import "JDFLEXManager.h"
//#import <Masonry.h>

@implementation FLEXTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.debugSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    [self addSubview:self.debugSwitch];
    __weak id weakSelf=self;
//    [self.debugSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(weakSelf).offset(-20);
//        make.centerY.mas_equalTo(weakSelf);
//    }];
    [self.debugSwitch addTarget:self action:@selector(debugSwitchChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)debugSwitchChanged:(UISwitch*)sender{
    [JDFLEXManager shareFLEXManager].enable=sender.on;
//    if ([JDFLEXManager shareFLEXManager].enable) {
//        [[FLEXManager sharedManager] showExplorer];
//    }else
//    {
//        [[FLEXManager sharedManager] hideExplorer];
//    }
}

@end
