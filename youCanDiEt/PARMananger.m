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
    }
    return self;
}

-(void)addProductToMyProducts:(Product *)product{
    [self.products addObject:product];
}

-(Product *)getProductInProductsAtIndex:(int)index{
    return [self.products objectAtIndex:index];
}

@end
