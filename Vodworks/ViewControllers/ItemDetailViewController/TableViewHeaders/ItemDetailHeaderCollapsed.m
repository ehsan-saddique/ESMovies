//
//  STQuoteTestHeader.m
//  MyTradeMate
//
//  Created by Ehsan Saddique on 26/04/2016.
//  Copyright © 2016 Tracer Management Systems. All rights reserved.
//

#import "ItemDetailHeaderCollapsed.h"

@implementation ItemDetailHeaderCollapsed

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [Utils setBorderOfView:self.viewBackground withBorderWidth:1 borderColor:[UIColor clearColor] cornerRadius:5];
    
}

- (IBAction)expandBtnClicked:(id)sender {
    self.btnExpandClicked();
}

@end
