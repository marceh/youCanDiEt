//
//  WeekPlanner.h
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekPlanner : NSObject

@property (nonatomic) NSMutableArray *recipes;
@property (nonatomic) NSString *weekName;

-(instancetype)initWithWeekName:(NSString *)weekName andRecipes:(NSMutableArray *)recipes;

@end
