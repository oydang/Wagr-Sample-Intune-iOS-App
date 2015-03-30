//
//  ViewController.m
//  ECHackDemoApp
//
//  Created by Pete Biencourt on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClockButtonPressed:(UIButton *)sender {
    if ([self.clockButton.currentTitle isEqualToString:@"Clock In"]){
        [self.clockButton setTitle:@"Clock Out" forState:UIControlStateNormal];
    }
    else{
        [self.clockButton setTitle:@"Clock In" forState:UIControlStateNormal];
    }
}
@end
