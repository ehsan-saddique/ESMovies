//
//  STQuoteTestHeader.h
//  MyTradeMate
//
//  Created by Ehsan Saddique on 26/04/2016.
//  Copyright © 2016 Tracer Management Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

typedef void (^BtnExpandClickHandler)();

@interface ItemDetailHeaderCollapsed : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIImageView *ivIconType;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;

@property (copy, nonatomic) BtnExpandClickHandler btnExpandClicked;

@end
