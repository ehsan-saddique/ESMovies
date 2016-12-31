//
//  ItemDetailViewController.h
//  Vodworks
//
//  Created by Ehsan Saddique on 31/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) Item *item;

@end
