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
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPic;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelKcal;
@property (weak, nonatomic) IBOutlet UILabel *labelCarbs;
@property (weak, nonatomic) IBOutlet UILabel *labelProtein;
@property (weak, nonatomic) IBOutlet UILabel *labelFat;
@property (weak, nonatomic) IBOutlet UILabel *labelDietValue;

@end

@implementation RecipesClickedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"inne i view did load");
    self.parManager = [PARMananger getPARManager];
    self.theRecipe = self.parManager.comparableRecipeOne;
    self.imageViewPic.image = [UIImage imageWithContentsOfFile:[self.theRecipe getTheRightFolderAndImagePath]];
    self.labelName.text = self.theRecipe.name;
    self.labelKcal.text = [NSString stringWithFormat:@"Total Kcal: %@", [self.theRecipe.dictionaryOfRecipeContent valueForKey:@"kcal"]];
    self.labelCarbs.text = [NSString stringWithFormat:@"Total Carbs: %@", [self.theRecipe.dictionaryOfRecipeContent valueForKey:@"carbs"]];
    self.labelProtein.text = [NSString stringWithFormat:@"Total Protein: %@", [self.theRecipe.dictionaryOfRecipeContent valueForKey:@"protein"]];
    self.labelFat.text = [NSString stringWithFormat:@"Total Fat: %@", [self.theRecipe.dictionaryOfRecipeContent valueForKey:@"fat"]];
    self.labelDietValue.text = [NSString stringWithFormat:@"%d", [self.theRecipe getDietValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
