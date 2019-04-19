//
//  DEBUGKPLInfoViewController.m
//  Debug
//
//  Created by Shawn on 2017/12/6.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "DEBUGKPLInfoViewController.h"

@interface NSObject (TPKaiPuLeService)

+ (instancetype)shareService;

@property (nonatomic, copy) NSDictionary *kplInfo;

@end

@interface DEBUGKPLInfoViewController ()

@end

@implementation DEBUGKPLInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开普勒信息";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:self.view.bounds];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    id service = [NSClassFromString(@"TPKaiPuLeService") shareService];
    NSDictionary *infoDic = [service kplInfo];
    if (infoDic) {
        NSData *tempData = [NSJSONSerialization dataWithJSONObject:infoDic options:kNilOptions error:nil];
        NSString *tempString = [[NSString alloc]initWithData:tempData encoding:NSUTF8StringEncoding];
        label.text = tempString;
    }else
    {
        label.text = @"未读取到开普勒信息";
    }
}


@end
