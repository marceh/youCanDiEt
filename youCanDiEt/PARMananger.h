//
//  PARMananger.h
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Recipe.h"

@interface PARMananger : NSObject <NSCoding>

@property (nonatomic) NSMutableArray *products;
@property (nonatomic) NSMutableArray *recipes;
@property (nonatomic) NSMutableArray *arrayOfIngredients;
@property (nonatomic) NSMutableDictionary *dictionaryCurrentRecipe;

+(id)getPARManager;

-(void)addProductToMyProducts:(Product *)product;

-(void)addProductToArrayOfIngredients:(Product *)product andGrams:(NSNumber *)grams;

-(Product *)getProductInProductsAtIndex:(int)index;

-(Product *)getProductInArrayOfIngredientsAtIndex:(int)index;

-(void)logProductsArray;

-(void)logIngredientArray;

-(void)saveProducts;

-(void)loadProducts;

-(void)clearCurrentRecipe;

-(void)addName2CurrentRecipe:(NSString *)name;

-(void)addCategory2CurrentRecipe:(NSString *)category;

-(void)addPortions2CurrentRecipe:(NSNumber *)portions;

-(void)addHowTo2CurrentRecipe:(NSString *)howTo;

-(void)addPicPath2CurrentRecipe:(NSString *)picPath;

-(void)addProducts2CurrentRecipe :(NSArray *)products;

-(void)convertDictionaryCurrentRecipe2RecipeAndAdd2PARManager;

@end
