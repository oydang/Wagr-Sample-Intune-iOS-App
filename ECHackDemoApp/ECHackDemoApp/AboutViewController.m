//
//  AboutViewController.m
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onAboutLinkPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://docs.microsoft.com/en-us/intune/app-sdk"]];
}


@end
