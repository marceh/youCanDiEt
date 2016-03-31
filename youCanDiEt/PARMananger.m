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
        self.arrayOfIngredients = [NSMutableArray new];
        self.dictionaryCurrentRecipe = [NSMutableDictionary new];
    }
    return self;
}

-(void)addProductToMyProducts:(Product *)product{
    [self.products addObject:product];
}

-(void)addProductToArrayOfIngredients:(Product *)product{
    NSLog(@"adding shit to arrayofIngredients...logging array below:");
    [self logIngredientArray];
    [self.arrayOfIngredients addObject:product];
}

-(Product *)getProductInProductsAtIndex:(int)index{
    return [self.products objectAtIndex:index];
}

-(Product *)getProductInArrayOfIngredientsAtIndex:(int)index{
    return [self.arrayOfIngredients objectAtIndex:index];
}

-(void)logProductsArray{
    
    for(Product *product in self.products){
        NSLog([product description]);
    }
}

-(void)logIngredientArray{
    
    for(Product *product in self.arrayOfIngredients){
        NSLog([product description]);
    }
}

-(void)saveProducts{
    NSLog(@"savingProducts");
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setInteger:self.products.count forKey:@"productsCount"];
    
    for (int i = 0, length = self.products.count; i<length; i++) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.products[i]];
        [settings setObject:data forKey:[NSString stringWithFormat:@"products[%d]",i]];
    }
    [settings synchronize];
}

-(void)loadProducts{
    NSLog(@"loadingProducts");
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSInteger productsCount = [settings integerForKey:@"productsCount"];
    
    for (int i = 0; i<productsCount; i++) {
        NSData *data = [settings objectForKey:[NSString stringWithFormat:@"products[%d]",i]];
        [self addProductToMyProducts:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
}

//will clear when entring add recipe from my recipe segue...
-(void)clearCurrentRecipe {
    NSLog(@"cleared dictionary");
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
    Recipe *newRecipe = [[Recipe alloc]initWithDictionary:self.dictionaryCurrentRecipe];
}


@end
