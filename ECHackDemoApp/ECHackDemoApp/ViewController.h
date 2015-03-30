//
//  ViewController.h
//  ECHackDemoApp
//
//  Created by Pete Biencourt on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property NSMutableDictionary *calendarData;

@property (weak, nonatomic) IBOutlet UIButton *onClockButtonPressed;

@property (weak, nonatomic) IBOutlet UILabel *timeWorkedLabel;

@end

