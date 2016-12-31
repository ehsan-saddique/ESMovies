//
//  ItemDetailViewController.m
//  Vodworks
//
//  Created by Ehsan Saddique on 31/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ItemDetailHeaderOverview.h"
#import "ItemDetailHeaderVideos.h"
#import "ItemDetailHeaderGallery.h"
#import "Utils.h"
#import "UIImageView+AFNetworking.h"

static NSString *idSectionHeaderOverview = @"ItemDetailHeaderOverview";
static NSString *idSectionHeaderVideo = @"ItemDetailHeaderVideo";
static NSString *idSectionHeaderGallery = @"ItemDetailHeaderGallery";

@interface ItemDetailViewController ()

typedef NS_ENUM(NSInteger,TableSection){
    TableSectionVideo = 0,
    TableSectionOverview,
    TableSectionGallery,
};

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib* nibHeaderOverview = [UINib nibWithNibName:@"ItemDetailHeaderOverview" bundle:nil];
    [self.tableView registerNib:nibHeaderOverview forHeaderFooterViewReuseIdentifier:idSectionHeaderOverview];
    
    UINib* nibHeaderVideo = [UINib nibWithNibName:@"ItemDetailHeaderVideos" bundle:nil];
    [self.tableView registerNib:nibHeaderVideo forHeaderFooterViewReuseIdentifier:idSectionHeaderVideo];

    UINib* nibHeaderGallery = [UINib nibWithNibName:@"ItemDetailHeaderGallery" bundle:nil];
    [self.tableView registerNib:nibHeaderGallery forHeaderFooterViewReuseIdentifier:idSectionHeaderGallery];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    STJobListTableViewCell *cell = (STJobListTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"STJobListTableViewCell"];
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == TableSectionOverview) {
        ItemDetailHeaderOverview* sectionHeader = (ItemDetailHeaderOverview*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:idSectionHeaderOverview];
        
        NSString *headline = _item.headline;
        headline = [headline stringByAppendingString:[NSString stringWithFormat:@" (%@)", _item.year]];
        sectionHeader.lblHeadline.text = headline;
        
        sectionHeader.lblSynopsis.text = _item.synopsis;
        
        NSString *runtime = [Utils timeFormatted:_item.duration];
        NSString *genres = [_item.genres componentsJoinedByString:@", "];
        sectionHeader.lblOneLineDetail.text = [NSString stringWithFormat:@"%@ | %@ | %@", _item.cert, runtime, genres];
        
        NSURL *url = [NSURL URLWithString:[_item.keyArtImages[0] valueForKey:@"url"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIImage *placeholderImage = [UIImage imageNamed:@"placeholder_item_artwork"];
        
        __weak ItemDetailHeaderOverview *weakSectionHeader = sectionHeader;
        
        [sectionHeader.imgArtwork setImageWithURLRequest:request
                               placeholderImage:placeholderImage
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                            
                                            weakSectionHeader.imgArtwork.image = image;
                                            [weakSectionHeader setNeedsLayout];
                                            
                                        } failure:nil];
        
        return sectionHeader;
    }
    else if (section == TableSectionVideo) {
        ItemDetailHeaderVideos* sectionHeader = (ItemDetailHeaderVideos*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:idSectionHeaderVideo];
        
        NSMutableArray *mediaDataset = [NSMutableArray new];
        [mediaDataset addObjectsFromArray:_item.videos];
        
        sectionHeader.mediaDataset = mediaDataset;
        
        return sectionHeader;
    }
    else if (section == TableSectionGallery) {
        ItemDetailHeaderGallery* sectionHeader = (ItemDetailHeaderGallery*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:idSectionHeaderGallery];
        
        NSMutableArray *mediaDataset = [NSMutableArray new];
        [mediaDataset addObjectsFromArray:_item.cardImages];
        
        sectionHeader.mediaDataset = mediaDataset;
        
        return sectionHeader;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0;
    switch (section) {
        case TableSectionOverview:
            height = 190;
            break;
            
        case TableSectionVideo:
            height = 160;
            break;
            
        case TableSectionGallery:
            height = 120;
            break;
    }
    
    return height;
}

@end
