//
//  ReportsViewController.m
//  Wagr
//
//  Copyright (c) Microsoft. All rights reserved.
//

#import "ReportsViewController.h"
#import "CalendarData.h"
#import "DateUtility.h"

@interface ReportsViewController()

@property (nonatomic, strong) CalendarData *calendarData;
@property (nonatomic, strong) UIDocumentInteractionController* controller;

@end

@implementation ReportsViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Initialize the calendar data
    self.calendarData = [[CalendarData alloc] init];
    
    }

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Plot Data Source Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (IBAction)onExportButtonPressed:(UIButton *)sender
{
    self.controller =[self.calendarData getDocumentInteractionController];
    [self.controller setDelegate: self];
    [self.controller presentOpenInMenuFromRect:self.exportButton.frame
                        inView:self.view
                      animated:YES];
   
}

@end
