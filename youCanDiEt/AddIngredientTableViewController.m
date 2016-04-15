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
    NSLog(@"inne i addIner");
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
    // Dispose of any resources that can be recreated.
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
        //cell.textLabel.text = [self.searchResult[indexPath.row] name];
        activeData = self.searchResult;
    } else {
        activeData = self.myProducts;
    }
    
    cell.labelName.text = [activeData[indexPath.row] name];
    cell.productInformation = activeData[indexPath.row];
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"nu skickar i med seque");
    MyTableViewCell *cell = sender;
    if (cell.gramsInformation == nil) {
        [self.parManager addProductToArrayOfIngredients:cell.productInformation andGrams:@100];
    } else {
        [self.parManager addProductToArrayOfIngredients:cell.productInformation andGrams:cell.gramsInformation];
    }
    //[self.parManager.arrayOfIngredients addObject:@"hej..."];
   //[segue.destinationViewController.arrayOfIngredients addObject:cell.productInformation];
    //segue.destinationViewController.title = [cell.productInformation name];
    //[self.recipesAddViewController.arrayOfIngredients addObject:cell.productInformation];

}


@end
