//
//  MyTabBarViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-04-29.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "MyTabBarViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelectedIndex:0];
    
    UISwipeGestureRecognizer *leftToRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftToRight)];
    leftToRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftToRightGestureRecognizer];
    
    UISwipeGestureRecognizer *rightToLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightToLeft)];
    rightToLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightToLeftGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftToRight {
    UITabBar *tabBar = self.tabBar;
    NSInteger index = [tabBar.items indexOfObject:tabBar.selectedItem];
    if (index > 0) {
        self.selectedIndex = index - 1;
    } else {
        return;
    }
}

- (void)rightToLeft{
    UITabBar *tabBar = self.tabBar;
    NSInteger index = [tabBar.items indexOfObject:tabBar.selectedItem];
    if (index < tabBar.items.count - 1) {
        self.selectedIndex = index + 1;
    } else {
        return;
    }
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
