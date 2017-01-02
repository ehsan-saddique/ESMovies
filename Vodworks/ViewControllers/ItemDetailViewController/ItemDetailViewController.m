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
#import "ItemDetailHeaderCollapsed.h"
#import "Utils.h"
#import "UIImageView+AFNetworking.h"
#import "ItemDetailExpandedTableViewCell.h"
#import "ImageViewerViewController.h"
#import "StoryDetailViewController.h"

static NSString *idSectionHeaderOverview = @"ItemDetailHeaderOverview";
static NSString *idSectionHeaderVideo = @"ItemDetailHeaderVideo";
static NSString *idSectionHeaderGallery = @"ItemDetailHeaderGallery";
static NSString *idSectionHeaderCollapsed = @"ItemDetailHeaderCollapsed";

@interface ItemDetailViewController ()

typedef NS_ENUM(NSInteger,TableSection){
    TableSectionVideo = 0,
    TableSectionOverview,
    TableSectionGallery,
    TableSectionCast,
    TableSectionDirector,
    TableSectionViewingWindow,
};

@end

@implementation ItemDetailViewController {
    BOOL isCastSectionCollapsed;
    BOOL isDirectorSectionCollapsed;
    BOOL isViewWindowSectionCollapsed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Info";
    
    UINib* nibHeaderOverview = [UINib nibWithNibName:@"ItemDetailHeaderOverview" bundle:nil];
    [self.tableView registerNib:nibHeaderOverview forHeaderFooterViewReuseIdentifier:idSectionHeaderOverview];
    
    UINib* nibHeaderVideo = [UINib nibWithNibName:@"ItemDetailHeaderVideos" bundle:nil];
    [self.tableView registerNib:nibHeaderVideo forHeaderFooterViewReuseIdentifier:idSectionHeaderVideo];

    UINib* nibHeaderGallery = [UINib nibWithNibName:@"ItemDetailHeaderGallery" bundle:nil];
    [self.tableView registerNib:nibHeaderGallery forHeaderFooterViewReuseIdentifier:idSectionHeaderGallery];
    
    UINib* nibHeaderCollapsed = [UINib nibWithNibName:@"ItemDetailHeaderCollapsed" bundle:nil];
    [self.tableView registerNib:nibHeaderCollapsed forHeaderFooterViewReuseIdentifier:idSectionHeaderCollapsed];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    
    isCastSectionCollapsed = YES;
    isDirectorSectionCollapsed = YES;
    isViewWindowSectionCollapsed = YES;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    if (section == TableSectionCast) {
        if (isCastSectionCollapsed) {
            rows = 0;
        }
        else {
            rows = _item.cast.count;
        }
    }
    else if (section == TableSectionDirector) {
        if (isDirectorSectionCollapsed) {
            rows = 0;
        }
        else {
            rows = _item.directors.count;
        }
    }
    else if (section == TableSectionViewingWindow) {
        if (isViewWindowSectionCollapsed) {
            rows = 0;
        }
        else {
            rows = 4;
        }
    }
    
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == TableSectionCast) {
        ItemDetailExpandedTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ItemDetailExpandedTableViewCell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemDetailExpandedTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSDictionary *cast = [_item.cast objectAtIndex:indexPath.row];
        cell.lblName.text = [cast valueForKey:@"name"];
        
        return cell;
    }
    else if (indexPath.section == TableSectionDirector) {
        ItemDetailExpandedTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ItemDetailExpandedTableViewCell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemDetailExpandedTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSDictionary *director = [_item.directors objectAtIndex:indexPath.row];
        cell.lblName.text = [director valueForKey:@"name"];
        
        return cell;
    }
    else if (indexPath.section == TableSectionViewingWindow) {
        ItemDetailExpandedTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ItemDetailExpandedTableViewCell"];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemDetailExpandedTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        switch (indexPath.row) {
            case 0:
                cell.lblName.text = [NSString stringWithFormat:@"Start Date : %@", _item.viewingWindow.startDate];
                break;
            case 1:
                cell.lblName.text = [NSString stringWithFormat:@"End Date : %@", _item.viewingWindow.endDate];
                break;
            case 2:
                cell.lblName.text = [NSString stringWithFormat:@"Way To Watch : %@", _item.viewingWindow.wayToWatch];
                break;
            case 3:
                cell.lblName.text = [NSString stringWithFormat:@"Title : %@", _item.viewingWindow.title];
                break;
        }
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    switch (indexPath.section) {
        case TableSectionCast:
            height = 44;
            break;
        case TableSectionDirector:
            height = 44;
            break;
        case TableSectionViewingWindow:
            height = 44;
            break;
    }
    return height;
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
        
        sectionHeader.textTapped = ^{
            StoryDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"StoryDetailViewController"];
            controller.synopsis = _item.synopsis;
            controller.plot = _item.body;
            controller.quote = _item.quote;
            [self.navigationController pushViewController:controller animated:YES];
        };
        
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
        
        sectionHeader.imageTapped = ^(UIImage *image) {
            ImageViewerViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageViewerViewController"];
            controller.img = image;
            UINavigationController *modelNavController = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.navigationController presentViewController:modelNavController animated:YES completion:nil];
        };
        
        return sectionHeader;
    }
    
    else if (section == TableSectionCast) {
        ItemDetailHeaderCollapsed* sectionHeader = (ItemDetailHeaderCollapsed*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:idSectionHeaderCollapsed];
        
        sectionHeader.lblDescription.text = @"Cast";
        
        if (isCastSectionCollapsed) {
            sectionHeader.ivIconType.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        else {
            sectionHeader.ivIconType.transform = CGAffineTransformMakeRotation(M_PI_2 + M_PI);
        }
        
        sectionHeader.btnExpandClicked = ^{
            isCastSectionCollapsed = !isCastSectionCollapsed;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        
        return sectionHeader;
    }
    
    else if (section == TableSectionDirector) {
        ItemDetailHeaderCollapsed* sectionHeader = (ItemDetailHeaderCollapsed*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:idSectionHeaderCollapsed];
        
        sectionHeader.lblDescription.text = @"Director";
        
        if (isDirectorSectionCollapsed) {
            sectionHeader.ivIconType.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        else {
            sectionHeader.ivIconType.transform = CGAffineTransformMakeRotation(M_PI_2 + M_PI);
        }
        
        sectionHeader.btnExpandClicked = ^{
            isDirectorSectionCollapsed = !isDirectorSectionCollapsed;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        
        return sectionHeader;
    }
    
    else if (section == TableSectionViewingWindow) {
        ItemDetailHeaderCollapsed* sectionHeader = (ItemDetailHeaderCollapsed*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:idSectionHeaderCollapsed];
        
        sectionHeader.lblDescription.text = @"Viewing Window";
        
        if (isViewWindowSectionCollapsed) {
            sectionHeader.ivIconType.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        else {
            sectionHeader.ivIconType.transform = CGAffineTransformMakeRotation(M_PI_2 + M_PI);
        }
        
        sectionHeader.btnExpandClicked = ^{
            isViewWindowSectionCollapsed = !isViewWindowSectionCollapsed;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        
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
            height = 104;
            break;
            
        case TableSectionCast:
            height = 50;
            break;
        case TableSectionDirector:
            height = 50;
            break;
        case TableSectionViewingWindow:
            height = 50;
            break;
    }
    
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0;
    switch (section) {
        case TableSectionCast:
            height = 10;
            break;
        case TableSectionDirector:
            height = 10;
            break;
//        case TableSectionViewingWindow:
//            height = 20;
//            break;
    }
    
    return height;
}

@end
