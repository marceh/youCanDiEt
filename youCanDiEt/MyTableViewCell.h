//
//  MyTableViewCell.h
//  youCanDiEt
//
//  Created by Marcus on 2016-03-30.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface MyTableViewCell : UITableViewCell

@property Product *productInformation;
@property NSNumber *gramsInformation;
@property (nonatomic, weak) IBOutlet UILabel *labelName;
@property (nonatomic, weak) IBOutlet UILabel *labelGrams;
@property (nonatomic, weak) IBOutlet UISlider *sliderGrams;

- (IBAction)sliderValueChanged:(UISlider *)slider;



@end
