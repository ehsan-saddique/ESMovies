//
//  STServiceManager.m
//  MyTradeMate
//
//  Created by Ehsan Saddique on 30/05/2016.
//  Copyright © 2016 Tracer Management Systems. All rights reserved.
//

#import "ServiceManager.h"
//#import "STCommonMacros.h"
//#import "STApplicationSetup.h"

@implementation ServiceManager

+ (instancetype)sharedManager {
    static ServiceManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.sharedHTTPManager = [AFHTTPSessionManager manager];
        self.sharedHTTPManager.securityPolicy.allowInvalidCertificates = YES;
        self.sharedHTTPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
        
    }
    return self;
}



#pragma mark -
#pragma mark Request Handler
#pragma mark -


- (void) startGETRequestWithURL:(NSString*)urlString andParameters:(NSDictionary*) parameters userInfo:(NSDictionary *)userinfo withSuccessCallback:(ServiceSuccessBlock)successCallBack andFailureCallBack:(ServiceFailureBlock)failureCallBack
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSLog(@"Request URL : %@\nRequest Parameters : %@", url, parameters);
    
    AFHTTPSessionManager *operationManager = self.sharedHTTPManager;
    
    operationManager.securityPolicy.allowInvalidCertificates = YES;
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    [operationManager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        // Do not comment this line for QA Logs
        NSLog(@"Response string success: %@ ", responseObject);
        
        successCallBack(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Do not comment this line for QA Logs
        NSLog(@"Response string Failure: %@ \nError : %@", task.response, [error localizedDescription]);
        
        failureCallBack(error);
    }];
    
}


- (void) startPOSTRequestWithURL:(NSString*)urlString andParameters:(NSDictionary*) parameters withSuccessCallback:(ServiceSuccessBlock)successCallBack andFailureCallBack:(ServiceFailureBlock)failureCallBack
{
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSLog(@"Request URL : %@\nRequest Parameters : %@", url, parameters);
    
    AFHTTPSessionManager *operationManager = self.sharedHTTPManager;
    
    operationManager.securityPolicy.allowInvalidCertificates = YES;
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
    [operationManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        // Do not comment this line for QA Logs
        NSLog(@"Response string success: %@ ", task.response);
        
        successCallBack(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Do not comment this line for QA Logs
        NSLog(@"Response string Failure: %@ \nError : %@", task.response, [error localizedDescription]);
        
        failureCallBack(error);
    }];
    
}

@end
