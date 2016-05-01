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
    self.parManager = [PARMananger getPARManager];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.productTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTheCell:)];
    UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressedTheCell:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    pressRecognizer.minimumPressDuration = 0.5;
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:tapRecognizer];
    [cell addGestureRecognizer:pressRecognizer];

            if (self.parManager.products.count < 1) {
                cell.textLabel.text = @"No products added yet";
            } else {
                Product *product = [self.parManager getProductInProductsAtIndex:indexPath.row];
                cell.textLabel.text = product.name;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"Kcal: %d, Protein: %.1f, Carbs: %.1f, Fat: %.1f", [product.kcal intValue], [product.protein doubleValue], [product.carbs doubleValue], [product.fat doubleValue]];
            }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.753 green:0.925 blue:0.98 alpha:1.0];
    }
}

-(void)tappedTheCell:(UILongPressGestureRecognizer *)sender {
    if (self.parManager.products.count > 0) {
        //If a clickable action is added, put it here...
        NSLog(@"Klickade");
    } else {
        NSLog(@"Klickade");
        [self toAddProduct:self];
    }
}

-(void)pressedTheCell:(UITapGestureRecognizer*)sender {
    if (self.parManager.products.count > 0) {
        if (sender.state == UIGestureRecognizerStateBegan){
            [self displayAlertSendingIndexPathRow:sender.view.tag];
        }
    } else {
        if (sender.state == UIGestureRecognizerStateBegan){
            NSLog(@"Pressade");
        }
    }
}


//Wanted to do this method DRY but didn't have the time...
-(void)displayAlertSendingIndexPathRow:(NSInteger)indexpathRow {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Measure" message:@"Select your measure" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.parManager.products removeObjectAtIndex:indexpathRow];
        [self.parManager saveProducts];
        [self.tableView reloadData];
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:delete];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
