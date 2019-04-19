//
//  XXDebugRoomViewController.m
//  Debug
//
//  Created by Shawn on 2017/12/11.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "XXDebugRoomViewController.h"

@interface NSObject (Router)

+ (instancetype)shareRouter;

- (UIViewController *)routerWithKey:(NSString *)key param:(NSDictionary *)param;

@end

@interface XXDebugRoomViewController ()

@property (nonatomic, weak) UITextField *textField;

@end

@implementation XXDebugRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"直播页面跳转";
    UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20, 31)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:textField];
    textField.placeholder = @"输入 room id";
    self.textField = textField;
    NSString *roomid = [[NSUserDefaults standardUserDefaults] objectForKey:@"kDebugLiveRoomIdCacheKey"];
    if (roomid.length) {
        self.textField.text = roomid;
    }

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, textField.frame.origin.y + textField.frame.size.height + 15, self.view.bounds.size.width - 20, 30);
    [btn setTitle:@"跳转" forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [btn addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)jumpAction
{
    [self.view endEditing:YES];
    NSString *roomId = self.textField.text;
    if (roomId.length) {
        [[NSUserDefaults standardUserDefaults] setValue:roomId forKey:@"kDebugLiveRoomIdCacheKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        id router = [NSClassFromString(@"TPRouter") shareRouter];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        [tempDic setValue:roomId forKey:@"room"];
        [router routerWithKey:@"live" param:tempDic];
    }];
}
@end
