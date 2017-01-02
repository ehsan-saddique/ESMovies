//
//  ItemLIstViewController.h
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemLIstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) IBOutlet UICollectionView *collectionView;

@end
