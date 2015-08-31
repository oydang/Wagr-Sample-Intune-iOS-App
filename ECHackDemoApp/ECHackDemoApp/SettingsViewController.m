//
//  SettingsViewController.m
//  Wagr
//
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
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

-(void)dismissKeyboard {
    [self.userName resignFirstResponder];
    [self.dollarWage resignFirstResponder];
    [self.centsWage resignFirstResponder];
}
@end
