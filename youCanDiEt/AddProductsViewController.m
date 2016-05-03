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
#import "Reach"

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

- (void)clickedButtonSearch {
    [self updateTheTableWithItemsMatchingSearchItem:self.textFieldSearch.text];
}

-(void)updateTheTableWithItemsMatchingSearchItem:(NSString *)item{
    self.arrayDone = [NSMutableArray new];
    [self.tableView reloadData];
    self.textFieldSearch.text = @"Searching...";
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
                                                                       [self.arrayDone addObject:@"No match"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAddTheProducts"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellAddTheProducts"];
    cell.textLabel.text = self.arrayDone[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.753 green:0.925 blue:0.98 alpha:1.0];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tempProducts.count > 0) {
        self.parManager.productNumber = self.tempProducts[indexPath.row];
        [self performSegueWithIdentifier:@"popoverSegueProduct" sender:self];
    }
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
    [self clickedButtonSearch];
    return YES;
}

@end