//
//  WeekClickedTableViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-04-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "WeekClickedTableViewController.h"
#import "PARMananger.h"

@interface WeekClickedTableViewController ()

@property (nonatomic) PARMananger *parmanager;
@property (nonatomic) NSMutableArray *mondaysRecipes;
@property (nonatomic) NSMutableArray *tuesdaysRecipes;
@property (nonatomic) NSMutableArray *wednesdaysRecipes;
@property (nonatomic) NSMutableArray *thursdaysRecipes;
@property (nonatomic) NSMutableArray *fridaysRecipes;
@property (nonatomic) NSMutableArray *saturdaysRecipes;
@property (nonatomic) NSMutableArray *sundaysRecipes;

@end

@implementation WeekClickedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parmanager = [PARMananger getPARManager];
    [self splitTheRecipesIntoSevenOrderedLists];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)splitTheRecipesIntoSevenOrderedLists{
    self.mondaysRecipes = [NSMutableArray new];
    self.tuesdaysRecipes = [NSMutableArray new];
    self.wednesdaysRecipes = [NSMutableArray new];
    self.thursdaysRecipes = [NSMutableArray new];
    self.fridaysRecipes = [NSMutableArray new];
    self.saturdaysRecipes = [NSMutableArray new];
    self.sundaysRecipes = [NSMutableArray new];
    
//        for (NSMutableDictionary *tempDictionary in self.parmanager.selectedWeek) {
//            if ([[tempDictionary valueForKey:@"weekday"] isEqualToString:@"Monday"]) {
//                [self.mondaysRecipes addObject:[tempDictionary valueForKey:@"recipe"]];
//            } else if ([[tempDictionary valueForKey:@"weekday"] isEqualToString:@"Tuesday"]) {
//                [self.tuesdaysRecipes addObject:[tempDictionary valueForKey:@"recipe"]];
//            } else if ([[tempDictionary valueForKey:@"weekday"] isEqualToString:@"Wednesday"]) {
//                [self.wednesdaysRecipes addObject:[tempDictionary valueForKey:@"recipe"]];
//            } else if ([[tempDictionary valueForKey:@"weekday"] isEqualToString:@"Thursday"]) {
//                [self.thursdaysRecipes addObject:[tempDictionary valueForKey:@"recipe"]];
//            } else if ([[tempDictionary valueForKey:@"weekday"] isEqualToString:@"Friday"]) {
//                [self.fridaysRecipes addObject:[tempDictionary valueForKey:@"recipe"]];
//            } else if ([[tempDictionary valueForKey:@"weekday"] isEqualToString:@"Saturday"]) {
//                [self.saturdaysRecipes addObject:[tempDictionary valueForKey:@"recipe"]];
//            } else if ([[tempDictionary valueForKey:@"weekday"] isEqualToString:@"Sunday"]) {
//                [self.sundaysRecipes addObject:[tempDictionary valueForKey:@"recipe"]];
//            }
//        }
    
    
    [self returnTheOrderedListInArray:self.mondaysRecipes BasedOnWeekDay:@"Monday"];
    [self returnTheOrderedListInArray:self.tuesdaysRecipes BasedOnWeekDay:@"Tuesday"];
    [self returnTheOrderedListInArray:self.wednesdaysRecipes BasedOnWeekDay:@"Wednesday"];
    [self returnTheOrderedListInArray:self.thursdaysRecipes BasedOnWeekDay:@"Thursday"];
    [self returnTheOrderedListInArray:self.fridaysRecipes BasedOnWeekDay:@"Friday"];
    [self returnTheOrderedListInArray:self.saturdaysRecipes BasedOnWeekDay:@"Saturday"];
    [self returnTheOrderedListInArray:self.sundaysRecipes BasedOnWeekDay:@"Sunday"];
    NSLog(@"count of monday...%d", self.mondaysRecipes.count);
}

- (void)returnTheOrderedListInArray:(NSMutableArray *)tempArray BasedOnWeekDay:(NSString *)weekDay {
    [self returnTheOrderedListInArray:tempArray BasedOnWeekDay:weekDay andCategory:@"Breakfast"];
    [self returnTheOrderedListInArray:tempArray BasedOnWeekDay:weekDay andCategory:@"Snack"];
    [self returnTheOrderedListInArray:tempArray BasedOnWeekDay:weekDay andCategory:@"Lunch"];
    [self returnTheOrderedListInArray:tempArray BasedOnWeekDay:weekDay andCategory:@"Dinner"];
    [self returnTheOrderedListInArray:tempArray BasedOnWeekDay:weekDay andCategory:@"Supper"];
}

- (void)returnTheOrderedListInArray:(NSMutableArray *)tempArray BasedOnWeekDay:(NSString *)weekDay andCategory:(NSString *)category {
    for (NSMutableDictionary *tempDictionary in self.parmanager.selectedWeek) {
        if ([[tempDictionary valueForKey:@"weekday"] isEqualToString:weekDay] && [[tempDictionary valueForKey:@"category"] isEqualToString:category]) {
            [tempArray addObject:[tempDictionary valueForKey:@"recipe"]];
        }
    }
}

