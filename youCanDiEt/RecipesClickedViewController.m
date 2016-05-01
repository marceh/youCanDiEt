//
//  RecipesClickedViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-04-01.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "RecipesClickedViewController.h"
#import "PARMananger.h"
#import "Recipe.h"

@interface RecipesClickedViewController ()

@property (weak, nonatomic) PARMananger *parManager;
@property (weak, nonatomic) Recipe *theRecipe;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewInsideScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPic;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelKcal;
@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (weak, nonatomic) IBOutlet UITextView *textViewHowTo;
@property (weak, nonatomic) IBOutlet UILabel *labelKcalNotportion;


@end

@implementation RecipesClickedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    self.theRecipe = self.parManager.comparableRecipeOne;
    self.imageViewPic.image = [UIImage imageWithContentsOfFile:[self.theRecipe getTheRightFolderAndImagePath]];
    self.labelName.text = self.theRecipe.name;
    self.labelKcal.text = [NSString stringWithFormat:@"Portions: %@",self.theRecipe.portions];
    self.labelKcalNotportion.text = [NSString stringWithFormat:@"Kcals/portion: %@",[self.theRecipe getKcalsPerPortions]];
    self.textViewHowTo.text = self.theRecipe.howTo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickedBack:(id)sender {
    if (self.parManager.fromClickedRecipes) {
        [self performSegueWithIdentifier:@"FromRecipesClickedToWeekClicked" sender:self];
    } else {
        [self performSegueWithIdentifier:@"FromRecipesClickedToRecipes" sender:self];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.theRecipe.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellInTableviewInScrollView"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellInTableviewInScrollView"];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:8];
    
    cell.textLabel.text = [[self.theRecipe.products[indexPath.row] valueForKey:@"product"] valueForKey:@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Recipe contains %@ grams of this product.",[[self.theRecipe.products[indexPath.row] valueForKey:@"grams"] stringValue]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.753 green:0.925 blue:0.98 alpha:1.0];
    }
}

@end
