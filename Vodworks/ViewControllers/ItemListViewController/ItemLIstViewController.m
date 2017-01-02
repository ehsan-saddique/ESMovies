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
#import "ItemListCollectionViewCell.h"

static NSString *idCollectionViewCell = @"ItemListCollectionViewCell";

@interface ItemLIstViewController ()

typedef NS_ENUM(NSInteger, LayoutType){
    LayoutTypeList = 0,
    LayoutTypeGrid,
};

@property(nonatomic) NSPredicate* searchPredicate;
@property(assign) BOOL isSearchActive;
@property (nonatomic, strong) UISearchController *searchController;
@property(nonatomic) NSArray *searchResults;
@property (nonatomic) NSArray *items;
@property (nonatomic) LayoutType currentLayout;

@end

@implementation ItemLIstViewController {
    BOOL dataLoaded;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Utils setupNavigationController:self.navigationController];
    self.title = @"Showcase";
    
    UINib* nibCollectionViewCell = [UINib nibWithNibName:@"ItemListCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nibCollectionViewCell forCellWithReuseIdentifier:idCollectionViewCell];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Grid View" style:UIBarButtonItemStylePlain target:self action:@selector(changeLayout)];
    
    self.searchResults = [NSArray new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.currentLayout = LayoutTypeList;
    
    [Utils showLoaderInView:[UIApplication sharedApplication].keyWindow];
    
    [[ApplicationManager sharedManager] loadDataWithSuccessBlock:^(NSArray *items) {
        [Utils hideLoaderOfView:[UIApplication sharedApplication].keyWindow];
        self.items = items;
        dataLoaded = YES;
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        [Utils hideLoaderOfView:[UIApplication sharedApplication].keyWindow];
        [Utils showAlertWithCancelButton:@"OK" title:@"" message:@"Couldn't load data from server. Local file data will be used." viewController:self];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"txt"];
        NSData *content = [[NSData alloc] initWithContentsOfFile:filePath];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:nil];
        self.items =  [[ApplicationManager sharedManager] parseJsonData:json];;
        dataLoaded = YES;
        [self.tableView reloadData];
    }];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.scopeButtonTitles = [NSArray array];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"Search";
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.collectionView.hidden = YES;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}

-(void)changeLayout {
    if (self.currentLayout == LayoutTypeList) {
        self.navigationItem.rightBarButtonItem.title = @"List View";
        self.currentLayout = LayoutTypeGrid;
        self.tableView.hidden = YES;
        self.collectionView.hidden = NO;
        [self.collectionView reloadData];
    }
    else {
        self.navigationItem.rightBarButtonItem.title = @"Grid View";
        self.currentLayout = LayoutTypeList;
        self.tableView.hidden = NO;
        self.collectionView.hidden = YES;
        [self.tableView reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (dataLoaded) {
        if (_isSearchActive) {
            return _searchResults.count;
        }
        else {
            return _items.count;
        }
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
        
        Item *item = [[Item alloc] init];
        if (_isSearchActive) {
            item = [_searchResults objectAtIndex:indexPath.row];
        }
        else {
            item = [_items objectAtIndex:indexPath.row];
        }
        
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
    Item *item = [[Item alloc] init];
    if (_isSearchActive) {
        item = [_searchResults objectAtIndex:indexPath.row];
    }
    else {
        item = [_items objectAtIndex:indexPath.row];
    }
    
    ItemDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];
    controller.item = item;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UISearchController

- (void)willPresentSearchController:(UISearchController *)searchController {
    [self.navigationController.navigationBar setTranslucent:YES];
}

-(void)willDismissSearchController:(UISearchController *)searchController
{
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    if (searchString.length == 0) {
        self.isSearchActive = NO;
        [self.tableView reloadData];
    }else{
        self.isSearchActive = YES;
        [self searchForText:searchString scope:self.searchController.searchBar.selectedScopeButtonIndex];
        [self.tableView reloadData];
    }
}

- (void)searchForText:(NSString *)searchText scope:(NSUInteger)scopeOption {
    self.searchPredicate = [NSPredicate predicateWithFormat:@"SELF.headline contains[c] %@", searchText];
    self.searchResults = [self.items filteredArrayUsingPredicate:self.searchPredicate];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _items.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90, 134);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ItemListCollectionViewCell *cell = (ItemListCollectionViewCell *) [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ItemListCollectionViewCell" forIndexPath:indexPath];
    
    Item *item = [_items objectAtIndex:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:[item.keyArtImages[0] valueForKey:@"url"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder_item_artwork"];
    
    __weak ItemListCollectionViewCell *weakCell = cell;
    
    [cell.ivCover setImageWithURLRequest:request
                           placeholderImage:placeholderImage
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                        
                                        weakCell.ivCover.image = image;
                                        [weakCell setNeedsLayout];
                                        
                                    } failure:nil];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Item *item = [_items objectAtIndex:indexPath.row];
    
    ItemDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];
    controller.item = item;
    [self.navigationController pushViewController:controller animated:YES];
    
}


@end
