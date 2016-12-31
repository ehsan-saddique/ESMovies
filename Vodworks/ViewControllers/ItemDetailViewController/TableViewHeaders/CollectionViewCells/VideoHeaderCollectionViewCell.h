//
//  VideoHeaderCollectionViewCellI.h
//  Vodworks
//
//  Created by Ehsan Saddique on 31/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PlayButtonTapHandler)();

@interface VideoHeaderCollectionViewCell : UICollectionViewCell

@property (nonatomic) IBOutlet UIImageView *imgCardImage;

@property (nonatomic) PlayButtonTapHandler playButtonTapHandler;

@end
