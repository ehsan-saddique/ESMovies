//
//  VideoHeaderCollectionViewCellI.m
//  Vodworks
//
//  Created by Ehsan Saddique on 31/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import "GalleryHeaderCollectionViewCell.h"

@implementation GalleryHeaderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer* imageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self addGestureRecognizer:imageTapGesture];
}

-(void)imageTapped:(UITapGestureRecognizer *)sender{
    self.imageTapHandler();
}

@end
