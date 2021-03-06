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
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;
@property (nonatomic) NSArray *arrayCategories;
@property (nonatomic) NSString *categorySelected;
@property (nonatomic) PARMananger *parManager;
@property (nonatomic) NSMutableDictionary *dictionaryPrep4RecipInit;
@property (nonatomic) BOOL haveTakenPic;
@property (weak, nonatomic) IBOutlet UIButton *buttonTakePicture;

@end

@implementation RecipesAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parManager = [PARMananger getPARManager];
    self.arrayCategories = @[@"Breakfast", @"Snack", @"Lunch", @"Dinner", @"Supper"];
    [self.pickerViewCategory selectRow:2 inComponent:0 animated:YES];
    self.stepperPortions.value = 1.00;
    self.stepperPortions.minimumValue = 1.00;
    self.stepperPortions.maximumValue = 16.00;
    self.haveTakenPic = NO;
    self.textFieldName.delegate = self;
    self.textViewDescription.delegate = self;
    if (!self.parManager.recipeForEditing) {
        self.parManager.recipeForEditing = [[Recipe alloc] init];
    }
    if (self.parManager.editingRecipe) {
        
        self.textFieldName.text = self.parManager.recipeForEditing.name;
        
        int pickerIndex;
        if ([self.parManager.recipeForEditing.category isEqualToString:@"Breakfast"]) {
            self.categorySelected = @"Breakfast";
            pickerIndex = 0;
        } else if ([self.parManager.recipeForEditing.category isEqualToString:@"Snack"]) {
            self.categorySelected = @"Snack";
            pickerIndex = 1;
        } else if ([self.parManager.recipeForEditing.category isEqualToString:@"Lunch"]) {
            self.categorySelected = @"Lunch";
            pickerIndex = 2;
        } else if ([self.parManager.recipeForEditing.category isEqualToString:@"Dinner"]) {
            self.categorySelected = @"Dinner";
            pickerIndex = 3;
        } else if ([self.parManager.recipeForEditing.category isEqualToString:@"Supper"]) {
            self.categorySelected = @"Supper";
            pickerIndex = 4;
        }
        [self.pickerViewCategory selectRow:pickerIndex inComponent:0 animated:YES];
        
        self.labelNrOfPortions.text = [self.parManager.recipeForEditing.portions stringValue];
        self.stepperPortions.value = [self.parManager.recipeForEditing.portions doubleValue];
        
        self.textViewDescription.text = self.parManager.recipeForEditing.howTo;
        
        [self changePicOfButton];
    }
    [[[[self.tabBarController tabBar] items] objectAtIndex:0] setEnabled:NO];
    [[[[self.tabBarController tabBar] items] objectAtIndex:1] setEnabled:NO];
    [[[[self.tabBarController tabBar] items] objectAtIndex:2] setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    if (!self.haveTakenPic){
        if (self.parManager.editingRecipe && self.parManager.recipeForEditing.picPath != nil) {
            [self.parManager addPicPath2CurrentRecipe:self.parManager.recipeForEditing.picPath];
            self.haveTakenPic = YES;
        }
    }
    
    //Recipe must have Name, Pic and ingreedients...
    if ([self.textFieldName.text isEqualToString:@""] || !self.haveTakenPic || self.parManager.arrayOfIngredients.count == 0) {
        
        NSString *errorMessage = @"Please fix the following errors:";
        
        if ([self.textFieldName.text isEqualToString:@""]) {
            errorMessage = [errorMessage stringByAppendingString:@" Enter name."];
        }
        if (!self.haveTakenPic){
            errorMessage = [errorMessage stringByAppendingString:@" Take picture."];
        }
        if (self.parManager.arrayOfIngredients.count == 0) {
            errorMessage = [errorMessage stringByAppendingString:@" Add ingredients."];
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];

    } else {
        [self theActualSaving];
    }
    
}

