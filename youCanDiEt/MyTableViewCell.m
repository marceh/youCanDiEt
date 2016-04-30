//
//  MyTableViewCell.m
//  youCanDiEt
//
//  Created by Marcus on 2016-03-30.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
@synthesize labelName, labelGrams, sliderGrams, gramsInformation, textFieldGrams, buttonAddRecipe, productInformation, parManager;

- (void)awakeFromNib {
    textFieldGrams.delegate = self;
    parManager = [PARMananger getPARManager];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)sliderValueChanged:(UISlider *)slider {
    textFieldGrams.text = [NSString stringWithFormat:@"%d",(int)sliderGrams.value];
    gramsInformation = [NSNumber numberWithInt:[textFieldGrams.text intValue]];
}

- (IBAction)clickedAdd:(UIButton *)sender {
    [textFieldGrams resignFirstResponder];
    
    if (gramsInformation == nil) {
        [parManager addProductToArrayOfIngredients:productInformation andGrams:@100];
    } else {
        [parManager addProductToArrayOfIngredients:productInformation andGrams:gramsInformation];
    }
    
    sender.enabled = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [textFieldGrams resignFirstResponder];
}

@end
