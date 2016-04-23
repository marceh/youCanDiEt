//
//  WeekPlanner.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "WeekPlanner.h"

@implementation WeekPlanner

-(instancetype)initWithWeekName:(NSString *)weekName andRecipes:(NSMutableArray *)recipes{
    self = [super init];
    if (self) {
        self.weekName = weekName;
        self.recipes = recipes;
        self.kcalInWeek = [self getNumberOfKCalInWeek];
    }
    return self;
}

-(NSNumber *)getNumberOfKCalInWeek{
    //TODO: Fix this method
    return @(2500 * 7);
}

@end
