//
//  CalendarData.m
//  Wagr
//
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import "CalendarData.h"
@import UIKit;
#import "DateUtility.h"

@implementation CalendarData{
    
}

@synthesize calendarDictionary;

- (id) init{
    [self loadCalendarData];
    return self;
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
    
    NSData *userData = [fileManager contentsAtPath:userDataPath];
    NSError *error;
    NSPropertyListFormat format;
    NSMutableDictionary *userDataDictionary = (NSMutableDictionary *)[NSPropertyListSerialization propertyListWithData:userData options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
    
    
    self.calendarDictionary = [userDataDictionary objectForKey:@"calendar"];
    
}

- (void) recordCalendarData: (NSDate*)date wage:(double)wage timeWorked: (NSString*)timeWorked {
    //When stop button is pressed, record new data to plist
    //date is NSString in format yyyymmdd
    //hours and wage are NSNumbers representing hours worked, and wage per hour
    //NOTE: 1 wage per day. Currently new wage will not override.
    
    NSArray *hoursAndMinutes = [timeWorked componentsSeparatedByString: @":"];
    if([hoursAndMinutes count]!=2){
        hoursAndMinutes = [timeWorked componentsSeparatedByString: @" "];
    }
    double hours = [hoursAndMinutes[0] doubleValue] + [hoursAndMinutes[1] doubleValue]/60;

    //add array back to calendar
    
    NSMutableArray *newData = [NSMutableArray arrayWithObjects: [NSNumber numberWithDouble:hours], [NSNumber numberWithDouble:wage], nil];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss ZZZ";
    NSDate *todaysDate = [NSDate date];
    NSString* dateString = [dateFormatter stringFromDate:todaysDate];
    [self.calendarDictionary setObject:newData forKey:dateString];
}

- (void) saveCalendarData {
    //Save calendar back to plist in documents
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [directoryPaths objectAtIndex:0];
    NSString *userDataPath = [documentsPath stringByAppendingPathComponent:@"UserData.plist"];
    NSDictionary *userData = [NSDictionary dictionaryWithObject:self.calendarDictionary forKey: @"calendar"];
    
    
    NSError *error;
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:userData format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    
    [plistData writeToFile:userDataPath atomically:YES];
    //NSString* filePath = [self getFileForExport];
    //[self saveDataFromFile:filePath];
}

- (NSString*) getFileForExport {
    //convert data to a file for excel.

    NSMutableString* fileData = [NSMutableString stringWithString:@""];

    for(id key in self.calendarDictionary) {
        id value = [self.calendarDictionary objectForKey:key];
        [fileData appendString:key];
        [fileData appendString:@", "];
        NSString* hours = [value[0] descriptionWithLocale:nil];
        [fileData appendString:hours];
        [fileData appendString:@", "];
        NSString* wage = [value[1] descriptionWithLocale:nil];
        [fileData appendString:wage];
        [fileData appendString:@"\n"];
        
    }

    NSError *error;
    NSString *fileName = @"data.csv";
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), fileName];
    
    [fileData writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    return filePath;
}

- (UIDocumentInteractionController*) getDocumentInteractionController {
    NSString* filePath = [self getFileForExport];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    UIDocumentInteractionController* controller= [UIDocumentInteractionController interactionControllerWithURL:url];
    return controller;
}

- (BOOL) saveDataFromFile: (NSString*) filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileContents;
    if ([fileManager fileExistsAtPath:filePath]){
        fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    }else{
        return false;
    }
    NSArray *rows = [fileContents componentsSeparatedByString: @"\n"];
    
    for(NSString* row in rows){
        NSLog(@"row %@", row);
    }
    return true;
}

@end
