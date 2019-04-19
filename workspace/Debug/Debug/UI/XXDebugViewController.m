//
//  XXDebugViewController.m
//  Debug
//
//  Created by Shawn on 2017/7/7.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "XXDebugViewController.h"
#import "XXDebugServiceManager.h"
#import "XXDebugButton.h"

@interface XXDebugViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSArray *classess;

@end

@implementation XXDebugViewController

static UIButton *tapMeBtn = nil;

+ (void)load
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        UIWindow *window = [[[UIApplication sharedApplication]windows]firstObject];
        tapMeBtn = [[XXDebugButton alloc]initWithFrame:CGRectMake(0,window.frame.size.height / 2, 50, 50)];
        [tapMeBtn setTitle:@"点我" forState:UIControlStateNormal];
        tapMeBtn.layer.cornerRadius = 25;
        tapMeBtn.backgroundColor = [UIColor redColor];
        [tapMeBtn addTarget:self action:@selector(enterDebugPage) forControlEvents:UIControlEventTouchUpInside];
        [window addSubview:tapMeBtn];
    }];
}

+ (void)enterDebugPage
{
    UITabBarController *tbc = (UITabBarController *)[[[UIApplication sharedApplication]windows]firstObject].rootViewController;
    XXDebugViewController *vc = [XXDebugViewController new];
    UINavigationController *nai = [[UINavigationController alloc]initWithRootViewController:vc];
    nai.navigationBar.translucent = NO;
    [tbc presentViewController:nai animated:YES completion:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"调试";
        self.hidesBottomBarWhenPushed = YES;
        tapMeBtn.hidden = YES;
    }
    return self;
}

- (void)dealloc
{
    tapMeBtn.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:tableView];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:0 target:self action:@selector(back)];
    self.tableView = tableView;
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.hidden == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    
    NSArray *registerClaaes = [[XXDebugServiceManager shareDebugServiceManager]debugServiceClasses];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < registerClaaes.count; i ++) {
        NSMutableDictionary * tempDic = [NSMutableDictionary dictionary];
        NSString * classText = registerClaaes[i];
        Class theClass = NSClassFromString(classText);
        if (!theClass) {
            continue;
        }
        NSInteger level = 0;
        if ([theClass respondsToSelector:@selector(debugPreferenceLevel)]) {
            level = [theClass debugPreferenceLevel];
        }
        [tempDic setObject:classText forKey:@(level)];
        [tempArray addObject:tempDic];
    }
    
    [tempArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *tempDic1 = (NSDictionary *)obj1;
        NSDictionary *tempDic2 = (NSDictionary *)obj2;
        return [[[tempDic1 allKeys]lastObject] compare:[[tempDic2 allKeys]lastObject]];
    }];
    
    NSMutableArray *allClassess = [NSMutableArray array];
    for (int i = 0; i < tempArray.count; i ++) {
        NSDictionary *tempDic = tempArray[i];
        [allClassess addObject:[[tempDic allValues]firstObject]];
    }
    
    self.classess = allClassess;
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.navigationController.navigationBar.hidden == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

#pragma mark -  UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classess.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = self.classess[indexPath.row];
    Class tempClass = NSClassFromString(className);
    NSString *reuseIdentify = @"UITableViewCell";
    if ([tempClass respondsToSelector:@selector(debugPreferenceTableViewReuseIdentify)]) {
        reuseIdentify = [tempClass debugPreferenceTableViewReuseIdentify];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    
    NSString *errorMsg = nil;
    if ([tempClass respondsToSelector:@selector(debugPreferenceTableView:cell:)]) {
        cell = [tempClass debugPreferenceTableView:tableView cell:cell];
        if (!cell) {
            errorMsg = [NSString stringWithFormat: @"Debug class %@ 没有正确返回 cell",className];
        }
    }else
    {
        errorMsg = [NSString stringWithFormat:@"Debug class %@ 没有实现对应的 cell 返回方法",className];
    }
    
    if (errorMsg) {
        cell.textLabel.text = errorMsg;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = self.classess[indexPath.row];
    Class tempClass = NSClassFromString(className);
    Class vcClass = nil;
    if ([tempClass respondsToSelector:@selector(debugServicePreferenceViewControllerClass)]) {
        vcClass = [tempClass debugServicePreferenceViewControllerClass];
    }
    
    if (vcClass && [vcClass isSubclassOfClass:[UIViewController class]]) {
        UIViewController *vc = [vcClass new];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

@end
