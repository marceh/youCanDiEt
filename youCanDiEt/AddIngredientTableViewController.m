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
    self.parManager.arrayOfNamesOfAddedIngredients = [NSMutableArray new];
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
    
    if ([self checkIfAlreadyAddedBasedOnName:[activeData[indexPath.row] name]]) {
        cell.buttonAddRecipe.enabled = NO;
    } else {
        cell.buttonAddRecipe.enabled = YES;
    }

    cell.labelName.text = [activeData[indexPath.row] name];
    cell.productInformation = activeData[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.753 green:0.925 blue:0.98 alpha:1.0];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BackFromChooseIngredients"]) {
        self.parManager.editingRecipe = YES;
    }
}

-(BOOL)checkIfAlreadyAddedBasedOnName:(NSString *)name {
    BOOL tempBool = NO;
    for (NSString *string in self.parManager.arrayOfNamesOfAddedIngredients) {
        if ([string isEqualToString:name]) {
            tempBool = YES;
        }
    }
    return tempBool;
}

@end
