//
//  Recipe.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "Recipe.h"
#import "Product.h"

@implementation Recipe

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.products = [dictionary valueForKey:@"products"];
        self.howTo = [dictionary valueForKey:@"howTo"];
        self.category = [dictionary valueForKey:@"category"];
        self.portions = [dictionary valueForKey:@"portions"];
        self.picPath = [dictionary valueForKey:@"picPath"];
        self.name = [dictionary valueForKey:@"name"];
        self.dictionaryOfRecipeContent = [self getTotalContentInRecipe];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.products = [decoder decodeObjectForKey:@"products"];
        self.howTo = [decoder decodeObjectForKey:@"howTo"];
        self.category = [decoder decodeObjectForKey:@"category"];
        self.portions = [decoder decodeObjectForKey:@"portions"];
        self.picPath = [decoder decodeObjectForKey:@"picPath"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.dictionaryOfRecipeContent = [self getTotalContentInRecipe];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.products forKey:@"products"];
    [encoder encodeObject:self.howTo forKey:@"howTo"];
    [encoder encodeObject:self.category forKey:@"category"];
    [encoder encodeObject:self.portions forKey:@"portions"];
    [encoder encodeObject:self.picPath forKey:@"picPath"];
    [encoder encodeObject:self.name forKey:@"name"];
}

- (void)logTheRecipeProducts {
    for (Product *product in self.products){
        [[product valueForKey:@"product"] description];
    }
}

- (NSString *)getTheRightFolderAndImagePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    return [path stringByAppendingPathComponent:self.picPath];
   // return [path stringByAppendingPathComponent:@"cachedImage.png"];
}

- (NSDictionary *)getTotalContentInRecipe{
    NSDictionary *tempDictionary = @{@"kcal" : [self getTotalKeyWordContentInRecipeBasedOnKeyWord:@"kcal"], @"carbs" : [self getTotalKeyWordContentInRecipeBasedOnKeyWord:@"carbs"], @"protein" : [self getTotalKeyWordContentInRecipeBasedOnKeyWord:@"protein"], @"fat" : [self getTotalKeyWordContentInRecipeBasedOnKeyWord:@"fat"]};
    return tempDictionary;
}
 
- (NSNumber *)getTotalKeyWordContentInRecipeBasedOnKeyWord:(NSString *)keyWord{
    int sum = 0;
    for (NSMutableDictionary *productinfo in self.products){
        sum += [[[productinfo valueForKey:@"product"] valueForKey:keyWord] intValue] * [[productinfo valueForKey:@"grams"] intValue] / 100;
    }
    return [NSNumber numberWithInt:sum];
}

- (int)getDietValue{
    double tempDouble = [[self getTotalKeyWordContentInRecipeBasedOnKeyWord:@"protein"] doubleValue] / [[self getTotalKeyWordContentInRecipeBasedOnKeyWord:@"kcal"] doubleValue];
    
    if (tempDouble < 0.02) {
        return 0;
    } else if (tempDouble < 0.04) {
        return 1;
    } else if (tempDouble < 0.06) {
        return 2;
    } else if (tempDouble < 0.08) {
        return 3;
    } else if (tempDouble < 0.10) {
        return 4;
    } else {
        return 5;
    }
}

@end
