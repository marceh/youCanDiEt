//
//  Settings.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "Settings.h"

@implementation Settings

+(id)getSetting{
    static Settings *settings = nil;
    //Init only once for singleton.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[self alloc] init];
    });
    return settings;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.kcalNeed = @2500;
    }
    return self;
}

@end