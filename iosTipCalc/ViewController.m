//
//  ViewController.m
//  iosTipCalc
//
//  Created by Carter Chang on 6/12/15.
//  Copyright (c) 2015 Carter Chang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)onTap:(id)sender;
- (void) updateValues;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateValues];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipSegmentIndex = [defaults integerForKey:@"default_tip_index"];
    [self.tipControl setSelectedSegmentIndex:defaultTipSegmentIndex];
    [self updateValues];
    
    [self.billTextFiled becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (IBAction)onTap:(id)sender {
    // [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues {
    float billAmount = [self.billTextFiled.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2), @(0.25), @(0.3)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fade.fromValue = [NSNumber numberWithFloat:0.0f];
    fade.toValue = [NSNumber numberWithFloat:1.0f];
    fade.duration = 2.0f;
    [self.totalLabel.layer addAnimation:fade forKey:@"fade"];
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount ];
    self.totalLabel.text = [NSString stringWithFormat: @"$%0.2f", totalAmount ];
}
@end
