//
//  MyTableViewCell.h
//  youCanDiEt
//
//  Created by Marcus on 2016-03-30.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "PARMananger.h"

@interface MyTableViewCell : UITableViewCell <UITextFieldDelegate>

@property Product *productInformation;
@property NSNumber *gramsInformation;
@property (nonatomic, weak) IBOutlet UILabel *labelName;
@property (nonatomic, weak) IBOutlet UILabel *labelGrams;
@property (nonatomic, weak) IBOutlet UISlider *sliderGrams;
@property (weak, nonatomic) IBOutlet UITextField *textFieldGrams;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddRecipe;
@property (nonatomic) PARMananger *parManager;

@end
