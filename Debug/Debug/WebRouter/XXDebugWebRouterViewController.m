//
//  XXDebugWebRouterViewController.m
//  Debug
//
//  Created by Shawn on 2017/12/11.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "XXDebugWebRouterViewController.h"

@interface NSObject (Router)

+ (instancetype)shareRouter;

- (UIViewController *)routerWithKey:(NSString *)key param:(NSDictionary *)param;

- (UIViewController *)routerWithUrl:(NSURL *)url;

@end

@interface XXDebugWebRouterViewController ()

@property (nonatomic, weak) UITextField *textField;

@end

@implementation XXDebugWebRouterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页跳转";
    self.view.backgroundColor = [UIColor whiteColor];
    UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20, 31)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:textField];
    textField.placeholder = @"输入你需要跳转的链接,记住要带 http 协议头";
    self.textField = textField;
    
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
    NSString *url = self.textField.text;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        id router = [NSClassFromString(@"TPRouter") shareRouter];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        if ([url hasPrefix:@"http"]) {
            [tempDic setValue:url forKey:@"url"];
            [router routerWithKey:@"web" param:tempDic];
        }else
        {
            NSURL *tempRouterUrl = [NSURL URLWithString:url];
            if (tempRouterUrl == nil) {
                tempRouterUrl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
            [router routerWithUrl:tempRouterUrl];
        }
    }];
}

@end
