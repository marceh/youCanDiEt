//
//  WeekPlanner.h
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekPlanner : NSObject <NSCoding, NSCopying>

@property (nonatomic) NSMutableArray *recipes;
@property (nonatomic) NSString *weekName;
@property (nonatomic) NSNumber *kcalInWeek;

-(instancetype)initWithWeekName:(NSString *)weekName andRecipes:(NSMutableArray *)recipes;

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

-(id)copyWithZone:(NSZone *)zone;

@end
