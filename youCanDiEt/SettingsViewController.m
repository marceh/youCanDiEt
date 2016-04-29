//
//  SettingsViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "SettingsViewController.h"
#import "PARMananger.h"
#import "Settings.h"

@interface SettingsViewController ()

@property (nonatomic) PARMananger *parManager;
@property (nonatomic) Settings *settingsManager;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextView;
@property (weak, nonatomic) IBOutlet UITextField *trainingSessionsTextView;
@property (weak, nonatomic) IBOutlet UILabel *kcalLabel;
@property (nonatomic) char gender;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.parManager = [PARMananger getPARManager];
    self.settingsManager = [Settings getSetting];
    [self updateKcalLabel];
    self.gender = 'm';
    self.ageTextField.delegate = self;
    self.heightTextField.delegate = self;
    self.weightTextView.delegate = self;
    self.trainingSessionsTextView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentedControlValueChanged:(id)sender {
    if (self.genderSegmentedControl.selectedSegmentIndex == 0) {
        self.gender = 'm';
    } else {
        self.gender = 'f';
    }
}

- (IBAction)calculateButtonClicked:(UIButton *)sender {
    if ([self checkIfAllFieldsAreValid]) {
        int age = [self.ageTextField.text intValue];
        int height = [self.heightTextField.text intValue];
        int weight = [self.weightTextView.text intValue];
        int daysOfExercisePerWeek = [self.trainingSessionsTextView.text intValue];
        
        self.settingsManager.kcalNeed = [NSNumber numberWithInt:(int)[self.settingsManager calculateKcalNeedsUsingGender:self.gender age:age height:height weight:weight andDaysOfExercisePerWeek:daysOfExercisePerWeek]];
        [self updateKcalLabel];
        [self.settingsManager saveKcalNeed];
    } else {
        self.kcalLabel.text = @"Input not valid!";
    }
}

- (BOOL)checkIfAllFieldsAreValid {
    //TODO: implement the checkmethod...
    return YES;
}

-(void)updateKcalLabel{
    self.kcalLabel.text = [self.settingsManager.kcalNeed stringValue];
}

- (IBAction)removeAllProducts:(id)sender {
    [self.parManager deleteMyProducts];
}

- (IBAction)removeAllRecipes:(id)sender {
    [self.parManager deleteMyRecipes];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
