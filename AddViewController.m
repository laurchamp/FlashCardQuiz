//
//  AddViewController.m
//  Lab5
//
//  Created by Lauren Champeau on 3/30/17.
//  Copyright © 2017 Lauren Champeau. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.questionTextView becomeFirstResponder];
}

// Make save button only enable sometimes
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // Get the text in the textField including any deletions
    NSString *testString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    testString = [testString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // Call enable/disable function with the textField contents string as input
    [self enableOrDisableSaveButton:testString];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    // This function is called if anything changed in the textView, still need textField content
    // Get textField text contents and call enable/disable function with this string
    NSString *answerTextFieldText = self.answerTextField.text;
    [self enableOrDisableSaveButton:answerTextFieldText];
}

- (void)enableOrDisableSaveButton:(NSString *)textFieldString {
    // enable/disable function now takes in textField contents as input to account for deletions/etc happening within it, then check lengths
    if (textFieldString.length == 0 || self.questionTextView.text.length == 0)
    {
        self.saveButton.enabled = NO;
    }
    else{
        self.saveButton.enabled = YES;
    }
}

// Save button implementation
- (IBAction)saveButtonDidPressed:(UIBarButtonItem *)sender {
    NSString *newQuestion = self.questionTextView.text;
    NSString *newAnswer = self.answerTextField.text;
    self.completionHandler(newQuestion, newAnswer);
}

// Cancel button implementation
- (IBAction)cancelButtonDidPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// Keyboard dismissal
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.answerTextField isFirstResponder] && [touch view] != self.answerTextField){
        [self.answerTextField resignFirstResponder];
    }
    
    if ([self.questionTextView isFirstResponder] && [touch view] != self.answerTextField){
        [self.questionTextView resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
