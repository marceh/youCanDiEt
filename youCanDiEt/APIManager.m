//
//  APIManager.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+(id)getAPIManager{
    static APIManager *apiManager = nil;
    //Init only once for singleton.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiManager = [[self alloc] init];
    });
    return apiManager;
}

-(id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
