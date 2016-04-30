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
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)toAddRecipe:(id)sender {
    [self performSegueWithIdentifier:@"toAddRecipe" sender:self];
}

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
        cell.imageRecipePicture.image = Nil;
    } else {
        cell.labelRecipeName.text = [self.parManager.recipes[indexPath.row] name];
        UIImage *cachedImage = [UIImage imageWithContentsOfFile:[self.parManager.recipes[indexPath.row] getTheRightFolderAndImagePath]];
        if (cachedImage) {
            cell.imageRecipePicture.image = cachedImage;
        } else {
            cell.imageRecipePicture.image = Nil;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.parManager.recipes.count > 0) {
        [self.parManager thisIsComparableRecipe:self.parManager.recipes[indexPath.row] number:1];
        self.parManager.fromClickedRecipes = NO;
        [self performSegueWithIdentifier:@"FromRecipeTableView" sender:self];
    } else {
        [self toAddRecipe:self];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SegueToAddRecipe"]){
        [self.parManager clearCurrentRecipe];
    }
}


@end
