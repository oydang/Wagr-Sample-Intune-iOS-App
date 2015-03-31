//
//  ViewController.m
//  ECHackDemoApp
//
//  Created by Pete Biencourt on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import "ViewController.h"
#import "Settings.h"

@interface ViewController ()

@end
@implementation ViewController

@synthesize calendarData;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    timerRunning = NO;
    pauseTimeInterval = 0;
    calendarData = [[CalendarData alloc] init];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    
    self.monthLabel.text = [[formatter stringFromDate:now] uppercaseString];
    
    [formatter setDateFormat:@"d"];
    self.dayLabel.text = [formatter stringFromDate:now];
    
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
        if (hourlyWage == 0) {
            hourlyWage = 725;
        }
        else{
            hourlyWage = [Settings hourlyWage];            
        }

        
        timerRunning = YES;
        
        self.startDate = [NSDate date] ;
        self.startDate = [self.startDate dateByAddingTimeInterval:((-1)*(pauseTimeInterval))];
        self.timeWorkedTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
    }
    else{
        [UIView performWithoutAnimation:^{
            [self.clockButton setTitle:@"Clock In" forState:UIControlStateNormal];
        }];
        
        
        timerRunning = NO;
        [self.calendarData recordCalendarData:self.startDate wage:hourlyWage timeWorked:self.timeWorkedLabel.text];
        [self.calendarData saveCalendarData];
        [self.timeWorkedTimer invalidate];
        self.timeWorkedTimer = nil;
        
        [self updateUI];
        self.timeWorkedLabel.text = [self.timeWorkedLabel.text stringByReplacingOccurrencesOfString:@" "
                                                                                         withString:@":"];
    }
    

}

- (void) updateUI {
    [self updateTimer];
    [self updateMoneyEarned];
}


-(void) updateTimer {
    
    NSDate *currentDate = [NSDate date];
    
    elapsedTime = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
    
    //Format the date to show Hours and Minutes
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    //Turn the timestamp from the timer into a string
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.timeWorkedLabel.text = timeString;
    pauseTimeInterval = elapsedTime;
    
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
