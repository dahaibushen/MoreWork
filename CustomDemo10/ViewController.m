//
//  ViewController.m
//  CustomDemo10
//
//  Created by hu on 2019/4/19.
//  Copyright © 2019 huyiyong. All rights reserved.
//

#import "ViewController.h"
#import <HYYBase/CustomView.h>
#import <HYYHome/HYYHome.h>
#import <HYYBase/BaseHeader.h>
#import <Masonry.h>
#import <AFNetworking.h>


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
    
}


@end
