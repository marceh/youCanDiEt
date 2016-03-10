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

- (NSMutableArray *)getArrayBasedOnSearch{
    return self.arrayDone;
}

- (void)searchedItemGetApiNumbers:(NSString *)item {
    NSMutableArray *tempArray = [NSMutableArray new];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://matapi.se/foodstuff?query=%@",item] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSError *parseError;
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                dispatch_async(dispatch_get_main_queue(),
                                                               ^{
                                                                   for (id jsonObject in json) {
                                                                       [tempArray addObject:[jsonObject valueForKey:@"number"]];
                                                                   }
                                                                   self.tempProducts = [tempArray copy];
                                                                   if (self.tempProducts.count == 0) {
                                                                     //  [self.arrayDone addObject:@{@"name" : @"No product matched your search..."}];
                                                                     //  [self.tableView reloadData];
                                                                     //  self.textFieldSearch.text = @"";
                                                                   } else {
                                                                       [self giveCorrespondingDictionaryBasedOnNumber:[self.tempProducts[0] stringValue] andIndex:0];
                                                                   }
                                                               });
                                            }];
    [task resume];
}

- (void)giveCorrespondingDictionaryBasedOnNumber:(NSString *)number andIndex:(int)index{
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://matapi.se/foodstuff/%@",number]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSError *parseError;
                                                NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                                                dispatch_async(dispatch_get_main_queue(),
                                                               ^{
                                                                   NSDictionary *nutrientValuesInJSON = [json valueForKey:@"nutrientValues"];
                                                                   [tempDictionary setValue:[json valueForKey:@"name"] forKey:@"name"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"energyKcal"] stringValue] forKey:@"kcal"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"carbohydrates"] stringValue] forKey:@"carbs"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"protein"] stringValue] forKey:@"protein"];
                                                                   [tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"fat"] stringValue] forKey:@"fat"];
                                                                   [self.arrayDone addObject:tempDictionary];
                                                                   if (index < self.tempProducts.count -1) {
                                                                       [self giveCorrespondingDictionaryBasedOnNumber:[self.tempProducts[index+1] stringValue] andIndex:index+1];
                                                                   } else {
                                                         //              [self.tableView reloadData];
                                                         //              self.textFieldSearch.text = @"";
                                                                   }
                                                                   
                                                               });
                                            }];
    [task resume];
}


@end
