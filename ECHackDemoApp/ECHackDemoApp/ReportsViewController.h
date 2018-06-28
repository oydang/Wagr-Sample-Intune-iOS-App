//
//  ReportsViewController.h
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IntuneMAM/IntuneMAMPolicyManager.h>
#import <IntuneMAM/IntuneMAMEnrollmentManager.h>

@interface ReportsViewController : UIViewController<UIDocumentInteractionControllerDelegate, IntuneMAMPolicyDelegate, IntuneMAMEnrollmentDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *exportWagesButton;
@property (weak, nonatomic) IBOutlet UIButton *exportWorkerDataButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

- (IBAction)onExportWagesButtonPressed:(UIButton *)sender;
- (IBAction)onExportWorkerDataButtonPressed:(id)sender;
- (IBAction)onSignInButtonPressed:(id)sender;

@end
