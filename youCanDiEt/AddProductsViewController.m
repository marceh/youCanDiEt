//
//  AddProductsViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-03-04.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "AddProductsViewController.h"
#import "PARMananger.h"
#import "Product.h"
#import "ProductInfoClickViewController.h"

@interface AddProductsViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;
@property (nonatomic) NSMutableArray *arrayDone;
@property (nonatomic) NSMutableArray *tempProducts;
@property (nonatomic) PARMananger *parManager;
@property (nonatomic) NSNumber *rowSelsected;

@end

@implementation AddProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    self.tempProducts = [NSMutableArray new];
    self.arrayDone = [NSMutableArray new];
}

- (IBAction)clickedButtonSearch:(id)sender {
    [self updateTheTableWithItemsMatchingSearchItem:self.textFieldSearch.text];
}

-(void)updateTheTableWithItemsMatchingSearchItem:(NSString *)item{
//    [self.arrayDone removeAllObjects];
    self.arrayDone = [NSMutableArray new];
    [self.tableView reloadData];
    self.textFieldSearch.text = @"Searching... Please wait!";
    [self searchedItemGetApiNumbers:item];
}

- (void)searchedItemGetApiNumbers:(NSString *)item {
    NSMutableArray *tempArray = [NSMutableArray new];
    NSMutableArray *nameArray = [NSMutableArray new];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://matapi.se/foodstuff?query=%@",item] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSError *parseError;
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                dispatch_async(dispatch_get_main_queue(),
                                                               ^{
                                                                   for (id jsonObject in json) {
                                                                       [tempArray addObject:[jsonObject valueForKey:@"number"]];
                                                                       [nameArray addObject:[jsonObject valueForKey:@"name"]];
                                                                   }
                                                                   self.tempProducts = [tempArray copy];
                                                                   if (self.tempProducts.count == 0) {
                                                                       [self.arrayDone addObject:@"No product matched your search..."];
                                                                   } else {
                                                                       self.arrayDone = [nameArray copy];
                                                                       //[self giveCorrespondingDictionaryBasedOnNumber:[self.tempProducts[0] stringValue] andIndex:0];
                                                                   }
                                                                   [self.tableView reloadData];
                                                                   self.textFieldSearch.text = @"";
                                                               });
                                            }];
    [task resume];
}

/*
- (void)giveCorrespondingDictionaryBasedOnNumber:(NSString *)number andIndex:(int)index{
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://matapi.se/foodstuff/%@",number]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSError *parseError;
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                dispatch_async(dispatch_get_main_queue(),
                                                               ^{
                                                                   NSDictionary *nutrientValuesInJSON = [json valueForKey:@"nutrientValues"];
                                                                   [tempDictionary setValue:[json valueForKey:@"name"] forKey:@"name"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"energyKcal"] stringValue] forKey:@"kcal"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"carbohydrates"] stringValue] forKey:@"carbs"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"protein"] stringValue] forKey:@"protein"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"fat"] stringValue] forKey:@"fat"];
                                                                   [self.arrayDone addObject:tempDictionary];
                                                                   if (index < self.tempProducts.count -1) {
                                                                       [self giveCorrespondingDictionaryBasedOnNumber:[self.tempProducts[index+1] stringValue] andIndex:index+1];
                                                                   } else {
                                                                       [self.tableView reloadData];
                                                                       self.textFieldSearch.text = @"";
                                                                   }
                                                                   
                                                               });
                                            }];
    [task resume];
 }
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayDone.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellAddTheProducts";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *label;
    label = (UILabel *) [cell viewWithTag:1];
    label.text = self.arrayDone[indexPath.row];
    return cell;
}

/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"nu sätter vi rowSelectedNumber");
    self.rowSelsected = self.tempProducts[indexPath.row];
}
*/ 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showProductInformation"]){
        UINavigationController *navigationController = [segue destinationViewController];
        ProductInfoClickViewController *destination = [navigationController topViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSLog(@"nu skall vi gå vidare");
        destination.productNumber = self.tempProducts[indexPath.row];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Add";
}

/*- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleInsert;
}
*/

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://matapi.se/foodstuff/%@",self.tempProducts[indexPath.row]]];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     NSURLSession *session = [NSURLSession sharedSession];
     NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                 NSError *parseError;
                                                 NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                 dispatch_async(dispatch_get_main_queue(),
                                                                ^{
                                                                    NSDictionary *nutrientValuesInJSON = [json valueForKey:@"nutrientValues"];
                                                                    [tempDictionary setValue:[json valueForKey:@"name"] forKey:@"name"];
                                                                    [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"energyKcal"] stringValue] forKey:@"kcal"];
                                                                    [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"carbohydrates"] stringValue] forKey:@"carbs"];
                                                                    [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"protein"] stringValue] forKey:@"protein"];
                                                                    [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"fat"] stringValue] forKey:@"fat"];
                                                                    
                                                                    if (editingStyle == UITableViewCellEditingStyleDelete) {
                                                                        [self.parManager addProductToMyProducts:[[Product alloc]initWithDictionary:tempDictionary]];
                                                                        [self.parManager saveProducts];
                                                                    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
                                                                    }
                                                                    
                                                                });
                                             }];
     [task resume];
 }

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

@end