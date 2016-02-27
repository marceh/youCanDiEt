//
//  DBManager.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+(id)getDBManager{
    static DBManager *dbManager = nil;
    //Init only once for singleton.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[self alloc] init];
    });
    return dbManager;
}

-(id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
