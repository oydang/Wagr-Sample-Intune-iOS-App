//
//  SettingsViewController.m
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import "SettingsViewController.h"
#import "ClockInViewController.h"
#import "Settings.h"
#import <IntuneMAM/IntuneMAMEnrollmentManager.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    self.emailTextField.delegate = self;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
}
         
- (void)viewDidAppear:(BOOL)animated
{
    if([[IntuneMAMEnrollmentManager instance] enrolledAccount])
    {
        [Settings setWorkerEmail:[[IntuneMAMEnrollmentManager instance] enrolledAccount]];
        [self.emailTextField setText:[Settings workerEmail]]; // The only setting that could have changed
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onNameEntered:(UITextField *)sender
{
    [Settings setWorkerName:self.nameTextField.text];
}


- (IBAction)onDollarsWageEntered:(UITextField *)sender
{
    unsigned int dollarsInCents = [self.dollarWageTextField.text intValue] * 100;
    unsigned int hourlyWage = dollarsInCents + [self.centsWageTextField.text intValue];
    [Settings setHourlyWage:hourlyWage];
    NSLog(@"Hourly Wage: %d", hourlyWage);
}

- (IBAction)onCentsWageEntered:(UITextField *)sender
{
    unsigned int cents = [self.centsWageTextField.text intValue];
    unsigned int hourlyWage = ([self.dollarWageTextField.text intValue] * 100) + cents;
    [Settings setHourlyWage:hourlyWage];
    NSLog(@"Hourly Wage: %d", hourlyWage);
}

- (IBAction)onEmailEntered:(UITextField *)sender
{
    [Settings setWorkerEmail:self.emailTextField.text];
}

- (IBAction)onPhoneEntered:(UITextField *)sender
{
    [Settings setWorkerPhone:self.phoneTextField.text];
}

-(void)dismissKeyboard
{
    [self.nameTextField resignFirstResponder];
    [self.dollarWageTextField resignFirstResponder];
    [self.centsWageTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return [[IntuneMAMEnrollmentManager instance] enrolledAccount]?NO:YES;
}

@end
