//
//  ItemLIstViewController.m
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import "ItemLIstViewController.h"
#import "ItemListTableViewCell.h"
#import "Utils.h"
#import "ApplicationManager.h"
#import "UIImageView+AFNetworking.h"
#import "ItemDetailViewController.h"

@interface ItemLIstViewController ()

@property (nonatomic) NSArray *items;

@end

@implementation ItemLIstViewController {
    BOOL dataLoaded;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Utils setupNavigationController:self.navigationController];
    self.title = @"Vodworks";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [Utils showLoaderInView:[UIApplication sharedApplication].keyWindow];
    
    [[ApplicationManager sharedManager] loadDataWithSuccessBlock:^(NSArray *items) {
        [Utils hideLoaderOfView:[UIApplication sharedApplication].keyWindow];
        self.items = items;
        dataLoaded = YES;
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        [Utils hideLoaderOfView:[UIApplication sharedApplication].keyWindow];
        [Utils showAlertWithCancelButton:@"OK" title:@"" message:error.localizedDescription viewController:self];
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (dataLoaded) {
        return _items.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ItemListTableViewCell"];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemListTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (dataLoaded) {
        
        Item *item = [_items objectAtIndex:indexPath.row];
        
        NSString *headline = item.headline;
        headline = [headline stringByAppendingString:[NSString stringWithFormat:@" (%@)", item.year]];
        cell.lblHeadline.text = headline;
        cell.lblRating.text = [NSString stringWithFormat:@"%i", item.rating];
        cell.lblRuntime.text = [Utils timeFormatted:item.duration];
        cell.lblCert.text = item.cert;
        cell.lblWayToWatch.text = item.viewingWindow.wayToWatch;
        cell.lblGenres.text = [item.genres componentsJoinedByString:@", "];
        
        NSMutableArray *castList = [NSMutableArray new];
        for (NSDictionary *castDict in item.cast) {
            [castList addObject:[castDict valueForKey:@"name"]];
        }
        cell.lblCast.text = [castList componentsJoinedByString:@", "];
        
        NSURL *url = [NSURL URLWithString:[item.keyArtImages[0] valueForKey:@"url"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIImage *placeholderImage = [UIImage imageNamed:@"placeholder_item_artwork"];
        
        __weak ItemListTableViewCell *weakCell = cell;
        
        [cell.imgArtwork setImageWithURLRequest:request
                               placeholderImage:placeholderImage
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                            
                                            weakCell.imgArtwork.image = image;
                                            [weakCell setNeedsLayout];
                                            
                                        } failure:nil];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Item *item = [_items objectAtIndex:indexPath.row];
    
    ItemDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];
    controller.item = item;
    [self.navigationController pushViewController:controller animated:YES];
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    return nil;
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//        return 0;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return [[UIView alloc] init];
//}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0;
//}



@end
