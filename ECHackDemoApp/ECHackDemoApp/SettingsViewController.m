//
//  SettingsViewController.m
//  Wagr
//
//  Copyright (c) Microsoft. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"
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

- (IBAction)onDollarsWageEntered:(UITextField *)sender
{
    dollarsInCents = [self.dollarWage.text intValue] * 100;
    hourlyWage = dollarsInCents + cents;
    [Settings setHourlyWage:hourlyWage];
    NSLog(@"Hourly Wage: %d", hourlyWage);
}

- (IBAction)onCentsWageEntered:(UITextField *)sender
{
    cents = [self.centsWage.text intValue];
    hourlyWage = dollarsInCents + cents;
    [Settings setHourlyWage:hourlyWage];
    NSLog(@"Hourly Wage: %d", hourlyWage);
}

-(void)dismissKeyboard
{
    [self.userName resignFirstResponder];
    [self.dollarWage resignFirstResponder];
    [self.centsWage resignFirstResponder];
}
@end
