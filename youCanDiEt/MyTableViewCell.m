//
//  MyTableViewCell.m
//  youCanDiEt
//
//  Created by Marcus on 2016-03-30.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
@synthesize labelName, labelGrams, sliderGrams, gramsInformation;

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)sliderValueChanged:(UISlider *)slider {
    labelGrams.text = [NSString stringWithFormat:@"Grams: %d",(int)sliderGrams.value];
    gramsInformation = [NSNumber numberWithInt:(int)sliderGrams.value];
}


@end
