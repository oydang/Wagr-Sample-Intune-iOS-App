//
//  SettingsViewController.m
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import "SettingsViewController.h"
#import "ClockInViewController.h"
#import "Settings.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLinkPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://docs.microsoft.com/intune/app-wrapper-prepare-ios"]];
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
@end
