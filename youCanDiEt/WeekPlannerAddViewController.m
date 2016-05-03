//
//  WeekPlannerAddViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "WeekPlannerAddViewController.h"
#import "WeekPlanner.h"
#import "PARMananger.h"

@interface WeekPlannerAddViewController ()

@property (nonatomic) PARMananger *parManager;
@property (nonatomic) NSArray *weekdays;
@property (nonatomic) NSArray *categories;
@property (weak, nonatomic) IBOutlet UITextField *weekNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *chosenRecipesTableView;
@property (weak, nonatomic) IBOutlet UITableView *recipesToChooseFromTableView;
@property (weak, nonatomic) IBOutlet UIPickerView *weekdaysAndCategoryPickerView;
@property (nonatomic) NSString *weekdayChosen;
@property (nonatomic) NSString *categoryChosen;
@property (nonatomic) NSMutableArray *arrayBreakfastRecipes;
@property (nonatomic) NSMutableArray *arraySnackRecipes;
@property (nonatomic) NSMutableArray *arrayLunchRecipes;
@property (nonatomic) NSMutableArray *arrayDinnerRecipes;
@property (nonatomic) NSMutableArray *arraySupperRecipes;
@property (nonatomic) NSMutableArray *arrayOfDictionariesWithAddedRecipes;
@property (nonatomic) NSMutableArray *arrayChangableBasedOnCategory;

@end

@implementation WeekPlannerAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    self.weekdays = [[NSArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday", nil];
    self.categories = [[NSArray alloc] initWithObjects:@"Breakfast", @"Snack", @"Lunch", @"Dinner", @"Supper", nil];
    self.weekdayChosen = @"Monday";
    self.categoryChosen = @"Breakfast";
    [self initArraysAndBreakUpTheRecipesIntoOwnArraysBasedOnCategory];
    self.weekNameTextField.delegate = self;
    if (self.parManager.editingWeek) {
        [self comingFromEdit];
    }
    [[[[self.tabBarController tabBar] items] objectAtIndex:0] setEnabled:NO];
    [[[[self.tabBarController tabBar] items] objectAtIndex:1] setEnabled:NO];
    [[[[self.tabBarController tabBar] items] objectAtIndex:2] setEnabled:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)comingFromEdit{
    self.arrayOfDictionariesWithAddedRecipes = self.parManager.weekForEditing.recipes;
    self.weekNameTextField.text = self.parManager.weekForEditing.weekName;
}

-(void)initArraysAndBreakUpTheRecipesIntoOwnArraysBasedOnCategory {
    self.arrayBreakfastRecipes = [NSMutableArray new];
    self.arraySnackRecipes = [NSMutableArray new];
    self.arrayLunchRecipes = [NSMutableArray new];
    self.arrayDinnerRecipes = [NSMutableArray new];
    self.arraySupperRecipes = [NSMutableArray new];
    self.arrayChangableBasedOnCategory= [NSMutableArray new];
    self.arrayOfDictionariesWithAddedRecipes= [NSMutableArray new];
    
    for(Recipe *recipe in self.parManager.recipes) {
        if ([recipe.category isEqualToString:@"Breakfast"]) {
            [self.arrayBreakfastRecipes addObject:recipe];
        } else if ([recipe.category isEqualToString:@"Snack"]) {
            [self.arraySnackRecipes addObject:recipe];
        } else if ([recipe.category isEqualToString:@"Lunch"]) {
            [self.arrayLunchRecipes addObject:recipe];
        } else if ([recipe.category isEqualToString:@"Dinner"]) {
            [self.arrayDinnerRecipes addObject:recipe];
        } else if ([recipe.category isEqualToString:@"Supper"]) {
            [self.arraySupperRecipes addObject:recipe];
        } else {
            NSLog(@"Did not match any category");
        }
    }
    [self setChangableArrayBasedOnCategory];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (tableView == self.recipesToChooseFromTableView) {
        if (self.arrayChangableBasedOnCategory.count < 1) {
            return 1;
        } else {
        return self.arrayChangableBasedOnCategory.count;
        }
    } else {
        if (self.arrayOfDictionariesWithAddedRecipes.count < 1) {
            return 1;
        } else {
            return self.arrayOfDictionariesWithAddedRecipes.count;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellInTwoTables"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellInTwoTables"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView == self.recipesToChooseFromTableView) {
        if (self.arrayChangableBasedOnCategory.count < 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"No %@ recipes exists", self.categoryChosen];
        } else {
            cell.textLabel.text = [self.arrayChangableBasedOnCategory[indexPath.row] name];
            int kcal = [[self.arrayChangableBasedOnCategory[indexPath.row] getTotalKeyWordContentInRecipeBasedOnKeyWord:@"kcal"] intValue];
            int portions = [[self.arrayChangableBasedOnCategory[indexPath.row] portions] intValue];
            int kcalPerPortions = (int)kcal/portions;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d kcal per portions", kcalPerPortions];
        
            UIImage *cachedImage = [UIImage imageWithContentsOfFile:[self.arrayChangableBasedOnCategory[indexPath.row] getTheRightFolderAndImagePath]];
            if (cachedImage) {
                cell.imageView.image = cachedImage;
            }
        }
    } else {
        if (self.arrayOfDictionariesWithAddedRecipes.count < 1) {
            cell.textLabel.text = @"No Recipes added to this week";
        } else {
            cell.textLabel.text =[[self.arrayOfDictionariesWithAddedRecipes[indexPath.row] valueForKey:@"recipe"] name];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@s %@.", [self.arrayOfDictionariesWithAddedRecipes[indexPath.row] valueForKey:@"weekday"], [self.arrayOfDictionariesWithAddedRecipes[indexPath.row] valueForKey:@"category"] ];
            
            UIImage *cachedImage = [UIImage imageWithContentsOfFile:[[self.arrayOfDictionariesWithAddedRecipes[indexPath.row] valueForKey:@"recipe" ] getTheRightFolderAndImagePath]];
            if (cachedImage) {
                cell.imageView.image = cachedImage;
            }
        }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.recipesToChooseFromTableView) {
        if (self.arrayChangableBasedOnCategory.count > 0) {
            NSDictionary *tempDictionary = @{@"recipe" : [self.arrayChangableBasedOnCategory objectAtIndex:indexPath.row], @"category" : self.categoryChosen, @"weekday" : self.weekdayChosen};
            [self.arrayOfDictionariesWithAddedRecipes insertObject:tempDictionary atIndex:0];
            [self.chosenRecipesTableView reloadData];
        }
    } else {
        if (self.arrayOfDictionariesWithAddedRecipes.count > 0) {
            [self.arrayOfDictionariesWithAddedRecipes removeObjectAtIndex:indexPath.row];
            [self.chosenRecipesTableView reloadData];
        }
    }
}

//PickerView Implementation below...
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.weekdays.count;
            break;
        case 1:
            return self.categories.count;
            break;
        default:
            break;
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [self.weekdays objectAtIndex:row];
            break;
        case 1:
            return [self.categories objectAtIndex:row];
            break;
        default:
            break;
    }
    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            //This is when the weekdayComponent is changed...
            self.weekdayChosen = [self.weekdays objectAtIndex:[self.weekdaysAndCategoryPickerView  selectedRowInComponent:0]];
            break;
        case 1:
            //This is when the categoryComponent is changed...
            self.categoryChosen = [self.categories objectAtIndex:[self.weekdaysAndCategoryPickerView   selectedRowInComponent:1]];
            [self setChangableArrayBasedOnCategory];
            [self.recipesToChooseFromTableView reloadData];
            break;
        default:
            break;
    }
}

