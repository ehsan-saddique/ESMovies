//
//  STServiceManager.h
//  MyTradeMate
//
//  Created by Ehsan Saddique on 30/05/2016.
//  Copyright © 2016 Tracer Management Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
//#import "AFHTTPRequestOperation.h"
//#import "AFHTTPRequestOperationManager.h"

#warning Code Revive 
//move block definition to STBlockDefinition class
typedef void (^ServiceSuccessBlock)(id responseObject);
typedef void (^ServiceFailureBlock)(NSError *error);
//typedef void (^ServiceProgressBlock)(AFHTTPRequestOperation *operation, CGFloat percentage);

@interface ServiceManager : NSObject

@property (nonatomic, retain) AFHTTPSessionManager *sharedHTTPManager;

+ (instancetype)sharedManager;

- (void) startGETRequestWithURL:(NSString*)urlString andParameters:(NSDictionary*) parameters userInfo:(NSDictionary *)userinfo withSuccessCallback:(ServiceSuccessBlock)successCallBack andFailureCallBack:(ServiceFailureBlock)failureCallBack;

- (void) startPOSTRequestWithURL:(NSString*)urlString andParameters:(NSDictionary*) parameters withSuccessCallback:(ServiceSuccessBlock)successCallBack andFailureCallBack:(ServiceFailureBlock)failureCallBack;

@end
