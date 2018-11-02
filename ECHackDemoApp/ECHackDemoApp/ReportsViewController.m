//
//  ReportsViewController.m
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

@import Contacts;

#import "ReportsViewController.h"
#import "CalendarData.h"
#import "DateUtility.h"
#import "Settings.h"

static NSString *signInString = @"Sign In";
static NSString *signOutString = @"Sign Out";

@interface ReportsViewController ()

@property(nonatomic, strong) CalendarData *calendarData;
@property(nonatomic, strong) UIDocumentInteractionController *controller;
@property BOOL isUserSignedIn;

@end

@implementation ReportsViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.exportWagesButton.layer.borderWidth = 1.0f;
    self.exportWagesButton.layer.borderColor = [[UIColor blueColor] CGColor];
    self.exportWagesButton.layer.cornerRadius = 12;

    self.exportWorkerDataButton.layer.borderWidth = 1.0f;
    self.exportWorkerDataButton.layer.borderColor = [[UIColor blueColor] CGColor];
    self.exportWorkerDataButton.layer.cornerRadius = 12;

    // Initialize the calendar data
    self.calendarData = [[CalendarData alloc] init];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[IntuneMAMEnrollmentManager instance] setDelegate:self];
    [[IntuneMAMPolicyManager instance] setDelegate:self];

    if ([[IntuneMAMEnrollmentManager instance] enrolledAccount]) {
        _isUserSignedIn = YES;
        [Settings setWorkerEmail:[[IntuneMAMEnrollmentManager instance] enrolledAccount]];
    }

    [self.signInButton setTitle:(self.isUserSignedIn ? signOutString : signInString) forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark Plot Data Source Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

- (IBAction)onExportWagesButtonPressed:(UIButton *)sender {
    self.controller = [self.calendarData getDocumentInteractionController];
    [self.controller setDelegate:self];
    [self.controller presentOpenInMenuFromRect:self.exportWagesButton.frame
                                        inView:self.view
                                      animated:YES];

}

- (IBAction)onSignInButtonPressed:(id)sender {
    if (!self.isUserSignedIn) {
        [[IntuneMAMEnrollmentManager instance] loginAndEnrollAccount:nil];
    } else {
        [[IntuneMAMEnrollmentManager instance] deRegisterAndUnenrollAccount:[[IntuneMAMEnrollmentManager instance] enrolledAccount] withWipe:YES];
    }
}

- (IBAction)onExportWorkerDataButtonPressed:(id)sender {
    // Get access to iOS Contacts
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];

    if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Access to contacts."
                                                                       message:@"This app requires access to Contacts to export worker contact information."
                                                                preferredStyle:UIAlertControllerStyleActionSheet];

        [alert addAction:[UIAlertAction actionWithTitle:@"Go to Settings"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *_Nonnull action) {
                                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                                                }]];

        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:TRUE completion:nil];
        return;
    }

    CNContactStore *store = [[CNContactStore alloc] init];

    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError *_Nullable error) {
        if (!granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // user didn't grant access;
                // so, again, tell user here why app needs permissions in order  to do it's job;
                // this is dispatched to the main queue because this request could be running on background thread
            });
            return;
        }

        // Create contact
        CNMutableContact *contact = [CNMutableContact new];
        NSArray *nameArray = [[Settings workerName] componentsSeparatedByString:@" "];
        contact.givenName = [nameArray objectAtIndex:0];
        if ([nameArray count] > 1) {
            contact.familyName = [nameArray objectAtIndex:1];
        }
        contact.emailAddresses = @[[CNLabeledValue labeledValueWithLabel:CNLabelWork value:[Settings workerEmail]]];
        contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelWork value:[CNPhoneNumber phoneNumberWithStringValue:[Settings workerPhone]]]];

        CNSaveRequest *request = [[CNSaveRequest alloc] init];
        [request addContact:contact toContainerWithIdentifier:nil];

        // save it
        NSError *saveError;
        if ([store executeSaveRequest:request error:&saveError]) {
            NSString *title;
            NSString *message;

            if ([[[IntuneMAMPolicyManager instance] policy] isContactSyncAllowed]) {
                title = @"Success!";
                message = @"Contact was saved successfully. Check your native Contacts app.";
            } else {
                title = @"Failed to save contact";
                message = @"Saving to your Contacts is not allowed by your IT administrator.";
            }

            UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction *action) {
                                                                  }];
            [successAlert addAction:defaultAction];
            [self presentViewController:successAlert animated:YES completion:nil];
        } else {
            NSLog(@"error = %@", saveError);
        }

    }];
}

#pragma mark - IntuneMAMEnrollmentDelegate Methods

/**
 *  Called when an enrollment request operation is completed.
 *
 *  @param status status object containing status
 */
- (void)enrollmentRequestWithStatus:(IntuneMAMEnrollmentStatus *_Nonnull)status {
    if (status.didSucceed) {
        _isUserSignedIn = YES;
        [Settings setWorkerEmail:[[IntuneMAMEnrollmentManager instance] enrolledAccount]];
    }
    [self.signInButton setTitle:(self.isUserSignedIn ? signOutString : signInString) forState:UIControlStateNormal];
}

/**
 *  Called when a un-enroll request operation is completed.
 *
 *  @Note: when a user is un-enrolled, the user is also de-registered with the SDK
 *
 *  @param status status object containing status
 */
- (void)unenrollRequestWithStatus:(IntuneMAMEnrollmentStatus *_Nonnull)status {
    if (status.didSucceed) {
        _isUserSignedIn = NO;
    }
    [self.signInButton setTitle:(self.isUserSignedIn ? signOutString : signInString) forState:UIControlStateNormal];
}

#pragma mark - IntuneMAMPolicyDelegate Methods

- (BOOL)restartApplication {
    return NO;
}


@end
