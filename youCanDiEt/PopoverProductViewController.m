//
//  ProductInfoClickViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "PopoverProductViewController.h"
#import "Product.h"
#import "PARMananger.h"

@interface PopoverProductViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelKcal;
@property (weak, nonatomic) IBOutlet UILabel *labelCarbs;
@property (weak, nonatomic) IBOutlet UILabel *labelProtein;
@property (weak, nonatomic) IBOutlet UILabel *labelFat;
@property (nonatomic) NSMutableDictionary *tempDictionary;
@property (nonatomic) PARMananger *parManager;
@property (nonatomic) BOOL haveFinishedLoadingLabels;

@end

@implementation PopoverProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.haveFinishedLoadingLabels = NO;
    self.parManager = [PARMananger getPARManager];
    self.tempDictionary = [NSMutableDictionary new];
    [self setTempDictionaryBasedOnNumber:self.parManager.productNumber];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updateLabels{
    self.labelKcal.text = [NSString stringWithFormat:@"Kcal: %d",[[self.tempDictionary valueForKey:@"kcal"] intValue]];
    self.labelCarbs.text = [NSString stringWithFormat:@"Carbs: %.1f",[[self.tempDictionary valueForKey:@"carbs"] doubleValue]];
    self.labelProtein.text = [NSString stringWithFormat:@"Protein: %.1f",[[self.tempDictionary valueForKey:@"protein"] doubleValue]];
    self.labelFat.text = [NSString stringWithFormat:@"Fat: %.1f",[[self.tempDictionary valueForKey:@"fat"] doubleValue]];
    self.haveFinishedLoadingLabels = YES;
}

- (IBAction)saveTheProduct:(id)sender {
    if (self.haveFinishedLoadingLabels) {
        [self.parManager addProductToMyProducts:[[Product alloc]initWithDictionary:self.tempDictionary]];
        [self.parManager saveProducts];
        [self goBack:self];
    }
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setTempDictionaryBasedOnNumber:(NSNumber *)number{
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
                                                                   [self.tempDictionary setValue:[json valueForKey:@"name"] forKey:@"name"];
                                                                   [self.tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"energyKcal"] stringValue] forKey:@"kcal"];
                                                                   [self.tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"carbohydrates"] stringValue] forKey:@"carbs"];
                                                                   [self.tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"protein"] stringValue] forKey:@"protein"];
                                                                   [self.tempDictionary setValue:[[nutrientValuesInJSON valueForKey:@"fat"] stringValue] forKey:@"fat"];
                                                                   [self.tempDictionary description];
                                                                   [self updateLabels];
                                                               });
                                            }];
    [task resume];
}

@end
