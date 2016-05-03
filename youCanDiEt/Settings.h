//
//  Settings.h
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property (nonatomic) NSNumber *kcalNeed;

+(id)getSetting;

//Gender: write m for male and f for female.
//Height: write in cm (integer).
//Weight: write in kg (integer).
-(double)calculateKcalNeedsUsingGender:(char)gender age:(int)age height:(int)height weight:(int)weight andDaysOfExercisePerWeek:(int)daysOfExercisePerWeek;

-(void)saveKcalNeed;

-(void)loadKcalNeed;

@end
