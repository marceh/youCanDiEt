    //
//  WeekPlanner.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "WeekPlanner.h"
#import "Recipe.h"

@implementation WeekPlanner

-(instancetype)initWithWeekName:(NSString *)weekName andRecipes:(NSMutableArray *)recipes{
    self = [super init];
    if (self) {
        self.weekName = weekName;
        self.recipes = recipes;
        self.kcalInWeek = [self getNumberOfKCalInWeekBasedOnOnePortion];
    }
    return self;
}

-(NSNumber *)getNumberOfKCalInWeekBasedOnOnePortion{
    double sum = 0.00;
    for (Recipe *recipe in self.recipes) {
        sum += (([[[[recipe valueForKey:@"recipe"] dictionaryOfRecipeContent] valueForKey:@"kcal"] doubleValue]) / ([[[recipe valueForKey:@"recipe"] portions] doubleValue]));
    }
    return  [NSNumber numberWithInt:((int) sum)];
}

@end
