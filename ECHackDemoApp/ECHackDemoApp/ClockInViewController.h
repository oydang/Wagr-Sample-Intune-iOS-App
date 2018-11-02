//
//  ClockInViewController.h
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarData.h"
#import <IntuneMAMWalledGarden/IntuneMAM.h>

@interface ClockInViewController : UIViewController {
    NSTimeInterval pauseTimeInterval;
    NSTimeInterval elapsedTime;
    BOOL timerRunning;
    unsigned int moneyEarned;
    unsigned int hourlyWage;
}

@property CalendarData *calendarData; //NSMutableDictionary *calendarData;

@property(weak, nonatomic) IBOutlet UIButton *onClockButtonPressed;
@property(weak, nonatomic) IBOutlet UIButton *clockButton;

@property(weak, nonatomic) IBOutlet UILabel *currentMonthLabel;
@property(weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property(weak, nonatomic) IBOutlet UILabel *moneyMadeDollarsLabel;
@property(weak, nonatomic) IBOutlet UILabel *moneyMadeCentsLabel;
@property(weak, nonatomic) IBOutlet UILabel *timeWorkedLabel;
@property(weak, nonatomic) IBOutlet UILabel *monthLabel;
@property(weak, nonatomic) IBOutlet UILabel *dayLabel;
@property(weak, nonatomic) IBOutlet UILabel *timeWorkedSecondsLabel;

@property(strong, nonatomic) NSTimer *timeWorkedTimer; // Store the timer that fires after a certain time
@property(strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button


@end
