//
//  AddRecipeCustomTableViewCell.h
//  youCanDiEt
//
//  Created by Marcus on 2016-03-31.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRecipeCustomTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *labelName;
@property (nonatomic, weak) IBOutlet UILabel *labelGrams;
@property (nonatomic, weak) IBOutlet UISlider *sliderGrams;

- (IBAction)sliderValueChanged:(UISlider *)slider;

@end
