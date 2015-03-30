//
//  ViewController.h
//  ECHackDemoApp
//
//  Created by Pete Biencourt on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSTimeInterval pauseTimeInterval;
    BOOL timerRunning;
}

@property (weak, nonatomic) IBOutlet UIButton *onClockButtonPressed;
@property (weak, nonatomic) IBOutlet UIButton *clockButton;

@property (weak, nonatomic) IBOutlet UILabel *currentMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyMadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeWorkedLabel;

@property (strong, nonatomic) NSTimer *timeWorkedTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button


@end

