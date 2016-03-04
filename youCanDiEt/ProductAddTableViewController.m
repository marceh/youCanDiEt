//
//  ProductAddTableViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-03-04.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "ProductAddTableViewController.h"
#import "PARMananger.h"
#import "APIManager.h"
#import "Product.h"

@interface ProductAddTableViewController ()

@property (nonatomic) PARMananger *parManager;
@property (nonatomic) APIManager *apiManager;
@property (nonatomic) NSMutableArray *tempProducts;
@property (nonatomic) NSMutableArray *arrayDone;
@property (weak, nonatomic) IBOutlet UITableView *productAddTableView;


@end

@implementation ProductAddTableViewController

- (void)viewDidLoad {
    NSLog(@"laddar viewdidload...");
    [super viewDidLoad];
    
    //Getting the singleton that manages the arrays...
    self.parManager = [PARMananger getPARManager];
    self.apiManager = [APIManager getAPIManager];
    self.tempProducts = [NSMutableArray new];
    //self.tempDictionary = [NSMutableDictionary new];
    self.arrayDone = [NSMutableArray new];
    /*[self.searchField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];*/
    
   // [self updateTheTableWithItemsMatchingSearchItem:@"fiskpaj"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateTheTable{
    NSLog(@"visa färdig array nedan: ");
    NSLog([self.arrayDone description]);
    
    NSLog(@"dags att updatera");
    [self.productAddTableView reloadData];
}

-(void)updateTheTableWithItemsMatchingSearchItem:(NSString *)item{
    //claring the array...
    [self.tempProducts removeAllObjects];
    //getting the numbers of matching products...
    [self searchedItemGetApiNumbers:item];
    NSLog(@"ute");
    //converting the array of numbers to a samesized array of corresponding dictionaries...
    NSLog(@"self.tempProducts.count: %d",self.tempProducts.count);
    //[self convertingArrayOfNumbersToArrayOfDictionaries:self.tempProducts];
    
}

- (void)searchedItemGetApiNumbers:(NSString *)item {
    NSLog(@"searchedItemGetApiNumbers med item: %@",item);
    //Create array with numbers of fitted products...
    NSMutableArray *tempArray = [NSMutableArray new];
    
    //Do all the programming for the JSON object...
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://matapi.se/foodstuff?query=%@",item]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSError *parseError;
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                dispatch_async(dispatch_get_main_queue(),
                                                               ^{
                                                                   //Collect the numbers of the products matching the search term.
                                                                   for (id jsonObject in json) {
                                                                       [tempArray addObject:[jsonObject valueForKey:@"number"]];
                                                                   }
                                                                   self.tempProducts = [tempArray copy];
                                                                   NSLog(@"efter foreach-loopen och sätter tempProduct, där är nu self.tempProducts.count = %d", self.tempProducts.count);
                                                                   NSLog(@"self.tempProducts.count: %d",self.tempProducts.count);
                                                                   [self convertingArrayOfNumbersToArrayOfDictionaries:self.tempProducts];
                                                               });
                                            }];
    [task resume];
}


- (void)convertingArrayOfNumbersToArrayOfDictionaries:(NSMutableArray *)arrayOfNumbers{
    NSLog(@"inne i convertingArrayOfNumbersToArrayOfDictionaries");
    NSLog(@"arrayOfNumber.count: %d", arrayOfNumbers.count);
    //for(int i = 0; i<arrayOfNumbers.count; i++){
    NSLog(@"inne i forloopen som inte finns längre.");
    [self giveCorrespondingDictionaryBasedOnNumber:[self.tempProducts[0] stringValue] andIndex:0];
    // }
}

- (void)giveCorrespondingDictionaryBasedOnNumber:(NSString *)number andIndex:(int)index{
    __block int indexInBlock = index;
    NSLog(@"inne i giveCorrespondingDictionaryBasedOnNumber: %@ andIndex: %d",number,index);
    // [self.tempDictionary removeAllObjects];
    //NSLog(@"Nu skall hela tempDictionary vara tom...");
    // NSLog([self.tempDictionary description]);
    
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
    NSLog([tempDictionary description]);
    
    //Do all the programming for the JSON object...
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://matapi.se/foodstuff/%@",number]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSError *parseError;
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                dispatch_async(dispatch_get_main_queue(),
                                                               ^{
                                                                   NSLog(@"inne för att byta number mot dictionary...nr = %d",indexInBlock);
                                                                   NSDictionary *nutrientValuesInJSON = [json valueForKey:@"nutrientValues"];
                                                                   //NSLog([nutrientValuesInJSON description]);
                                                                   
                                                                   [tempDictionary setValue:[json valueForKey:@"name"] forKey:@"name"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"energyKcal"] stringValue] forKey:@"kcal"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"carbohydrates"] stringValue] forKey:@"carbs"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"protein"] stringValue] forKey:@"protein"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"fat"] stringValue] forKey:@"fat"];
                                                                   
                                                                   NSLog(@"här är tempDescription ifyllt denna rundan.");
                                                                   NSLog([tempDictionary description]);
                                                                   
                                                                   [self.arrayDone addObject:tempDictionary];
                                                                   
                                                                   if (indexInBlock < self.tempProducts.count -1) {
                                                                       NSLog(@"displayind arrayDone so far:");
                                                                       NSLog([self.arrayDone description]);
                                                                       [self giveCorrespondingDictionaryBasedOnNumber:[self.tempProducts[indexInBlock+1] stringValue] andIndex:indexInBlock+1];
                                                                   } else {
                                                                       [self updateTheTable];
                                                                   }
                                                                   
                                                               });
                                            }];
    [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"inne och skall sätta numberof sections...");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"inne och skall sätta array count");
    return self.arrayDone.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"inne och skall sätta alla labels...");
    static NSString *CellIdentifier = @"CellProductAdd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *label;
    
    label = (UILabel *) [cell viewWithTag:1];
    label.text = [self.arrayDone[indexPath.row] valueForKey:@"name"];
    
    label = (UILabel *) [cell viewWithTag:2];
    label.text = [NSString stringWithFormat:@"Kcal: %@",[self.arrayDone[indexPath.row] valueForKey:@"kcal"]];
    
    label = (UILabel *) [cell viewWithTag:3];
    label.text = [NSString stringWithFormat:@"Carbs: %@",[self.arrayDone[indexPath.row] valueForKey:@"carbs"]];
    
    label = (UILabel *) [cell viewWithTag:4];
    label.text = [NSString stringWithFormat:@"Protein: %@",[self.arrayDone[indexPath.row] valueForKey:@"protein"]];
    
    label = (UILabel *) [cell viewWithTag:5];
    label.text = [NSString stringWithFormat:@"Fat: %@",[self.arrayDone[indexPath.row] valueForKey:@"fat"]];
    
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