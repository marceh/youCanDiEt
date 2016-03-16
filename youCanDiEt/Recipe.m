//
//  Recipe.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.products = [dictionary valueForKey:@"products"];
        self.howTo = [dictionary valueForKey:@"howTo"];
        self.category = [dictionary valueForKey:@"category"];
        self.portions = [dictionary valueForKey:@"portions"];
    }
    return self;
}

@end
