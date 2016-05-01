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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipesTableViewCell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RecipesTableViewCell"];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTheCell:)];
    UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressedTheCell:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    pressRecognizer.minimumPressDuration = 0.5;
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:tapRecognizer];
    [cell addGestureRecognizer:pressRecognizer];
    
    if (self.parManager.recipes.count < 1) {
        cell.textLabel.text = @"No Recipes added yet";
        cell.imageView.image = Nil;
    } else {
        cell.textLabel.text = [self.parManager.recipes[indexPath.row] name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ containing %@ kcals/portion", [self.parManager.recipes[indexPath.row] category], [self.parManager.recipes[indexPath.row] getKcalsPerPortions]];
        UIImage *cachedImage = [UIImage imageWithContentsOfFile:[self.parManager.recipes[indexPath.row] getTheRightFolderAndImagePath]];
        if (cachedImage) {
            cell.imageView.image = cachedImage;
        } else {
            cell.imageView.image = Nil;
        }
    }
    
    return cell;
}

-(void)tappedTheCell:(UITapGestureRecognizer *)sender {
    if (self.parManager.recipes.count > 0) {
        [self.parManager thisIsComparableRecipe:self.parManager.recipes[sender.view.tag] number:1];
        self.parManager.fromClickedRecipes = NO;
        [self performSegueWithIdentifier:@"FromRecipeTableView" sender:self];
    } else {
        [self toAddRecipe:self];
    }
}

-(void)pressedTheCell:(UITapGestureRecognizer*)sender {
    if (self.parManager.recipes.count > 0) {
        if (sender.state == UIGestureRecognizerStateBegan){
            [self displayAlertSendingIndexPathRow:sender.view.tag];
        }
    } else {
        if (sender.state == UIGestureRecognizerStateBegan){
            NSLog(@"Pressade");
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toAddRecipe"]){
        [self.parManager clearCurrentRecipe];
        self.parManager.arrayOfIngredients = [NSMutableArray new];
        self.parManager.editingRecipe = NO;
        self.parManager.fromAlertContoller = NO;
        self.parManager.recipeForEditing = [[Recipe alloc] init];
    }
}

//Wanted to do this method DRY but didn't have the time...
-(void)displayAlertSendingIndexPathRow:(NSInteger)indexpathRow {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Measure" message:@"Select your measure" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *edit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //Set Code...
        //glöm inte att sätta alla producter till self.parmanager..arrayofingredients... se nedan...
        self.parManager.arrayOfIngredients = [self.parManager.recipes[indexpathRow] products];
        self.parManager.editingRecipe = YES;
        self.parManager.fromAlertContoller = YES;
        self.parManager.indexPathFromEditRecipe = indexpathRow;
        self.parManager.recipeForEditing = self.parManager.recipes[indexpathRow];
        [self performSegueWithIdentifier:@"ToAddRecipeByEdit" sender:self];
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.parManager.recipes removeObjectAtIndex:indexpathRow];
        [self.parManager saveRecipes];
        [self.tableView reloadData];
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:edit];
    [alertController addAction:delete];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
