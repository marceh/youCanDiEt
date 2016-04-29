//
//  PopoverProductViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-04-29.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "PopoverProductViewController.h"

@interface PopoverProductViewController ()

@end

@implementation PopoverProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)leftButtonClicked:(id)sender {
    NSLog(@"vänster");
}

- (IBAction)rightButtonClicked:(id)sender {
    NSLog(@"höger");
}

@end
