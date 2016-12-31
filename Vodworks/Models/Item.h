//
//  Movie.h
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewingWindow.h"
#import "Video.h"

@interface Item : NSObject

@property (nonatomic) NSString *skyGoUrl;
@property (nonatomic) NSString *skyGoId;
@property (nonatomic) NSString *sum;
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *reviewAuthor;
@property (nonatomic) NSString *mId;
@property (nonatomic) NSString *cert;
@property (nonatomic) NSString *year;
@property (nonatomic) int duration;
@property (nonatomic) NSString *mClass;
@property (nonatomic) int rating;
@property (nonatomic) NSString *headline;
@property (nonatomic) NSString *synopsis;
@property (nonatomic) NSString *body;
@property (nonatomic) NSString *lastUpdated;
@property (nonatomic) NSString *quote;
@property (nonatomic) ViewingWindow *viewingWindow;
@property (nonatomic) NSArray *genres;
@property (nonatomic) NSArray<NSDictionary *> *cardImages;
@property (nonatomic) NSArray<NSDictionary *> *keyArtImages;
@property (nonatomic) NSArray<NSDictionary *> *directors;
@property (nonatomic) NSArray<NSDictionary *> *cast;
@property (nonatomic) NSMutableArray<Video *> *videos;

@end
