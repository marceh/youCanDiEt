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
    self.textFieldSearch.delegate = self;
}

- (IBAction)clickedButtonSearch:(id)sender {
    [self updateTheTableWithItemsMatchingSearchItem:self.textFieldSearch.text];
}

-(void)updateTheTableWithItemsMatchingSearchItem:(NSString *)item{
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
                                                                   }
                                                                   [self.tableView reloadData];
                                                                   self.textFieldSearch.text = @"";
                                                               });
                                            }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.parManager.productNumber = self.tempProducts[indexPath.row];
    [self performSegueWithIdentifier:@"popoverSegueProduct" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"popoverSegueProduct"]) {
        UIViewController *viewController = segue.destinationViewController;
        UIPopoverPresentationController *controller = viewController.popoverPresentationController;
        
        if (controller != nil) {
            controller.delegate = self;
        }
    }
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end