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

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.kcal = [decoder decodeObjectForKey:@"kcal"];
        self.carbs = [decoder decodeObjectForKey:@"carbs"];
        self.protein = [decoder decodeObjectForKey:@"protein"];
        self.fat = [decoder decodeObjectForKey:@"fat"];
    }
        return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.kcal forKey:@"kcal"];
    [encoder encodeObject:self.carbs forKey:@"carbs"];
    [encoder encodeObject:self.protein forKey:@"protein"];
    [encoder encodeObject:self.fat forKey:@"fat"];
}


@end
