//
//  VideoHeaderCollectionViewCellI.m
//  Vodworks
//
//  Created by Ehsan Saddique on 31/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import "VideoHeaderCollectionViewCell.h"

@implementation VideoHeaderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)playButtonClicked:(id)sender {
    self.playButtonTapHandler();
}


@end
