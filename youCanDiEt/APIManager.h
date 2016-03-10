//
//  APIManager.h
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

@property (nonatomic) NSNumber *kcalNeed;
@property (nonatomic) NSMutableArray *arrayDone;
@property (nonatomic) NSMutableArray *tempProducts;

+(id)getAPIManager;

- (void)searchedItemGetApiNumbers:(NSString *)item;

- (void)giveCorrespondingDictionaryBasedOnNumber:(NSString *)number andIndex:(int)index;

- (NSMutableArray *)getArrayBasedOnSearch;

@end
