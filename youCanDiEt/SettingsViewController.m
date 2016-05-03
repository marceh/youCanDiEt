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
@property (weak, nonatomic) IBOutlet UISegmentedControl *removeSegmentedControll;
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
    [self tappedBackground:self];
    if ([self checkIfAllFieldsAreValid]) {
        int age = [self.ageTextField.text intValue];
        int height = [self.heightTextField.text intValue];
        int weight = [self.weightTextView.text intValue];
        int daysOfExercisePerWeek = [self.trainingSessionsTextView.text intValue];
        
        self.settingsManager.kcalNeed = [NSNumber numberWithInt:(int)[self.settingsManager calculateKcalNeedsUsingGender:self.gender age:age height:height weight:weight andDaysOfExercisePerWeek:daysOfExercisePerWeek]];
        [self updateKcalLabel];
        [self.settingsManager saveKcalNeed];
    } else {
        self.kcalLabel.text = @"Input not valid...";
    }
}

- (BOOL)checkIfAllFieldsAreValid {
    BOOL tempBool = YES;
    if ([self.ageTextField.text isEqualToString:@""]) {
        tempBool = NO;
    } else if ([self.heightTextField.text isEqualToString:@""]) {
        tempBool = NO;
    } else if ([self.weightTextView.text isEqualToString:@""]) {
        tempBool = NO;
    } else if ([self.trainingSessionsTextView.text isEqualToString:@""]) {
        tempBool = NO;
    }
    return tempBool;
}

-(void)updateKcalLabel{
    self.kcalLabel.text = [NSString stringWithFormat:@"Kcal need: %@",[self.settingsManager.kcalNeed stringValue]];
}

- (IBAction)removeAllProducts:(id)sender {
    [self safetyCehckWithObjectType:1];
}

- (IBAction)removeAllRecipes:(id)sender {
    [self safetyCehckWithObjectType:2];
}

- (IBAction)removeAllWeeks:(id)sender {
    [self safetyCehckWithObjectType:3];
}

- (IBAction)clickedSegmentedControll:(UISegmentedControl *)sender {
    NSInteger index = self.removeSegmentedControll.selectedSegmentIndex;
    
    switch(index)
    {
        case 0:
            [self safetyCehckWithObjectType:3];
            break;
        case 1:
            [self safetyCehckWithObjectType:2];
            break;
        case 2:
            [self safetyCehckWithObjectType:1];
            break;
        default : break;
    }
}

- (void)safetyCehckWithObjectType:(int)objectType {

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Remove" message:@"This will erase all objects!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *remove = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (objectType == 1) {
            [self.parManager deleteMyProducts];
        } else if (objectType == 2) {
            [self.parManager deleteMyRecipes];
        } else {
            [self.parManager deleteMyWeeks];
        }
        self.removeSegmentedControll.selectedSegmentIndex = -1;
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.removeSegmentedControll.selectedSegmentIndex = -1;
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:remove];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)tappedBackground:(id)sender {
    [self.ageTextField resignFirstResponder];
    [self.heightTextField resignFirstResponder];
    [self.weightTextView resignFirstResponder];
    [self.trainingSessionsTextView resignFirstResponder];
}

@end
