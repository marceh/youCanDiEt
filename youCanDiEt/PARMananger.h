//
//  PARMananger.h
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface PARMananger : NSObject <NSCoding>

@property (nonatomic) NSMutableArray *products;
@property (nonatomic) NSMutableArray *recipes;
@property (nonatomic) NSMutableArray *arrayOfIngredients;

+(id)getPARManager;

-(void)addProductToMyProducts:(Product *)product;

-(void)addProductToArrayOfIngredients:(Product *)product;

-(Product *)getProductInProductsAtIndex:(int)index;

-(Product *)getProductInArrayOfIngredientsAtIndex:(int)index;

-(void)logProductsArray;

-(void)logIngredientArray;

-(void)saveProducts;

-(void)loadProducts;

@end
