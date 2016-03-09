//
//  Product.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.name = [dictionary valueForKey:@"name"];
        self.kcal = [dictionary valueForKey:@"kcal"];
        self.carbs = [dictionary valueForKey:@"carbs"];
        self.protein = [dictionary valueForKey:@"protein"];
        self.fat = [dictionary valueForKey:@"fat"];
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"Name: %@, Kcal: %@, Carbs: %@, Protein: %@, Fat: %@...",self.name,self.kcal,self.carbs,self.protein,self.fat];
}

@end
