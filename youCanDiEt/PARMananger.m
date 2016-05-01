//
//  PARMananger.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "PARMananger.h"

@implementation PARMananger

+(id)getPARManager{
    static PARMananger *parManager = nil;
    //Init only once for singleton.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parManager = [[self alloc] init];
    });
    return parManager;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.products = [NSMutableArray new];
        self.recipes = [NSMutableArray new];
        self.weeks = [NSMutableArray new];
        self.arrayOfIngredients = [NSMutableArray new];
        self.dictionaryCurrentRecipe = [NSMutableDictionary new];
    }
    return self;
}

-(void)addProductToMyProducts:(Product *)product{
    [self.products insertObject:product atIndex:0];
}

-(void)addRecipeToMyRecipes:(Recipe *)recipe{
    [self.recipes insertObject:recipe atIndex:0];
}

-(void)addWeekToMyWeeks:(WeekPlanner *)week{
    if (self.editingWeek) {
        [self.weeks replaceObjectAtIndex:self.indexPathFromEditWeek withObject:week];
    } else {
        [self.weeks insertObject:week atIndex:0];
    }
    self.editingWeek = NO;
}

-(void)addProductToArrayOfIngredients:(Product *)product andGrams:(NSNumber *)grams{
    NSDictionary *tempDictionary = @{@"product" : product, @"grams" : grams};
    [self.arrayOfIngredients insertObject:tempDictionary atIndex:0];
}

-(Product *)getProductInProductsAtIndex:(int)index{
    return [self.products objectAtIndex:index];
}

-(Product *)getProductInArrayOfIngredientsAtIndex:(int)index{
    return [[self.arrayOfIngredients objectAtIndex:index] valueForKey:@"product"];
}

-(NSNumber *)getProductGramsInArrayOfIngredientsAtIndex:(int)index{
    return [[self.arrayOfIngredients objectAtIndex:index] valueForKey:@"grams"];
}

-(void)saveProducts{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setInteger:self.products.count forKey:@"productsCount"];
    
    for (int i = 0, length = self.products.count; i<length; i++) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.products[i]];
        [settings setObject:data forKey:[NSString stringWithFormat:@"products[%d]",i]];
    }
    [settings synchronize];
}

-(void)saveRecipes{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setInteger:self.recipes.count forKey:@"recipesCount"];
    
    for (int i = 0, length = self.recipes.count; i<length; i++) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.recipes[i]];
        [settings setObject:data forKey:[NSString stringWithFormat:@"recipes[%d]",i]];
    }
    [settings synchronize];
}

-(void)saveWeeks{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setInteger:self.weeks.count forKey:@"weeksCount"];
    
    for (int i = 0, length = self.weeks.count; i<length; i++) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.weeks[i]];
        [settings setObject:data forKey:[NSString stringWithFormat:@"weeks[%d]",i]];
    }
    [settings synchronize];
}

-(void)loadProductsAndRecipesAndWeeks{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSInteger productsCount = [settings integerForKey:@"productsCount"];
    
    for (int i = productsCount; i>0; i--) {
        NSData *data = [settings objectForKey:[NSString stringWithFormat:@"products[%d]",i-1]];
        [self addProductToMyProducts:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
    
    NSInteger recipesCount = [settings integerForKey:@"recipesCount"];
    
    for (int i = recipesCount; i>0; i--) {
        NSData *data = [settings objectForKey:[NSString stringWithFormat:@"recipes[%d]",i-1]];
        [self addRecipeToMyRecipes:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
    
    NSInteger weeksCount = [settings integerForKey:@"weeksCount"];
    
    for (int i = weeksCount; i>0; i--) {
        NSData *data = [settings objectForKey:[NSString stringWithFormat:@"weeks[%d]",i-1]];
        [self addWeekToMyWeeks:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }

}

//will clear when entring add recipe from my recipe segue...
-(void)clearCurrentRecipe {
    [self.dictionaryCurrentRecipe removeAllObjects];
}

-(void)addName2CurrentRecipe:(NSString *)name {
    [self.dictionaryCurrentRecipe setObject:name forKey:@"name"];
}

-(void)addCategory2CurrentRecipe:(NSString *)category {
    [self.dictionaryCurrentRecipe setObject:category forKey:@"category"];
}

-(void)addPortions2CurrentRecipe:(NSNumber *)portions {
    [self.dictionaryCurrentRecipe setObject:portions forKey:@"portions"];
}

-(void)addHowTo2CurrentRecipe:(NSString *)howTo {
    [self.dictionaryCurrentRecipe setObject:howTo forKey:@"howTo"];
}

-(void)addPicPath2CurrentRecipe:(NSString *)picPath {
    [self.dictionaryCurrentRecipe setObject:picPath forKey:@"picPath"];
}

-(void)addProducts2CurrentRecipe :(NSArray *)products {
    [self.dictionaryCurrentRecipe setObject:products forKey:@"products"];
}

-(void)convertDictionaryCurrentRecipe2RecipeAndAdd2PARManager {
    [self addProducts2CurrentRecipe:self.arrayOfIngredients];
    Recipe *newRecipe = [[Recipe alloc]initWithDictionary:self.dictionaryCurrentRecipe];
    
    if (self.fromAlertContoller) {
        [self.recipes replaceObjectAtIndex:self.indexPathFromEditRecipe withObject:newRecipe];
    } else {
        [self addRecipeToMyRecipes:newRecipe];
    }
    [self saveRecipes];
}

-(void)deleteMyProducts {
    [self.products removeAllObjects];
    [self saveProducts];
}

-(void)deleteMyRecipes {
    [self.recipes removeAllObjects];
    [self saveRecipes];
}

-(void)deleteMyWeeks {
    [self.weeks removeAllObjects];
    [self saveWeeks];
}

-(void)thisIsComparableRecipe:(Recipe *)recipe number:(int)number {
    if (number == 1) {
        self.comparableRecipeOne = recipe;
    } else {
        self.comparableRecipeTwo = recipe;
    }
}

@end
