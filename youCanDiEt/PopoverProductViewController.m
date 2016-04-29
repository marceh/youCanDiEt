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

@end

@implementation PopoverProductViewController

- (void)viewDidLoad {
    NSLog(@"inne i viewdidload");
    [super viewDidLoad];
    NSLog(@"inne i viewdidload");
    self.parManager = [PARMananger getPARManager];
    self.tempDictionary = [NSMutableDictionary new];
    [self setTempDictionaryBasedOnNumber:self.parManager.productNumber];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateLabels{
    NSLog(@"UpdateLabels");
    self.labelKcal.text = [NSString stringWithFormat:@"Kcal: %@",[self.tempDictionary valueForKey:@"kcal"]];
    self.labelCarbs.text = [NSString stringWithFormat:@"Carbs: %@",[self.tempDictionary valueForKey:@"carbs"]];
    self.labelProtein.text = [NSString stringWithFormat:@"Protein: %@",[self.tempDictionary valueForKey:@"protein"]];
    self.labelFat.text = [NSString stringWithFormat:@"Fat: %@",[self.tempDictionary valueForKey:@"fat"]];
}
- (IBAction)saveTheProduct:(id)sender {
    [self.parManager addProductToMyProducts:[[Product alloc]initWithDictionary:self.tempDictionary]];
    [self.parManager saveProducts];
    [self goBack:self];
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
                                                                   
                                                                   NSLog(@"TempDictionary nedan:");
                                                                   [self.tempDictionary description];
                                                                   //set all the labels with the dictionary values...
                                                                   [self updateLabels];
                                                               });
                                            }];
    [task resume];
}

/*
 - (IBAction)popoverSegueProductClicked:(id)sender {
 [self performSegueWithIdentifier:@"popoverSegueProduct" sender:self];
 }
 
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if ([segue.identifier isEqualToString:@"popoverSegueProduct"]) {
 UIViewController *viewController = segue.destinationViewController;
 UIPopoverPresentationController *controller = viewController.popoverPresentationController;
 
 if (controller != nil) {
 controller.delegate = self;
 }
 }
 }
 
 -(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
 return UIModalPresentationNone;
 }
 
 -(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
 
 }*/


@end
