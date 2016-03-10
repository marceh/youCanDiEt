//
//  ViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "MenuViewController.h"
#import "PARMananger.h"

@interface MenuViewController ()

@property (nonatomic) PARMananger *parManager;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    [self.parManager loadProducts];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
