//
//  ItemListCollectionViewCell.m
//  Vodworks
//
//  Created by Ehsan Saddique on 02/01/2017.
//  Copyright © 2017 Ehsan. All rights reserved.
//

#import "ItemListCollectionViewCell.h"

@implementation ItemListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ivCover.clipsToBounds = YES;
    self.ivCover.layer.cornerRadius = 5;
}

@end
