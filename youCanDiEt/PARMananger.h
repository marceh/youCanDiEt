//
//  PARMananger.h
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface PARMananger : NSObject

@property (nonatomic) NSMutableArray *products;
@property (nonatomic) NSMutableArray *recipes;

+(id)getPARManager;

-(void)addProductToMyProducts:(Product *)product;

-(Product *)getProductInProductsAtIndex:(int)index;

@end
