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
    timerRunning = NO;
    pauseTimeInterval = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClockButtonPressed:(UIButton *)sender {
    if (!timerRunning){
        [self.clockButton setTitle:@"Clock Out" forState:UIControlStateNormal];
        
        timerRunning = YES;
        
        self.startDate = [NSDate date] ;
        self.startDate = [self.startDate dateByAddingTimeInterval:((-1)*(pauseTimeInterval))];
        self.timeWorkedTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    else{
        [self.clockButton setTitle:@"Clock In" forState:UIControlStateNormal];
        
        timerRunning = NO;
        [self.timeWorkedTimer invalidate];
        self.timeWorkedTimer = nil;
        [self updateTimer];
    }
}

-(void) updateTimer {
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.timeWorkedLabel.text = timeString;
    pauseTimeInterval = timeInterval;
    
}
@end
