//
//  SettingsViewController.h
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

- (IBAction)onLinkPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dollarWageTextField;
@property (weak, nonatomic) IBOutlet UITextField *centsWageTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;



@end
