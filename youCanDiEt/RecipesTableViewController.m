//
//  RecipesTableViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "RecipesTableViewController.h"
#import "RecipesTableViewCell.h"
#import "PARMananger.h"

@interface RecipesTableViewController ()

@property (nonatomic) PARMananger *parManager;

@end

@implementation RecipesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear22222,,,");
    [self.tableView reloadData];
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
    if (self.parManager.recipes.count < 1) {
        return 1;
    } else {
        return self.parManager.recipes.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipesTableViewCell" forIndexPath:indexPath];
    
    if (self.parManager.recipes.count < 1) {
        cell.labelRecipeName.text = @"No Recipes added yet";
    } else {
        cell.labelRecipeName.text = [self.parManager.recipes[indexPath.row] name];
        
        //NSLog(@"the picPath of the image = %@ at indexpath.row = %d",[self.parManager.recipes[indexPath.row] getTheRightFolderAndImagePath], indexPath.row);
        
        UIImage *cachedImage = [UIImage imageWithContentsOfFile:[self.parManager.recipes[indexPath.row] getTheRightFolderAndImagePath]];
        
        //NSLog(@"cached image = %@", cachedImage);
        if (cachedImage) {
            cell.imageRecipePicture.image = cachedImage;
        } else {
            //NSLog(@"didn't find the picPath of the recipe");
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.parManager.recipes.count > 0) {
        [self.parManager thisIsComparableRecipe:self.parManager.recipes[indexPath.row] number:1];
        self.parManager.fromClickedRecipes = NO;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SegueToAddRecipe"]){
        [self.parManager clearCurrentRecipe];
    } else if ([segue.identifier isEqualToString:@"segueClickRecipe"]){
        NSLog(@"inne i seguen...");
        //RecipesTableViewCell *cell = sender;
        //self.parManager thisIsComparableRecipe:self.parManager.recipes[cell.] number:<#(int)#>
    }
    
}


@end
