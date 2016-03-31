//
//  AddRecipeCustomTableViewCell.m
//  youCanDiEt
//
//  Created by Marcus on 2016-03-31.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "AddRecipeCustomTableViewCell.h"

@implementation AddRecipeCustomTableViewCell
@synthesize labelName, labelGrams, sliderGrams;

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sliderValueChanged:(UISlider *)slider {
    labelGrams.text = [NSString stringWithFormat:@"Grams: %d",(int)sliderGrams.value];
}

@end
