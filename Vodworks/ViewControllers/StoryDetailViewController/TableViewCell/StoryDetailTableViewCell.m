//
//  StoryDetailTableViewCell.m
//  Vodworks
//
//  Created by Ehsan Saddique on 02/01/2017.
//  Copyright © 2017 Ehsan. All rights reserved.
//

#import "StoryDetailTableViewCell.h"
#import "Utils.h"

@implementation StoryDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Utils setBorderOfView:self.viewBackground withBorderWidth:0 borderColor:[UIColor clearColor] cornerRadius:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
