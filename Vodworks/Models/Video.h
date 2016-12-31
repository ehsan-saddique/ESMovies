//
//  Video.h
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *url;
@property (nonatomic) NSMutableArray<NSDictionary *> *alternatives;

@end
