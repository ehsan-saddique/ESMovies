//
//  ItemLIstViewController.h
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemLIstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) IBOutlet UITableView *tableView;

@end
