//
//  StoryDetailViewController.h
//  Vodworks
//
//  Created by Ehsan Saddique on 02/01/2017.
//  Copyright © 2017 Ehsan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSString *synopsis;
@property (nonatomic) NSString *plot;
@property (nonatomic) NSString *quote;

@end
