//
//  ProductInfoTableViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "ProductInfoTableViewController.h"
#import "PARMananger.h"
#import "Product.h"

@interface ProductInfoTableViewController ()
@property (nonatomic) PARMananger *parManager;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (nonatomic) NSMutableArray *tempProducts;
@property (nonatomic) NSMutableArray *arrayDone;
@property (strong, nonatomic) IBOutlet UITableView *productTableView;

@end

@implementation ProductInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewDidLoad");
    self.parManager = [PARMananger getPARManager];
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear,,,");
    [self.productTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)longPressOnCell:(id)sender {
    NSLog(@"long pressed");
}

- (IBAction)toAddProduct:(id)sender {
    [self performSegueWithIdentifier:@"toAddProduct" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.parManager.products.count < 1) {
        return 1;
    } else {
        return self.parManager.products.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellProduct"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellProduct"];
    
            if (self.parManager.products.count < 1) {
                cell.textLabel.text = @"No products added yet";
            } else {
                Product *product = [self.parManager getProductInProductsAtIndex:indexPath.row];
                cell.textLabel.text = product.name;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"Kcal: %d, Protein: %.1f, Carbs: %.1f, Fat: %.1f", [product.kcal intValue], [product.protein doubleValue], [product.carbs doubleValue], [product.fat doubleValue]];
            }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.parManager.products.count > 0) {
        //If a clickable action is added, put it here...
    } else {
        [self toAddProduct:self];
    }
}

@end