- (void)setChangableArrayBasedOnCategory {
    self.arrayChangableBasedOnCategory = [NSMutableArray new];
    if ([self.categoryChosen isEqualToString:@"Breakfast"]) {
        self.arrayChangableBasedOnCategory = self.arrayBreakfastRecipes;
    } else if ([self.categoryChosen isEqualToString:@"Snack"]) {
        self.arrayChangableBasedOnCategory = self.arraySnackRecipes;
    } else if ([self.categoryChosen isEqualToString:@"Lunch"]) {
        self.arrayChangableBasedOnCategory = self.arrayLunchRecipes;
    } else if ([self.categoryChosen isEqualToString:@"Dinner"]) {
        self.arrayChangableBasedOnCategory = self.arrayDinnerRecipes;
    } else if ([self.categoryChosen isEqualToString:@"Supper"]) {
        self.arrayChangableBasedOnCategory = self.arraySupperRecipes;
    } else {
        NSLog(@"Something went wrong in setChangebleArrayBasedOnCaetegory...");
    }
    //update the tableview???
}

- (IBAction)saveTheWeek:(id)sender {
    if ([self.weekNameTextField.text isEqualToString:@""] || self.arrayOfDictionariesWithAddedRecipes.count == 0) {
            
        NSString *errorMessage = @"Please fix the following errors:";
            
        if ([self.weekNameTextField.text isEqualToString:@""]) {
            errorMessage = [errorMessage stringByAppendingString:@" Enter name."];
        }
        if (self.arrayOfDictionariesWithAddedRecipes.count == 0) {
            errorMessage = [errorMessage stringByAppendingString:@" Add ingredients."];
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        WeekPlanner *plannedWeek = [[WeekPlanner alloc] initWithWeekName:self.weekNameTextField.text andRecipes:self.arrayOfDictionariesWithAddedRecipes];
        [self.parManager addWeekToMyWeeks:plannedWeek];
        [self.parManager saveWeeks];
        [self performSegueWithIdentifier:@"exitAddWeek" sender:self];
    }
}

- (IBAction)exitAddWeek:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Exit" message:@"The week has not been saved..." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *exit = [UIAlertAction actionWithTitle:@"Exit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self performSegueWithIdentifier:@"exitAddWeek" sender:self];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:exit];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
