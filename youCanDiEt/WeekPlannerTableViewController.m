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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear3333333,,,");
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
    if (self.parManager.weeks.count < 1) {
        return 1;
    } else {
        return self.parManager.weeks.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"theCellInWeekPlannerTableViewController"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"theCellInWeekPlannerTableViewController"];
    
    if (self.parManager.weeks.count < 1) {
        cell.textLabel.text = @"No weeks created yet.";
    } else {
        cell.textLabel.text = [self.parManager.weeks[indexPath.row] weekName];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Estimated weigthloss: %.2fkg", ((([[self.parManager.weeks[indexPath.row] kcalInWeek] doubleValue]) - ([[self.settingsManager kcalNeed] doubleValue] * 7)) / 7000)];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.parManager.weeks.count > 0) {
        self.parManager.selectedWeek = [self.parManager.weeks[indexPath.row] recipes];
        [self performSegueWithIdentifier:@"goToClickedWeek" sender:self];
    }
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToClickedWeek"])
    {
//        Inne i skiten
    }
}


@end
