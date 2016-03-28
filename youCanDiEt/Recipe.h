//
//  Recipe.h
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic) NSMutableArray *products;
@property (nonatomic) NSString *howTo;
//Categories = breakfast, lunch, snack, dinner, supper.
@property (nonatomic) NSString *category;
@property (nonatomic) NSNumber *portions;
@property (nonatomic) NSString *picPath;
@property (nonatomic) NSString *name;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
