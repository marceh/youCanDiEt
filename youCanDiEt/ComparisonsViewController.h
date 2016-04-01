//
//  ComparisonsViewController.h
//  youCanDiEt
//
//  Created by Marcus on 2016-04-01.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComparisonsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerOne;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;

@end
