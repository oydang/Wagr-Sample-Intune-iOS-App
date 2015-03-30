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

@synthesize calendarData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    timerRunning = NO;
    pauseTimeInterval = 0;
    //In cents
    hourlyWage = 5000;

    calendarData = [[CalendarData alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onClockButtonPressed:(UIButton *)sender {
    if (!timerRunning){
        [UIView performWithoutAnimation:^{
            [self.clockButton setTitle:@"Clock Out" forState:UIControlStateNormal];
        }];
        
        timerRunning = YES;
        
        self.startDate = [NSDate date] ;
        self.startDate = [self.startDate dateByAddingTimeInterval:((-1)*(pauseTimeInterval))];
        self.timeWorkedTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    else{
        [UIView performWithoutAnimation:^{
            [self.clockButton setTitle:@"Clock In" forState:UIControlStateNormal];
        }];
        
        
        timerRunning = NO;
        //hardcoding wage for now.
        double wage = 15;
        [self.calendarData recordCalendarData:self.startDate wage:wage timeWorked:self.timeWorkedLabel.text];
        [self.calendarData saveCalendarData];
        [self.timeWorkedTimer invalidate];
        self.timeWorkedTimer = nil;
        
        [self updateTimer];
        self.timeWorkedLabel.text = [self.timeWorkedLabel.text stringByReplacingOccurrencesOfString:@" "
                                                                                         withString:@":"];
    }
    

}


-(void) updateTimer {
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    //Format the date to show Hours and Minutes
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    //Turn the timestamp from the timer into a string
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.timeWorkedLabel.text = timeString;
    pauseTimeInterval = timeInterval;
    
    //Grab the seconds from the timer
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"ss"];
    
    //If the time is odd, remove the : from the time, creating a blinking : effect
    if ([[df stringFromDate:timerDate] integerValue] % 2) {
        self.timeWorkedLabel.text = [self.timeWorkedLabel.text stringByReplacingOccurrencesOfString:@":"
                                                                                         withString:@" "];
    }
}


-(void) updateMoneyEarned {
    double wagePerSecond = hourlyWage / 3600.0;
    
    moneyEarned = wagePerSecond * elapsedTime;
    
    self.moneyMadeCentsLabel.text = [NSString stringWithFormat:@"%02d", (moneyEarned % 100)];
    self.moneyMadeDollarsLabel.text = [NSString stringWithFormat:@"%d", (moneyEarned / 100)];
}


@end