//Skapa en metod som returnerar arrayen med recept fast ordnad och i 7...

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //One for every weekday...
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.mondaysRecipes.count;
            break;
        case 1:
            return self.tuesdaysRecipes.count;
            break;
        case 2:
            return self.wednesdaysRecipes.count;
            break;
        case 3:
            return self.thursdaysRecipes.count;
            break;
        case 4:
            return self.fridaysRecipes.count;
            break;
        case 5:
            return self.saturdaysRecipes.count;
            break;
        case 6:
            return self.sundaysRecipes.count;
            break;
        default:
            break;
    }
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Monday";
            break;
        case 1:
            return @"Tuesday";
            break;
        case 2:
            return @"Wednesday";
            break;
        case 3:
            return @"Thursday";
            break;
        case 4:
            return @"Friday";
            break;
        case 5:
            return @"Saturday";
            break;
        case 6:
            return @"Sunday";
            break;
        default:
            break;
    }
    return @"Error";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellInClickedWeek"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellInClickedWeek"];
    UIImage *cachedImage;
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[self.mondaysRecipes objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text = [[self.mondaysRecipes objectAtIndex:indexPath.row] category];
            
            cachedImage = [UIImage imageWithContentsOfFile:[self.mondaysRecipes[indexPath.row] getTheRightFolderAndImagePath]];
            if (cachedImage) {
                cell.imageView.image = cachedImage;
            } else {
                NSLog(@"didn't find the picPath of the recipe");
            }
            
            break;
        case 1:
            cell.textLabel.text = [[self.tuesdaysRecipes objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text = [[self.tuesdaysRecipes objectAtIndex:indexPath.row] category];
            
            cachedImage = [UIImage imageWithContentsOfFile:[self.tuesdaysRecipes[indexPath.row] getTheRightFolderAndImagePath]];
            if (cachedImage) {
                cell.imageView.image = cachedImage;
            } else {
                NSLog(@"didn't find the picPath of the recipe");
            }
            
            break;
        case 2:
            cell.textLabel.text = [[self.wednesdaysRecipes objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text = [[self.wednesdaysRecipes objectAtIndex:indexPath.row] category];
            
            cachedImage = [UIImage imageWithContentsOfFile:[self.wednesdaysRecipes[indexPath.row] getTheRightFolderAndImagePath]];
            if (cachedImage) {
                cell.imageView.image = cachedImage;
            } else {
                NSLog(@"didn't find the picPath of the recipe");
            }
            
            break;
        case 3:
            cell.textLabel.text = [[self.thursdaysRecipes objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text = [[self.thursdaysRecipes objectAtIndex:indexPath.row] category];
            
            cachedImage = [UIImage imageWithContentsOfFile:[self.thursdaysRecipes[indexPath.row] getTheRightFolderAndImagePath]];
            if (cachedImage) {
                cell.imageView.image = cachedImage;
            } else {
                NSLog(@"didn't find the picPath of the recipe");
            }
            
            break;
        case 4:
            cell.textLabel.text = [[self.fridaysRecipes objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text = [[self.fridaysRecipes objectAtIndex:indexPath.row] category];
            
            cachedImage = [UIImage imageWithContentsOfFile:[self.fridaysRecipes[indexPath.row] getTheRightFolderAndImagePath]];
            if (cachedImage) {
                cell.imageView.image = cachedImage;
            } else {
                NSLog(@"didn't find the picPath of the recipe");
            }
            
            break;
        case 5:
            cell.textLabel.text = [[self.saturdaysRecipes objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text = [[self.saturdaysRecipes objectAtIndex:indexPath.row] category];
            
            cachedImage = [UIImage imageWithContentsOfFile:[self.saturdaysRecipes[indexPath.row] getTheRightFolderAndImagePath]];
            if (cachedImage) {
                cell.imageView.image = cachedImage;
            } else {
                NSLog(@"didn't find the picPath of the recipe");
            }
            
            break;
        case 6:
            cell.textLabel.text = [[self.sundaysRecipes objectAtIndex:indexPath.row] name];
            cell.detailTextLabel.text = [[self.sundaysRecipes objectAtIndex:indexPath.row] category];
            
            cachedImage = [UIImage imageWithContentsOfFile:[self.sundaysRecipes[indexPath.row] getTheRightFolderAndImagePath]];
            if (cachedImage) {
                cell.imageView.image = cachedImage;
            } else {
                NSLog(@"didn't find the picPath of the recipe");
            }
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"klickade på indexpath: %ld, %ld",(long)indexPath.section, (long)indexPath.row);
    
    if (indexPath.section == 0) {
        [self.parmanager thisIsComparableRecipe:self.mondaysRecipes[indexPath.row] number:1];
    } else if (indexPath.section == 1) {
        [self.parmanager thisIsComparableRecipe:self.tuesdaysRecipes[indexPath.row] number:1];
    } else if (indexPath.section == 2) {
        [self.parmanager thisIsComparableRecipe:self.wednesdaysRecipes[indexPath.row] number:1];
    } else if (indexPath.section == 3) {
        [self.parmanager thisIsComparableRecipe:self.thursdaysRecipes[indexPath.row] number:1];
    } else if (indexPath.section == 4) {
        [self.parmanager thisIsComparableRecipe:self.fridaysRecipes[indexPath.row] number:1];
    } else if (indexPath.section == 5) {
        [self.parmanager thisIsComparableRecipe:self.saturdaysRecipes[indexPath.row] number:1];
    } else if (indexPath.section == 6) {
        [self.parmanager thisIsComparableRecipe:self.sundaysRecipes[indexPath.row] number:1];
    } else {
        NSLog(@"Something went wrong...");
    }
    self.parmanager.fromClickedRecipes = YES;
    [self performSegueWithIdentifier:@"FromClickedToInfo" sender:self];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
