//
//  Settings.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "Settings.h"

@implementation Settings

+(id)getSetting{
    static Settings *settings = nil;
    //Init only once for singleton.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[self alloc] init];
    });
    return settings;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.kcalNeed = @2500;
    }
    return self;
}

-(double)calculateKcalNeedsUsingGender:(char)gender age:(int)age height:(int)height weight:(int)weight andDaysOfExercisePerWeek:(int)daysOfExercisePerWeek{
    
    double burnedKcalPerDay;
    double trainingMultiple;
    
    //Determining the multiple depending on how many kcal you burn by exercising.
    if (daysOfExercisePerWeek < 1) {
        trainingMultiple = 1.2;
    } else if (daysOfExercisePerWeek < 4){
        trainingMultiple = 1.375;
    } else if (daysOfExercisePerWeek < 6){
        trainingMultiple = 1.55;
    } else if (daysOfExercisePerWeek < 8){
        trainingMultiple = 1.725;
    } else {
        trainingMultiple = 1.9;
    }
    
    //Depending on gender, you burn kcal differently.
    if (gender == 'm') {
        burnedKcalPerDay = trainingMultiple * (88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age));
    } else if (gender == 'f'){
       burnedKcalPerDay = trainingMultiple * (447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age));
    }
    
    return burnedKcalPerDay;
}

-(void)saveKcalNeed{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setInteger:[self.kcalNeed intValue] forKey:@"kcalNeed"];
    [settings synchronize];
}

-(void)loadKcalNeed{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    self.kcalNeed = [NSNumber numberWithInt:[settings integerForKey:@"kcalNeed"]];
}

@end