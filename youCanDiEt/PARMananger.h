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
#import "WeekPlanner.h"

@interface PARMananger : NSObject <NSCoding>

@property (nonatomic) NSMutableArray *products;
@property (nonatomic) NSMutableArray *recipes;
@property (nonatomic) NSMutableArray *weeks;
@property (nonatomic) NSMutableArray *arrayOfIngredients;
@property (nonatomic) NSMutableDictionary *dictionaryCurrentRecipe;
@property (nonatomic) Recipe *comparableRecipeOne;
@property (nonatomic) Recipe *comparableRecipeTwo;
@property (nonatomic) Recipe *recipeForEditing;
@property (nonatomic) NSMutableArray *selectedWeek;
@property (nonatomic) BOOL fromClickedRecipes;
@property (nonatomic) BOOL editingRecipe;
@property (nonatomic) BOOL fromAlertContoller;
@property (nonatomic) NSNumber *productNumber;
@property (nonatomic) NSInteger indexPathFromEditRecipe;

+(id)getPARManager;

-(void)addProductToMyProducts:(Product *)product;

-(void)addWeekToMyWeeks:(WeekPlanner *)week;

-(void)addProductToArrayOfIngredients:(Product *)product andGrams:(NSNumber *)grams;

-(Product *)getProductInProductsAtIndex:(int)index;

-(Product *)getProductInArrayOfIngredientsAtIndex:(int)index;

-(void)logProductsArray;

-(void)saveProducts;

-(void)saveRecipes;

-(void)saveWeeks;

-(void)loadProductsAndRecipesAndWeeks;

-(void)clearCurrentRecipe;

-(void)addName2CurrentRecipe:(NSString *)name;

-(void)addCategory2CurrentRecipe:(NSString *)category;

-(void)addPortions2CurrentRecipe:(NSNumber *)portions;

-(void)addHowTo2CurrentRecipe:(NSString *)howTo;

-(void)addPicPath2CurrentRecipe:(NSString *)picPath;

-(void)addProducts2CurrentRecipe :(NSArray *)products;

-(void)convertDictionaryCurrentRecipe2RecipeAndAdd2PARManager;

-(void)deleteMyProducts;

-(void)deleteMyRecipes;

-(void)deleteMyWeeks;

-(void)thisIsComparableRecipe:(Recipe *)recipe number:(int)number;

@end
