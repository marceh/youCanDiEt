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

@end

@implementation WeekPlannerAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    self.weekdays = [[NSArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday", nil];
    self.categories = [[NSArray alloc] initWithObjects:@"Breakfast", @"Snack", @"Lunch", @"Dinner", @"Supper", nil];
    self.weekdayChosen = @"Monday";
    self.categoryChosen = @"Breakfast";
    [self breakUpTheRecipesIntoOwnArraysBasedOnCategory];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)breakUpTheRecipesIntoOwnArraysBasedOnCategory {
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
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (tableView == self.recipesToChooseFromTableView) {
        return 10;
    } else {
        return 5;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellInTwoTables"];
    
    if (cell == nil){
        NSLog(@"innne här");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellInTwoTables"];
    }
    
    if (tableView == self.recipesToChooseFromTableView) {
        
        
        cell.textLabel.text = @"hej";
        
    } else {
        
        cell.textLabel.text = @"då";

    }
    
    
    return cell;
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
            self.weekdayChosen = [self.weekdays objectAtIndex:[self.weekdaysAndCategoryPickerView selectedRowInComponent:0]];
            NSLog(self.weekdayChosen);
            
            break;
        case 1:
            //This is when the categoryComponent is changed...
            self.categoryChosen = [self.categories objectAtIndex:[self.weekdaysAndCategoryPickerView selectedRowInComponent:1]];
            NSLog(self.categoryChosen);
            
            break;
        default:
            break;
    }
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
