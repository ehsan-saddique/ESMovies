//
//  ItemDetailHeaderVideos.h
//  Vodworks
//
//  Created by Ehsan Saddique on 31/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"

@interface ItemDetailHeaderVideos : UITableViewHeaderFooterView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) IBOutlet UIButton *btnPlay;

@property (nonatomic) NSArray *mediaDataset;

@end
