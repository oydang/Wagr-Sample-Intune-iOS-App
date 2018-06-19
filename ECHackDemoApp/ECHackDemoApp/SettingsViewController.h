//
//  SettingsViewController.h
//  Wagr
//
//  Copyright (c) Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
{
    unsigned int hourlyWage;
    unsigned int dollarsInCents;
    unsigned int cents;
}
- (IBAction)onLinkPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *dollarWage;
@property (weak, nonatomic) IBOutlet UITextField *centsWage;


@end
