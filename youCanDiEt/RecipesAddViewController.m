//
//  RecipesAddViewController.m
//  youCanDiEt
//
//  Created by Marcus on 2016-02-27.
//  Copyright © 2016 Marcus Cehlin. All rights reserved.
//

#import "RecipesAddViewController.h"
#import "Recipe.h"
#import "PARMananger.h"
#import "AddRecipeCustomTableViewCell.h"

@interface RecipesAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewCategory;
@property (weak, nonatomic) IBOutlet UILabel *labelNrOfPortions;
@property (weak, nonatomic) IBOutlet UIStepper *stepperPortions;
@property (weak, nonatomic) IBOutlet UITableView *tabeViewIngredients;
//@property (weak, nonatomic) IBOutlet UISlider *sliderInCell;s
//@property (weak, nonatomic) IBOutlet UILabel *nameInCell;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;
@property (nonatomic) NSArray *arrayCategories;
@property (nonatomic) NSString *categorySelected;
@property (nonatomic) PARMananger *parManager;
@property (nonatomic) NSMutableDictionary *dictionaryPrep4RecipInit;

@end

@implementation RecipesAddViewController

- (void)viewDidLoad {
    NSLog(@"2");
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    self.arrayCategories = @[@"Breakfast", @"Snack", @"Lunch", @"Dinner", @"Supper"];
    [self.pickerViewCategory selectRow:2 inComponent:0 animated:YES];
    self.stepperPortions.value = 1.00;
    self.stepperPortions.minimumValue = 1.00;
    self.stepperPortions.maximumValue = 16.00;
    //[self imagePath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.arrayCategories.count;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.arrayCategories objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.categorySelected = [self.arrayCategories objectAtIndex:row];
}

- (IBAction)stepperChanged:(UIStepper *)stepper {
    self.labelNrOfPortions.text = [NSString stringWithFormat:@"%d",(int)stepper.value];
}


- (IBAction)saveRecipe:(id)sender {
    //TODO: make sure form isn't empty...
    
    //1. Already saved latest PicPath...
    
    //2. Add recipe name...
    [self.parManager addName2CurrentRecipe:self.textFieldName.text];
    
    //3. Add recipe category...
    [self.parManager addCategory2CurrentRecipe:self.categorySelected];
    
    //4. Add recipe portions...
    [self.parManager addPortions2CurrentRecipe:[NSNumber numberWithInt:[self.labelNrOfPortions.text intValue]]];
    
    //5. Add recipe howTo...
    [self.parManager addHowTo2CurrentRecipe:self.textViewDescription.text];
    
    //6. Add recipe array of products and corresponding units...
    NSLog(@"vill ha namn: %@ och gram %d",self.tableViewAddRecipe, 10);
    
    //7. Convert recipe dictionary to actual recipe and save it in PAR...
    
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSLog(@"den hittade kameran");
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        NSLog(@"den hittade inte kameran med sparade bilder");
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSString *imagePath = [self imagePath];
    
    BOOL success = [imageData writeToFile:imagePath atomically:YES];
    
    if(success) {
        NSLog(@"Saved image to user documents directory. with path: %@", imagePath);
        [self.parManager addPicPath2CurrentRecipe:imagePath];
    } else {
        NSLog(@"Couldn't save image to user documents directory");
    }
}

- (NSString *)imagePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *cachedDatePNG = [NSString stringWithFormat:@"cachedImage%@.png",[formatter stringFromDate:[NSDate date]]];
    return [path stringByAppendingPathComponent:cachedDatePNG];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"3");
    return self.parManager.arrayOfIngredients.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddRecipeCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOfAddRecipe"];
    cell.labelName.text = [[self.parManager.arrayOfIngredients[indexPath.row] valueForKey:@"product"] valueForKey:@"name"];
//    cell.labelGrams.text = [NSString stringWithFormat:@"grams: %d", (int)cell.sliderGrams.value];
    cell.labelGrams.text = [[self.parManager.arrayOfIngredients[indexPath.row] valueForKey:@"grams"] stringValue];
NSLog(@"4");
    return cell;
}

@end
