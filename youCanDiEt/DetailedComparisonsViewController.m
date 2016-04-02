//
//  DetailedComparisonsViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-04-02.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "DetailedComparisonsViewController.h"
#import "PARMananger.h"

@interface DetailedComparisonsViewController ()

@property (weak, nonatomic) IBOutlet GKBarGraph *graph;
@property (weak, nonatomic) PARMananger *parManager;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;

@end

@implementation DetailedComparisonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    self.labelOne.tintColor = [UIColor greenColor];
    self.labelTwo.tintColor = [UIColor yellowColor];
    self.labelOne.text = self.parManager.comparableRecipeOne.name;
    self.labelTwo.text = self.parManager.comparableRecipeTwo.name;
    self.graph.dataSource = self;
    self.graph.barHeight = 250.00;
    [self.graph draw];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfBars {
    return 8;
}
- (NSNumber *)valueForBarAtIndex:(NSInteger)index{
    return [self getTheValueBasedOnIndex:index];
    
    
    
    /*if (index == 0) {
        return [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"kcal"];
    } else if (index == 1) {
        return [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"kcal"];
    } else if (index == 2) {
        return [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"carbs"];
    } else if (index == 3) {
        return [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"carbs"];
    } else if (index == 4) {
        return [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"protein"];
    } else if (index == 5) {
        return [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"protein"];
    } else if (index == 6) {
        return [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"fat"];
    } else {
        return [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"fat"];
    }*/
}

-(UIColor *)colorForBarAtIndex:(NSInteger)index {
    if (index % 2 == 0) {
        return [UIColor greenColor];
    } else {
        return [UIColor yellowColor];
    }
}

- (NSString *)titleForBarAtIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%@", [self getTheValueBasedOnIndex:index]];
   
    
    
    /* if (index == 0) {
        return [NSString stringWithFormat:@"%@", [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"kcal"]];
    } else if (index == 1) {
        return [NSString stringWithFormat:@"%@", [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"kcal"]];
    } else if (index == 2) {
        return [NSString stringWithFormat:@"%@", [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"carbs"]];
    } else if (index == 3) {
        return [NSString stringWithFormat:@"%@", [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"carbs"]];
    } else if (index == 4) {
        return [NSString stringWithFormat:@"%@", [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"protein"]];
    } else if (index == 5) {
        return [NSString stringWithFormat:@"%@", [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"protein"]];
    } else if (index == 6) {
        return [NSString stringWithFormat:@"%@", [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"fat"]];
    } else {
        return [NSString stringWithFormat:@"%@", [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"fat"]];
    }*/
}

- (NSNumber *)getTheValueBasedOnIndex:(NSInteger)index {
    if (index == 0) {
        return [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"kcal"];
    } else if (index == 1) {
        return [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"kcal"];
    } else if (index == 2) {
        return [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"carbs"];
    } else if (index == 3) {
        return [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"carbs"];
    } else if (index == 4) {
        return [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"protein"];
    } else if (index == 5) {
        return [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"protein"];
    } else if (index == 6) {
        return [self.parManager.comparableRecipeOne.dictionaryOfRecipeContent valueForKey:@"fat"];
    } else {
        return [self.parManager.comparableRecipeTwo.dictionaryOfRecipeContent valueForKey:@"fat"];
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
