//
//  ProductInfoTableViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "ProductInfoTableViewController.h"
#import "PARMananger.h"
#import "APIManager.h"
#import "Product.h"

@interface ProductInfoTableViewController ()
@property (nonatomic) PARMananger *parManager;
@property (nonatomic) APIManager *apiManager;

@end

@implementation ProductInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Getting the singleton that manages the arrays...
    self.parManager = [PARMananger getPARManager];
    self.apiManager = [APIManager getAPIManager];
    
    //Testing to create fake values...
    Product *p1 = [[Product alloc]initWithDictionary:@{@"name" : @"Product 1", @"kcal" : @120, @"carbs" : @54, @"protein" : @34, @"fat" : @3.2}];
    Product *p2 = [[Product alloc]initWithDictionary:@{@"name" : @"Product 2", @"kcal" : @220, @"carbs" : @64, @"protein" : @22, @"fat" : @54.2}];
    Product *p3 = [[Product alloc]initWithDictionary:@{@"name" : @"Product 3", @"kcal" : @666, @"carbs" : @84, @"protein" : @54, @"fat" : @43.45}];
    [self.parManager.products addObject:p1];
    [self.parManager.products addObject:p2];
    [self.parManager.products addObject:p3];
    [self searchedItemKlickedIsAddedToPARManagerProductArray];
}

- (void)searchedItemKlickedIsAddedToPARManagerProductArray {

    //Get the searchterm ex = fisk.
    NSString *search = @"fiskpaj";
    //Do all the programming for the JSON object...
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://matapi.se/foodstuff?query=%@",search]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSError *parseError;
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                dispatch_async(dispatch_get_main_queue(),
                                                ^{
                                                    //Collecting the number????
                                                    NSLog(@"JSON-objectet json: %@",json[0]);
                                                    NSLog(@"%@", [json[0] valueForKey:@"name"]);
                                                });
                                            }];
    [task resume];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[PARMananger getPARManager] products].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"cellProduct";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *label;
    
    label = (UILabel *) [cell viewWithTag:1];
    label.text = [self.parManager.products[indexPath.row] valueForKey:@"name"];
    
    label = (UILabel *) [cell viewWithTag:2];
    label.text = [NSString stringWithFormat:@"Kcal: %@",[self.parManager.products[indexPath.row] valueForKey:@"kcal"]];
    
    label = (UILabel *) [cell viewWithTag:3];
    label.text = [NSString stringWithFormat:@"Carbs: %@",[self.parManager.products[indexPath.row] valueForKey:@"carbs"]];
    
    label = (UILabel *) [cell viewWithTag:4];
    label.text = [NSString stringWithFormat:@"Protein: %@",[self.parManager.products[indexPath.row] valueForKey:@"protein"]];
    
    label = (UILabel *) [cell viewWithTag:5];
    label.text = [NSString stringWithFormat:@"Fat: %@",[self.parManager.products[indexPath.row] valueForKey:@"fat"]];
    
    
    
    //cell.textLabel.text = self.parManager.products[indexPath.row];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
