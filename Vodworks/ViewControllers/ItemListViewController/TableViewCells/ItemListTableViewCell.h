//
//  ItemListTableViewCell.h
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemListTableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UIImageView *imgArtwork;
@property (nonatomic) IBOutlet UIView *viewBackground;
@property (nonatomic) IBOutlet UILabel *lblHeadline;
@property (nonatomic) IBOutlet UILabel *lblRating;
@property (nonatomic) IBOutlet UILabel *lblCert;
@property (nonatomic) IBOutlet UILabel *lblRuntime;
@property (nonatomic) IBOutlet UILabel *lblGenres;
@property (nonatomic) IBOutlet UILabel *lblWayToWatch;
@property (nonatomic) IBOutlet UILabel *lblCast;

@end
