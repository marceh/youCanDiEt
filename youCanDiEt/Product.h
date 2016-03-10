//
//  Product.h
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject <NSCoding>

@property (nonatomic) NSString *name;
@property (nonatomic) NSNumber *kcal;
@property (nonatomic) NSNumber *carbs;
@property (nonatomic) NSNumber *protein;
@property (nonatomic) NSNumber *fat;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end
