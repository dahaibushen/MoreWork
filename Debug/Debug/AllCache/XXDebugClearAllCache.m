//
//  XXDebugClearAllCache.m
//  Debug
//
//  Created by 程启帆 on 2018/6/19.
//  Copyright © 2018 Shawn. All rights reserved.
//

#import "XXDebugClearAllCache.h"
#import "XXDebugServiceManager.h"

@implementation XXDebugClearAllCache

+ (void)load
{
    [[XXDebugServiceManager shareDebugServiceManager]registerClass:self];
}

+ (UITableViewCell *)debugPreferenceTableView:(UITableView *)tableView cell:(UITableViewCell *)cell
{
    UITableViewCell *tempCell = [tableView dequeueReusableCellWithIdentifier:[self debugPreferenceTableViewReuseIdentify]];
    if (!tempCell) {
        tempCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[self debugPreferenceTableViewReuseIdentify]];
    }
    
    tempCell.textLabel.text = @"清除所有缓存";
//    NSURLCache *urlCache = [NSURLCache sharedURLCache];
//    NSUInteger bytes = urlCache.currentDiskUsage;
    
    tempCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *dirPaths = [XXDebugClearAllCache getDirPaths];
        CGFloat cacheSize = 0;
        for (NSString *cachPath in dirPaths) {
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            cacheSize += [XXDebugClearAllCache folderSizeAtPath:cachPath];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           tempCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fMB",(double)cacheSize];
        });
    });
    
    return tempCell;
}

/**
 获取debug 服务的 vc,一般用户debug 服务的首页 tableView 点击之后跳转的 vc
 
 @return UIViewController subclass
 */
+ (Class)debugServicePreferenceViewControllerClass
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *dirPaths = [XXDebugClearAllCache getDirPaths];
        for (NSString *cachPath in dirPaths) {
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            for (NSString *p in files) {
                NSError *error;
                NSString *path = [cachPath stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    BOOL isRemove= [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                    if (!isRemove) {
                        NSLog(@"%@删除失败",path);
                    }
                }
            }
        }
    });
    return nil;
}


+ (NSString *)debugPreferenceTableViewReuseIdentify
{
    return NSStringFromClass(self);
}

// 计算缓存文件夹大小
+ (float )folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

// 计算缓存文件大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (NSArray *)getDirPaths
{
    NSMutableArray *dirPaths = [NSMutableArray array];
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    if (cachPath.length > 0) {
        [dirPaths addObject:cachPath];
    }
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    if (cachPath.length > 0) {
        [dirPaths addObject:docPath];
    }
    
    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    if (cachPath.length > 0) {
        [dirPaths addObject:libPath];
    }
    
    NSString *tmpPath = NSTemporaryDirectory();
    if (cachPath.length > 0) {
        [dirPaths addObject:tmpPath];
    }
    
    return dirPaths.copy;
}

@end
