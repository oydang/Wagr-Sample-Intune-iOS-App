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
    [self loadCalendarData];
    
    hourlyWage = 5000;
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
        self.timeWorkedTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
    }
    else{
        [UIView performWithoutAnimation:^{
            [self.clockButton setTitle:@"Clock In" forState:UIControlStateNormal];
        }];
        
        timerRunning = NO;
        [self.timeWorkedTimer invalidate];
        self.timeWorkedTimer = nil;
        [self updateTimer];
    }
    

    //when stop button pressed
    //[self recordCalendarData:date hours:hours wage: wage]
    //[self saveCalendarData
}

- (void) loadCalendarData{
    //Find calendar data in plist file and load to calendar dictionary.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [directoryPaths objectAtIndex:0];
    NSString *userDataPath = [documentsPath stringByAppendingPathComponent:@"UserData.plist"];
    
    //look for plist in documents, if not there, retrieve from mainBundle
    if (![fileManager fileExistsAtPath:userDataPath]){
        userDataPath = [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"];
    }
    
    NSDictionary *userData = [NSDictionary dictionaryWithContentsOfFile:userDataPath];
    self.calendarData = [userData objectForKey:@"calendar"];
}

- (void) recordCalendarData: (NSString *)date hours:(double)hours wage:(double)wage {
    //When stop button is pressed, record new data to plist
    //date is NSString in format yyyymmdd
    //hours and wage are NSNumbers representing hours worked, and wage per hour
    //NOTE: 1 wage per day. Currently new wage will not override.
    
    //get existing data for today's date
    NSArray *existingData;
    existingData=[self.calendarData objectForKey:date];
    if (existingData != nil){
        hours = hours+[existingData[0] doubleValue];
        wage = wage+[existingData[1] doubleValue];
    }
    //create new array with today's data
    existingData = [NSArray arrayWithObjects: [NSNumber numberWithDouble:hours], [NSNumber numberWithDouble:wage], nil];
    
    //add array back to calendar
    [self.calendarData setObject:existingData forKey:date];
}

-(void) updateUI {
    [self updateTimer];
    [self updateMoneyEarned];
}

-(void) updateTimer {
    
    NSDate *currentDate = [NSDate date];
    
    elapsedTime = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.timeWorkedLabel.text = timeString;
    pauseTimeInterval = elapsedTime;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"ss"];
    
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

- (void) saveCalendarData {
    //Save calendar back to plist in documents
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [directoryPaths objectAtIndex:0];
    NSString *userDataPath = [documentsPath stringByAppendingPathComponent:@"UserData.plist"];
    NSDictionary *userData = [NSDictionary dictionaryWithObject:self.calendarData forKey: @"calendar"];
    [userData writeToFile:userDataPath atomically:YES];
    

}

@end
