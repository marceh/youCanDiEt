//
//  WeekPlannerTableViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "WeekPlannerTableViewController.h"
#import "WeekPlanner.h"
#import "PARMananger.h"
#import "Settings.h"

@interface WeekPlannerTableViewController ()
@property (nonatomic) PARMananger *parManager;
@property (nonatomic) Settings *settingsManager;

@end

@implementation WeekPlannerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    self.settingsManager = [Settings getSetting];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)toAddWeek:(id)sender {
    [self performSegueWithIdentifier:@"toAddWeek" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.parManager.weeks.count < 1) {
        return 1;
    } else {
        return self.parManager.weeks.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"theCellInWeekPlannerTableViewController"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"theCellInWeekPlannerTableViewController"];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTheCell:)];
    UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressedTheCell:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    pressRecognizer.minimumPressDuration = 0.5;
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:tapRecognizer];
    [cell addGestureRecognizer:pressRecognizer];
    
    if (self.parManager.weeks.count < 1) {
        cell.textLabel.text = @"No weeks created yet.";
    } else {
        cell.textLabel.text = [self.parManager.weeks[indexPath.row] weekName];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Estimated weigthloss: %.2fkg", ((([[self.parManager.weeks[indexPath.row] kcalInWeek] doubleValue]) - ([[self.settingsManager kcalNeed] doubleValue] * 7)) / 7000)];
    }
    
    return cell;
}

-(void)tappedTheCell:(UITapGestureRecognizer *)sender {
    if (self.parManager.weeks.count > 0) {
        self.parManager.selectedWeek = [self.parManager.weeks[sender.view.tag] recipes];
        [self performSegueWithIdentifier:@"goToClickedWeek" sender:self];
    } else {
        [self toAddWeek:self];
    }
}

-(void)pressedTheCell:(UITapGestureRecognizer*)sender {
    if (self.parManager.weeks.count > 0) {
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
    
    UIAlertAction *edit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.parManager.editingWeek = YES;
        self.parManager.indexPathFromEditWeek = indexpathRow;
        self.parManager.weekForEditing = self.parManager.weeks[indexpathRow];
        [self performSegueWithIdentifier:@"toAddWeek" sender:self];
    }];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.parManager.weeks removeObjectAtIndex:indexpathRow];
        [self.parManager saveWeeks];
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
