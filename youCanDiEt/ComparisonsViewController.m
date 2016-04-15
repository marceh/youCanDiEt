//
//  ComparisonsViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-04-01.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "ComparisonsViewController.h"
#import "PARMananger.h"

@interface ComparisonsViewController ()

@property (nonatomic) PARMananger *parManager;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIGravityBehavior *gravity;
@property (nonatomic) UICollisionBehavior *collision;

@end

@implementation ComparisonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    [self.parManager thisIsComparableRecipe:[self.parManager.recipes objectAtIndex:0] number:1];
    [self.parManager thisIsComparableRecipe:[self.parManager.recipes objectAtIndex:1] number:2];
    self.pickerOne.delegate = self;
    self.pickerOne.dataSource = self;
    [self.pickerOne selectRow:1 inComponent:1 animated:YES];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self.labelOne]];
    self.collision = [[UICollisionBehavior alloc] initWithItems:@[self.labelOne]];
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    [self enterGravity];
//    [self enterGravity];

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.parManager.recipes.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self.parManager.recipes objectAtIndex:row] name];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
        NSLog(@"Inne i pickerview");
    [self.parManager thisIsComparableRecipe:[self.parManager.recipes objectAtIndex:[self.pickerOne selectedRowInComponent:0]] number:1];
    [self.parManager thisIsComparableRecipe:[self.parManager.recipes objectAtIndex:[self.pickerOne selectedRowInComponent:1]] number:2];
    
    [self restoreLabelsForGravity];
    
    self.labelOne.text = [NSString stringWithFormat:@"%d",[self.parManager.comparableRecipeOne getDietValue]];
    self.labelTwo.text = [NSString stringWithFormat:@"%d",[self.parManager.comparableRecipeTwo getDietValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickedDetailedComparisons:(id)sender {
}
- (IBAction)clickedDietValuesComparisons:(id)sender {
    self.labelOne.text = [NSString stringWithFormat:@"%d",[self.parManager.comparableRecipeOne getDietValue]];
    self.labelTwo.text = [NSString stringWithFormat:@"%d",[self.parManager.comparableRecipeTwo getDietValue]];
    
    [self restoreLabelsForGravity];
    
    [self doAnimations];
    
    
    /*[UIView animateWithDuration:3.0 delay:0.0 options:kNilOptions animations:^{
       // self.labelTwo.center = finishedPosition;
        self.labelTwo.center = CGPointMake(237, self.view.bounds.size.height - 22.0);
        NSLog(@"inne i animatewith duration");
            NSLog(self.labelTwo.text);
    }completion:^(BOOL finished){
            NSLog(@"Inne i completion");
        [self enterGravity];
    }];*/




}

- (void)doAnimations {
    CGFloat bottomOfView = self.view.bounds.size.height - 22.0;
    CGPoint finishedPosition = CGPointMake(237, bottomOfView);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    self.labelTwo.center = finishedPosition;
    [UIView commitAnimations];
    [self enterGravity];
}

- (void)restoreLabelsForGravity {
        NSLog(@"Inne i restoreLabelsForGravity");
    [self.animator removeAllBehaviors];
    CGPoint labelOneStartingPosition = CGPointMake(50, 0);
    CGPoint labelTwoStartingPosition = CGPointMake(237, 0);
    self.labelOne.center = labelOneStartingPosition;
    self.labelTwo.center = labelTwoStartingPosition;
}

- (void)enterGravity {
    NSLog(@"Inne i enter gravity");
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Check the Null shit...
    if (self.parManager.comparableRecipeOne == nil && self.parManager.comparableRecipeTwo == nil) {
        NSLog(@"inne i segue...");
        [self.parManager thisIsComparableRecipe:[self.parManager.recipes objectAtIndex:0] number:1];
        [self.parManager thisIsComparableRecipe:[self.parManager.recipes objectAtIndex:1] number:2];
    }
}


@end
