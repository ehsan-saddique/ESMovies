//
//  ItemListTableViewCell.m
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import "ItemListTableViewCell.h"
#import "Utils.h"

@implementation ItemListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [Utils setBorderOfView:self.viewBackground withBorderWidth:0.4 borderColor:[UIColor clearColor] cornerRadius:4];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
