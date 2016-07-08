//
//  ViewController.m
//  TipCalculator
//
//  Created by Viviane Chan on 2016-07-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBillAmountField];
    [self customizeKeyboard];
    [self setTipAmount];
    [self addKeyboardObserver];
    [self outputSlider:self.slider];
}



#pragma set up text fields

-(void) setupBillAmountField{
    self.billAmountTextField.placeholder = @"Type bill amount";
    self.billAmountTextField.textColor = [UIColor blueColor];
    self.billAmountTextField.textAlignment = NSTextAlignmentCenter;
    self.billAmountTextField.delegate = self;
    [self customizeKeyboard];
}

-(void) setTipAmount {
    [self.slider addTarget:self action:@selector(outputSlider:) forControlEvents:UIControlEventValueChanged];
    self.slider.minimumValue = 2.0;
    self.slider.maximumValue = 30.0;
    self.slider.continuous = YES;
    self.slider.value = 15.0;
}


- (void)outputSlider:(UISlider *)sender {

    self.tipPercentageLabel.text = [NSString stringWithFormat:@"%.1f%%", self.slider.value];
}

- (IBAction)calculateTip:(id)sender {
  self.finalTipLabel.text = [NSString stringWithFormat:@"$%.1f",self.billAmountTextField.text.floatValue * self.tipPercentageLabel.text.floatValue/100 ];
}

-(void) customizeKeyboard{
    self.billAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
}

#pragma mark - Handle Keyboard

-(void) addKeyboardObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSLog(@"%@",notification.userInfo);
    CGFloat kbHeight = [self heightForNotification:notification];
    [self adjustViewForKeyboardHeight:kbHeight];
}

- (CGFloat)heightForNotification:(NSNotification *)notification {
    NSValue *keyboardInfo = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [keyboardInfo CGRectValue];
    return rect.size.height;
}

- (void)adjustViewForKeyboardHeight:(CGFloat)height {
    CGRect viewBounds = self.view.bounds;
    viewBounds.origin.y += height;
    NSLog(@"%@", NSStringFromCGRect(viewBounds));
    self.view.bounds = viewBounds;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSLog(@"%@", notification.userInfo);
    CGFloat kbHeight = [self heightForNotification:notification];
    [self adjustViewForKeyboardHeight:-kbHeight];
}

#pragma mark - Handle Gestures

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.billAmountTextField isFirstResponder]) {
        [self.billAmountTextField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)billAmountTextField {
    [billAmountTextField resignFirstResponder];
    return YES;
}


#pragma action calls


#pragma mark - Clean Up

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





@end
