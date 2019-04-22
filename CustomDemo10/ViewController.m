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
#import <HYYModel/HYYModels.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HYYBase *base = [[HYYBase alloc] init];
    [base addTestCode];
    NSLog(@"look here : %@",base);
    [self.view getViewHeight];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestData];
}
-(void)requestData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"coupon" ofType:@"txt"];
    NSData * data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"data : %@ error: %@",obj,error);
    NSError *modelError;
    HYYCouponListModel *listModel = [[HYYCouponListModel alloc] initWithDictionary:obj error:&modelError];
    HYYCouponDetailModel *detailModel =  listModel.uselist.firstObject;
    NSLog(@"listmodel: %@",detailModel.codeId);
}


@end
