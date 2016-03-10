//
//  ProductInfoClickViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "ProductInfoClickViewController.h"

@interface ProductInfoClickViewController ()
@property (weak, nonatomic) IBOutlet UITextView *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelKcal;
@property (weak, nonatomic) IBOutlet UILabel *labelCarbs;
@property (weak, nonatomic) IBOutlet UILabel *labelProtein;
@property (weak, nonatomic) IBOutlet UILabel *labelFat;
@property (nonatomic) NSMutableDictionary *tempDictionary;
@end

@implementation ProductInfoClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tempDictionary = [NSMutableDictionary new];
    NSLog([NSString stringWithFormat:@"%@",self.productNumber]);
    //getshit
    [self updateInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateInformation{
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
