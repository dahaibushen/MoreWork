//
//  JDHTTPRequestProxyManager.h
//  Debug
//
//  Created by Shawn on 2017/7/7.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXDebugService.h"

@interface JDFLEXManager : NSObject<XXDebugService>

+ (instancetype)shareFLEXManager;

@property (nonatomic) BOOL enable;

@property (nonatomic, copy) NSString *proxyHost;

@end
