//
//  SettingsViewController.h
//  Wagr
//
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController{
    int hourlyWage;
    int dollarsInCents;
    int cents;
}
- (IBAction)onLinkPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *dollarWage;
@property (weak, nonatomic) IBOutlet UITextField *centsWage;


@end
