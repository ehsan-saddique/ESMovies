//
//  STServiceManager.h
//  MyTradeMate
//
//  Created by Ehsan Saddique on 30/05/2016.
//  Copyright © 2016 Tracer Management Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

typedef void (^ServiceSuccessBlock)(id responseObject);
typedef void (^ServiceFailureBlock)(NSError *error);

@interface ServiceManager : NSObject

@property (nonatomic, retain) AFHTTPSessionManager *sharedHTTPManager;

+ (instancetype)sharedManager;

- (void) startGETRequestWithURL:(NSString*)urlString andParameters:(NSDictionary*) parameters userInfo:(NSDictionary *)userinfo withSuccessCallback:(ServiceSuccessBlock)successCallBack andFailureCallBack:(ServiceFailureBlock)failureCallBack;

- (void) startPOSTRequestWithURL:(NSString*)urlString andParameters:(NSDictionary*) parameters withSuccessCallback:(ServiceSuccessBlock)successCallBack andFailureCallBack:(ServiceFailureBlock)failureCallBack;

@end
