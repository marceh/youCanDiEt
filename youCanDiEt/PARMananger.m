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

-(void)logProductsArray{
    
    for(Product *product in self.products){
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
    
@end
