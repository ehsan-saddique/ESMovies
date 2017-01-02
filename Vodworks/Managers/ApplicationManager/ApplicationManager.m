//
//  ApplicationManager.m
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import "ApplicationManager.h"
#import "Item.h"
#import "ServiceManager.h"
#import "Constant.h"

@implementation ApplicationManager

+ (instancetype)sharedManager {
    static ApplicationManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)loadDataWithSuccessBlock:(ApplicationSuccessBlock)successBlock failureBlock:(ApplicationFailureBlock)failureBlock {
    NSString *url = [URL_BASE stringByAppendingPathComponent:URL_GET_SHOWCASE];
    [[ServiceManager sharedManager] startGETRequestWithURL:url andParameters:nil userInfo:nil withSuccessCallback:^(id responseObject) {
        
        NSDictionary* response = (NSDictionary*)responseObject;
        BOOL success = [response valueForKey:@"success"];
        if (success) {
            NSArray *data = [response valueForKey:@"data"];
            NSMutableArray *itemList = [NSMutableArray new];
            
            for (NSDictionary *itemDictionary in data) {
                Item *item = [[Item alloc] init];
                item.skyGoUrl = [itemDictionary valueForKey:@"skyGoUrl"];
                item.skyGoId = [itemDictionary valueForKey:@"skyGoId"];
                item.sum = [itemDictionary valueForKey:@"sum"];
                item.url = [itemDictionary valueForKey:@"url"];
                item.mId = [itemDictionary valueForKey:@"id"];
                item.reviewAuthor = [itemDictionary valueForKey:@"reviewAuthor"];
                item.cert = [itemDictionary valueForKey:@"cert"];
                item.year = [itemDictionary valueForKey:@"year"];
                item.duration = [[itemDictionary valueForKey:@"duration"] intValue];
                item.rating = [[itemDictionary valueForKey:@"rating"] intValue];
                item.mClass = [itemDictionary valueForKey:@"class"];
                item.headline = [itemDictionary valueForKey:@"headline"];
                item.synopsis = [itemDictionary valueForKey:@"synopsis"];
                item.body = [itemDictionary valueForKey:@"body"];
                item.lastUpdated = [itemDictionary valueForKey:@"lastUpdated"];
                item.quote = [itemDictionary valueForKey:@"quote"];
                
                item.genres = [itemDictionary valueForKey:@"genres"];
                item.cardImages = [itemDictionary valueForKey:@"cardImages"];
                item.keyArtImages = [itemDictionary valueForKey:@"keyArtImages"];
                item.directors = [itemDictionary valueForKey:@"directors"];
                item.cast = [itemDictionary valueForKey:@"cast"];
                
                ViewingWindow *viewingWindow = [[ViewingWindow alloc] init];
                NSDictionary *viewingWindowDict = [itemDictionary valueForKey:@"viewingWindow"];
                viewingWindow.title = [viewingWindowDict valueForKey:@"title"];
                viewingWindow.startDate = [viewingWindowDict valueForKey:@"startDate"];
                viewingWindow.endDate = [viewingWindowDict valueForKey:@"endDate"];
                viewingWindow.wayToWatch = [viewingWindowDict valueForKey:@"wayToWatch"];
                item.viewingWindow = viewingWindow;
                
                NSArray *videosList = [itemDictionary valueForKey:@"videos"];
                item.videos = [NSMutableArray new];
                for (NSDictionary *videoDict in videosList) {
                    Video *video = [[Video alloc] init];
                    video.title = [videoDict valueForKey:@"title"];
                    video.type = [videoDict valueForKey:@"type"];
                    video.url = [videoDict valueForKey:@"url"];
                    video.alternatives = [videoDict valueForKey:@"alternatives"];
                    [item.videos addObject:video];
                }
                
                [itemList addObject:item];
            }
            successBlock(itemList);
        }
        else {
            failureBlock([NSError errorWithDomain:ERROR_DOMAIN code:999 userInfo:@{NSLocalizedDescriptionKey:@"There was an error while loading data from server."}]);
        }
        
    } andFailureCallBack:^(NSError *error) {
        failureBlock(error);
    }];
}

-(NSArray *)parseJsonData:(NSDictionary *)data {
    NSMutableArray *itemList = [NSMutableArray new];
    
    for (NSDictionary *itemDictionary in data) {
        Item *item = [[Item alloc] init];
        item.skyGoUrl = [itemDictionary valueForKey:@"skyGoUrl"];
        item.skyGoId = [itemDictionary valueForKey:@"skyGoId"];
        item.sum = [itemDictionary valueForKey:@"sum"];
        item.url = [itemDictionary valueForKey:@"url"];
        item.mId = [itemDictionary valueForKey:@"id"];
        item.reviewAuthor = [itemDictionary valueForKey:@"reviewAuthor"];
        item.cert = [itemDictionary valueForKey:@"cert"];
        item.year = [itemDictionary valueForKey:@"year"];
        item.duration = [[itemDictionary valueForKey:@"duration"] intValue];
        item.rating = [[itemDictionary valueForKey:@"rating"] intValue];
        item.mClass = [itemDictionary valueForKey:@"class"];
        item.headline = [itemDictionary valueForKey:@"headline"];
        item.synopsis = [itemDictionary valueForKey:@"synopsis"];
        item.body = [itemDictionary valueForKey:@"body"];
        item.lastUpdated = [itemDictionary valueForKey:@"lastUpdated"];
        item.quote = [itemDictionary valueForKey:@"quote"];
        
        item.genres = [itemDictionary valueForKey:@"genres"];
        item.cardImages = [itemDictionary valueForKey:@"cardImages"];
        item.keyArtImages = [itemDictionary valueForKey:@"keyArtImages"];
        item.directors = [itemDictionary valueForKey:@"directors"];
        item.cast = [itemDictionary valueForKey:@"cast"];
        
        ViewingWindow *viewingWindow = [[ViewingWindow alloc] init];
        NSDictionary *viewingWindowDict = [itemDictionary valueForKey:@"viewingWindow"];
        viewingWindow.title = [viewingWindowDict valueForKey:@"title"];
        viewingWindow.startDate = [viewingWindowDict valueForKey:@"startDate"];
        viewingWindow.endDate = [viewingWindowDict valueForKey:@"endDate"];
        viewingWindow.wayToWatch = [viewingWindowDict valueForKey:@"wayToWatch"];
        item.viewingWindow = viewingWindow;
        
        NSArray *videosList = [itemDictionary valueForKey:@"videos"];
        item.videos = [NSMutableArray new];
        for (NSDictionary *videoDict in videosList) {
            Video *video = [[Video alloc] init];
            video.title = [videoDict valueForKey:@"title"];
            video.type = [videoDict valueForKey:@"type"];
            video.url = [videoDict valueForKey:@"url"];
            video.alternatives = [videoDict valueForKey:@"alternatives"];
            [item.videos addObject:video];
        }
        
        [itemList addObject:item];
    }
    return itemList;
}

@end
