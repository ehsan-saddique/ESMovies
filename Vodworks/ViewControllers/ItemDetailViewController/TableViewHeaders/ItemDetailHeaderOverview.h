//
//  ItemDetailHeaderOverview.h
//  Vodworks
//
//  Created by Ehsan Saddique on 31/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailHeaderOverview : UITableViewHeaderFooterView

@property (nonatomic) IBOutlet UIImageView *imgArtwork;
@property (nonatomic) IBOutlet UIView *viewBackground;
@property (nonatomic) IBOutlet UILabel *lblHeadline;
@property (nonatomic) IBOutlet UILabel *lblOneLineDetail;
@property (nonatomic) IBOutlet UILabel *lblSynopsis;

@end
