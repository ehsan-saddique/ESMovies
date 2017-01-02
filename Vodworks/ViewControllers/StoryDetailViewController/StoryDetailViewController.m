//
//  StoryDetailViewController.m
//  Vodworks
//
//  Created by Ehsan Saddique on 02/01/2017.
//  Copyright © 2017 Ehsan. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "StoryDetailTableViewCell.h"
#import "StoryDetailHeaderTitle.h"
#import <UIKit/UIKit.h>

static NSString *idSectionHeaderTitle = @"StoryDetailHeaderTitle";

@interface StoryDetailViewController ()

typedef NS_ENUM(NSInteger,TableSection){
    TableSectionQuote = 0,
    TableSectionTitle,
    TableSectionPlot,
};

@end

@implementation StoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Review";
    
    UINib* nibHeaderTitle = [UINib nibWithNibName:@"StoryDetailHeaderTitle" bundle:nil];
    [self.tableView registerNib:nibHeaderTitle forHeaderFooterViewReuseIdentifier:idSectionHeaderTitle];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryDetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"StoryDetailTableViewCell"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StoryDetailTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (indexPath.section == TableSectionQuote) {
        cell.lblText.text = self.quote;
    }
    else if (indexPath.section == TableSectionTitle) {
        cell.lblText.text = self.synopsis;
    } else {
        cell.lblText.text = self.plot;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (indexPath.section == TableSectionQuote) {
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        
        CGSize expectedLabelSize = [self.quote sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        
        height = expectedLabelSize.height+32;
    }
    else if (indexPath.section == TableSectionTitle) {
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        
        CGSize expectedLabelSize = [self.synopsis sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        
        height = expectedLabelSize.height+16;
    }
    else {
        CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        
        CGSize expectedLabelSize = [self.plot sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        
        height = expectedLabelSize.height-20;
        if (height <= 0) {
            height = 20;
        }
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    StoryDetailHeaderTitle* sectionHeader = (StoryDetailHeaderTitle*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:idSectionHeaderTitle];
    if (section == TableSectionQuote) {
        sectionHeader.lblTitle.text = @"Quote";
    }
    else if (section == TableSectionTitle) {
        sectionHeader.lblTitle.text = @"Synopsis";
    }
    else {
        sectionHeader.lblTitle.text = @"Review";
    }
    
    return sectionHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 40;
    
    return height;
}

@end
