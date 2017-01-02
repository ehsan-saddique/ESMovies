//
//  ApplicationManager.h
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ApplicationManager : NSObject

typedef void (^ApplicationSuccessBlock)(NSArray *items);
typedef void (^ApplicationFailureBlock)(NSError *error);

+ (instancetype)sharedManager;

-(void)loadDataWithSuccessBlock:(ApplicationSuccessBlock)successBlock failureBlock:(ApplicationFailureBlock)failureBlock;
-(NSArray *)parseJsonData:(NSDictionary *)data;

@end
