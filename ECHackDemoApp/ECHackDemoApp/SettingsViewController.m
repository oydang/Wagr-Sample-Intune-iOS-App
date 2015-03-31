//
//  SettingsViewController.m
//  ECHackDemoApp
//
//  Created by Mac MDM on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"
#import "Settings.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onLinkPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://technet.microsoft.com/library/dn878028.aspx"]];
}
- (IBAction)onDollarsWageEntered:(UITextField *)sender {
    dollarsInCents = [self.dollarWage.text intValue] * 100;
    if ((cents >= 0)&& (dollarsInCents >= 0)) {
        hourlyWage = dollarsInCents + cents;
        [Settings setHourlyWage:hourlyWage];
    }
    NSLog(@"Hourly Wage: %d", hourlyWage);
}

- (IBAction)onCentsWageEntered:(UITextField *)sender {
    cents = [self.centsWage.text intValue];
    if ((cents >= 0)&& (dollarsInCents >= 0)) {
        hourlyWage = dollarsInCents + cents;
        [Settings setHourlyWage:hourlyWage];
    }
    NSLog(@"Hourly Wage: %d", hourlyWage);
}
@end