- (void)theActualSaving {
    //1. Already saved latest PicPath...
    
    //2. Add recipe name...
    [self.parManager addName2CurrentRecipe:self.textFieldName.text];
    
    //3. Add recipe category...
    if (self.categorySelected == nil) {
        [self.parManager addCategory2CurrentRecipe:@"Lunch"];
    } else {
        [self.parManager addCategory2CurrentRecipe:self.categorySelected];
    }
    
    //4. Add recipe portions...
    [self.parManager addPortions2CurrentRecipe:[NSNumber numberWithInt:[self.labelNrOfPortions.text intValue]]];
    
    //5. Add recipe howTo...
    [self.parManager addHowTo2CurrentRecipe:self.textViewDescription.text];
    
    //7. Convert recipe dictionary to actual recipe and save it in PAR...
    [self.parManager convertDictionaryCurrentRecipe2RecipeAndAdd2PARManager];
    
    [self performSegueWithIdentifier:@"exitAddRecipe" sender:self];
}
- (IBAction)exitAddRecipe:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Exit" message:@"The recipe has not been saved..." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *exit = [UIAlertAction actionWithTitle:@"Exit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self performSegueWithIdentifier:@"exitAddRecipe" sender:self];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:exit];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)takePicture:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
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
        self.haveTakenPic = YES;
        [self changePicOfButton];
    }
}

- (void)changePicOfButton {
    UIImage *cachedImage = [UIImage imageWithContentsOfFile:[self.parManager.recipeForEditing getTheRightFolderAndImagePath]];
    if (cachedImage) {
        [self.buttonTakePicture setImage:cachedImage forState:UIControlStateNormal];
        self.buttonTakePicture.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}

- (NSString *)imagePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *cachedDatePNG = [NSString stringWithFormat:@"cachedImage%@.png",[formatter stringFromDate:[NSDate date]]];
    [self.parManager addPicPath2CurrentRecipe:cachedDatePNG];
    self.parManager.recipeForEditing.picPath = cachedDatePNG;
    return [path stringByAppendingPathComponent:cachedDatePNG];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.parManager.arrayOfIngredients.count < 1) {
        return 1;
    } else {
        return self.parManager.arrayOfIngredients.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOfAddRecipe"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellOfAddRecipe"];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTheCell:)];
    UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressedTheCell:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    pressRecognizer.minimumPressDuration = 0.5;
    cell.tag = indexPath.row;
    [cell addGestureRecognizer:tapRecognizer];
    [cell addGestureRecognizer:pressRecognizer];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:8];
    
    if (self.parManager.arrayOfIngredients.count < 1) {
        cell.textLabel.text = @"No product added to recipe.";
    } else {
        cell.textLabel.text = [[self.parManager.arrayOfIngredients[indexPath.row] valueForKey:@"product"] valueForKey:@"name"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Recipe contains %@ grams of this product.",[[self.parManager.arrayOfIngredients[indexPath.row] valueForKey:@"grams"] stringValue]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.753 green:0.925 blue:0.98 alpha:1.0];
    }
}

-(void)tappedTheCell:(UILongPressGestureRecognizer *)sender {
    if (self.parManager.arrayOfIngredients.count > 0) {
        //If a clickable action is added, put it here...
        NSLog(@"Klickade");
    } else {
        NSLog(@"Klickade");
        [self performSegueWithIdentifier:@"toArrayOfIngredientsAdder" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toArrayOfIngredientsAdder"]) {
        self.parManager.recipeForEditing.name = self.textFieldName.text;
        self.parManager.recipeForEditing.category = self.categorySelected;
        self.parManager.recipeForEditing.portions = [NSNumber numberWithInt:[self.labelNrOfPortions.text intValue]];
        self.parManager.recipeForEditing.howTo = self.textViewDescription.text;
    }
}

-(void)pressedTheCell:(UITapGestureRecognizer*)sender {
    if (self.parManager.arrayOfIngredients.count > 0) {
        if (sender.state == UIGestureRecognizerStateBegan){
            [self displayAlertSendingIndexPathRow:sender.view.tag];
        }
    } else {
        if (sender.state == UIGestureRecognizerStateBegan){
            NSLog(@"Pressade");
        }
    }
}

//Wanted to do this method DRY but didn't have the time...
-(void)displayAlertSendingIndexPathRow:(NSInteger)indexpathRow {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Measure" message:@"Select your measure" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.parManager.arrayOfIngredients removeObjectAtIndex:indexpathRow];
        [self.tableViewAddRecipe reloadData];
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:delete];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textFieldName resignFirstResponder];
    [self.textViewDescription resignFirstResponder];
}
@end
