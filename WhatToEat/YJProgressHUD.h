//
//  YJProgressHUD.h
//  CV7600
//
//  Created by Zhangguo Huang on 2018/1/31.
//  Copyright © 2018年 明星科技. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface YJProgressHUD : MBProgressHUD
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString*)warning;
+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)showHUD;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
@end
