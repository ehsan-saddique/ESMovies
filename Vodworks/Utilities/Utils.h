//
//  Utils.h
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface Utils : NSObject

NS_ASSUME_NONNULL_BEGIN

+(void)setupNavigationController:(UINavigationController *)navController;
+ (UIColor *)colorwithHexString:(NSString *)hexStr;
+(void)showLoaderInView:(UIView * _Nonnull)view;
+(MBProgressHUD *)showLoaderInView:(UIView * _Nonnull)view withText:(NSString * _Nullable)text;
+(void)hideLoaderOfView:(UIView *  _Nonnull)view;
+ (void) showAlertWithCancelButton:(NSString *)cancelText title:(NSString *)title message:(NSString *)message viewController:(UIViewController*)controller;
+ (void) setBorderOfView:(UIView *)view withBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)radius;
+ (NSString *)timeFormatted:(int)totalSeconds;
+ (BOOL) isEmpty:(id)thing;

NS_ASSUME_NONNULL_END

@end
