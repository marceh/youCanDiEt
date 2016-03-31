//
//  RecipesTableViewCell.h
//  youCanDiEt
//
//  Created by Marcus on 2016-03-31.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipesTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageRecipePicture;
@property (nonatomic, weak) IBOutlet UILabel *labelRecipeName;

@end
