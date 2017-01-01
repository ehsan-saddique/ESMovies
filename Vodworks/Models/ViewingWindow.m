//
//  ViewingWindow.m
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import "ViewingWindow.h"
#import "Utils.h"

@implementation ViewingWindow

-(NSString *)title {
    return [Utils isEmpty:_title] ? @"" : _title;
}

-(NSString *)startDate {
    return [Utils isEmpty:_startDate] ? @"" : _startDate;
}

-(NSString *)endDate {
    return [Utils isEmpty:_endDate] ? @"" : _endDate;
}

-(NSString *)wayToWatch {
    return [Utils isEmpty:_wayToWatch] ? @"" : _wayToWatch;
}

@end
