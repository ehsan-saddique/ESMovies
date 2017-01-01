//
//  Utils.m
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import "Utils.h"
#import "Constant.h"
#import "MBProgressHUD.h"

@implementation Utils

+(void)setupNavigationController:(UINavigationController *)navController {
    navController.navigationBar.barTintColor = [self colorwithHexString:COLOR_NAV_BAR];
    [navController.navigationBar setTranslucent:NO];
    navController.navigationBar.tintColor = [self colorwithHexString:COLOR_TINT_NAV_BAR];
    [navController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[self colorwithHexString:COLOR_NAV_BAR_TITLE]}];
}

+ (UIColor *)colorwithHexString:(NSString *)hexStr
{
    unsigned int hexint = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1];
    
    return color;
}

+(void)showLoaderInView:(UIView * _Nonnull)view {
    [self showLoaderInView:view withText:nil];
}

+(MBProgressHUD *)showLoaderInView:(UIView * _Nonnull)view withText:(NSString * _Nullable)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.2f];
    
    return hud;
}

+(void)hideLoaderOfView:(UIView *  _Nonnull)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void) showAlertWithCancelButton:(NSString *)cancelText title:(NSString *)title message:(NSString *)message viewController:(UIViewController*)controller {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:cancelText
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * _Nonnull action) {
                                   }];
    
    [alertController addAction:cancelAction];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

+ (void) setBorderOfView:(UIView *)view withBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)radius {
    [view.layer setBorderWidth:borderWidth];
    [view.layer setCornerRadius:radius];
    [view.layer setBorderColor:borderColor.CGColor];
}

+ (NSString *)timeFormatted:(int)totalSeconds
{
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%01d h %02d min", hours, minutes];
}

+ (BOOL) isEmpty:(id)thing {
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSDictionary *)thing count] == 0)
    || ([thing respondsToSelector:@selector(isKindOfClass:)]
        && [thing isKindOfClass:[NSNull class]] == YES);
}

@end
