//
//  AddIngredientTableViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-03-29.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "AddIngredientTableViewController.h"
#import "PARMananger.h"
#import "Product.h"
#import "MyTableViewCell.h"


@interface AddIngredientTableViewController ()

@property NSArray *myProducts;
@property NSArray *searchResult;
@property PARMananger *parManager;
@property UISearchController *searchContoller;

@end

@implementation AddIngredientTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    self.myProducts = self.parManager.products;
    self.searchContoller = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchContoller.searchResultsUpdater = self;
    self.definesPresentationContext = YES;
    self.searchContoller.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchContoller.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSPredicate *findProducts = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    
    self.searchResult = [self.myProducts filteredArrayUsingPredicate:findProducts];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchContoller.isActive && self.searchContoller.searchBar.text.length > 0) {
        return self.searchResult.count;
    } else {
        return self.myProducts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *activeData;
    
    if (self.searchContoller.isActive && self.searchContoller.searchBar.text.length > 0) {
        activeData = self.searchResult;
    } else {
        activeData = self.myProducts;
    }
    
    cell.labelName.text = [activeData[indexPath.row] name];
    cell.productInformation = activeData[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MyTableViewCell *cell = sender;
    if (cell.gramsInformation == nil) {
        [self.parManager addProductToArrayOfIngredients:cell.productInformation andGrams:@100];
    } else {
        [self.parManager addProductToArrayOfIngredients:cell.productInformation andGrams:cell.gramsInformation];
    }
    
}

@end
