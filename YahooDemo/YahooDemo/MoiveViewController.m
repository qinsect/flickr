//
//  ViewController.m
//  YahooDemo
//
//  Created by Yanfeng Ma on 9/12/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import "MoiveViewController.h"
#import "MovieCells.h"
#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MovieCollectionViewCell.h"
#import "Movie.h"
#import "MBProgressHUD.h"

// [MBProgressHUD showHUDAddedTo:self.view animated:YES]

@interface MoiveViewController ()
@property (weak, nonatomic) IBOutlet UITableView *movieTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *movieCollectionView;
@property (nonatomic, copy) UISearchBar* searchBar;

@property (nonatomic, retain) DataStore* dataStore;
@property (nonatomic, copy) NSArray* movieItem;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoiveViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataStore = [DataStore sharedInstance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.dataStore) {
        self.dataStore = [DataStore sharedInstance];
    }
    
    self.movieTableView.delegate = self;
    self.movieTableView.dataSource = self;
    [self.view addSubview:self.movieTableView];
    [self.view addSubview:self.movieCollectionView];
    
    self.movieCollectionView.delegate = self;
    self.movieCollectionView.dataSource = self;
    
    //
    self.movieCollectionView.hidden = YES;
    
    // pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Pull to Refresh", @"Pull to Refresh")];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.movieTableView insertSubview:self.refreshControl atIndex:0];
//    [self.movieCollectionView insertSubview:self.refreshControl atIndex:0];
    
    // Infinite footer
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.movieTableView.bounds.size.width, 50)];
    UIActivityIndicatorView *loadingView =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadingView startAnimating];
    loadingView.center = tableFooterView.center;
    [tableFooterView addSubview:loadingView];
    self.movieTableView.tableFooterView = tableFooterView;
    
    _searchBar = [[UISearchBar alloc] initWithFrame:self.movieTableView.bounds];
    [_searchBar sizeToFit];
    [_searchBar setPlaceholder:@"Search ..."];
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
    self.movieItem = [_dataStore getMovies:^(NSArray *array) {
        if(array) {
            self.movieItem = array;
            [self refreshViewController];
        }
    } type:self.movieType force:false];
    
    if (self.movieItem) {
        [self refreshViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark collectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection: (NSInteger)section {
    if (self.movieItem) {
        NSLog(@"=== number of data in tableview %lu", (unsigned long)[self.movieItem count]);
        return [self.movieItem count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = (MovieCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionViewCell" forIndexPath:indexPath];
    
    if ([_movieItem count] > indexPath.row) {
        Movie* movie = [_movieItem objectAtIndex:indexPath.row];
        [cell.movieImageView setImageWithURL: [NSURL URLWithString: [movie posterPath]]];
    }
    
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    return cell;
}

#pragma mark -
#pragma mark tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.movieItem) {
        NSLog(@"=== number of data in tableview %lu", (unsigned long)[self.movieItem count]);
        return [self.movieItem count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"enter to here");
    
    static NSString *MyIdentifier = @"MovieCells";
    MovieCells *cell = [self.movieTableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    
    if ([_movieItem count] > indexPath.row) {
        Movie* movie = [_movieItem objectAtIndex:indexPath.row];
        cell.title.text = [movie title];
        cell.content.text = [movie overview];
        NSLog(@"path: %@", [movie posterPath]);
        [cell.movieImageView setImageWithURL: [NSURL URLWithString: [movie posterPath]]];
    }
    else {
        cell.title.text = @"Empty !";
    }
    
    return cell;
}

#pragma mark -
#pragma mark segueNavigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.movieTableView indexPathForCell:cell];
    MovieDetailViewController *vc = segue.destinationViewController;
    vc.movie = [self.movieItem objectAtIndex:indexPath.row];
    NSLog(@"Enter to prepareForSegue");
}


#pragma mark -
#pragma mark UISearchBar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    NSLog(@"Text change - %d",isSearching);
    
    //Remove all objects first.
//    [filteredContentList removeAllObjects];
    
    if([searchText length] != 0) {
        self.movieItem = [_dataStore filterMoviesByKeyWord:searchText movieType:self.movieType];
        
        if (self.movieType) {
            [self refreshViewController];
        }
//        isSearching = YES;
//        [self searchTableList];
    }
    else {
//        isSearching = NO;
    }
    // [self.tblContentList reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
//    [self searchTableList];
}

#pragma mark -
#pragma mark PullToRefresh

- (void)onRefresh {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_dataStore getMovies:^(NSArray *array) {
        if(array) {
            self.movieItem = array;
            [self refreshViewController];
            [self.refreshControl endRefreshing];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    } type:self.movieType force:true];
}

#pragma mark -
#pragma mark SwitchButton

- (IBAction)onSelectSwitch:(id)sender {
    if (self.movieCollectionView.hidden) {
        self.movieCollectionView.hidden = NO;
        self.movieTableView.hidden = YES;
    }
    else {
        self.movieCollectionView.hidden = YES;
        self.movieTableView.hidden = NO;
    }
}

- (void) refreshViewController {
    [self.movieTableView reloadData];
    [self.movieCollectionView reloadData];
}

@end
