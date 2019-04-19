//
//  ViewController.m
//  CustomDemo10
//
//  Created by hu on 2019/4/19.
//  Copyright © 2019 huyiyong. All rights reserved.
//

#import "ViewController.h"
#import <HYYBase/HYYBase.h>
#import <HYYBase/UIView+param.h>
#import <HYYBase/UIView+height.h>
#import <HYYBase/CustomView.h>
//#import "UIView+param.h"
#import <HYYHome/HYYHome.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HYYBase *base = [[HYYBase alloc] init];
    [base addTestCode];
    NSLog(@"look here : %@",base);
    [UIView viewBackGroundColor];
    [self.view getViewHeight];
    HYYHome *home = [HYYHome new];
    
}


@end
