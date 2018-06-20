//
//  CalendarData.h
//  Wagr
//
//  Copyright © Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface CalendarData : NSObject

@property NSMutableDictionary *calendarDictionary;

- (void)loadCalendarData;
- (void)recordCalendarData:(NSDate*)date wage:(double)wage timeWorked:(NSString*)timeWorked;
- (void)saveCalendarData;
- (UIDocumentInteractionController*)getDocumentInteractionController;
- (BOOL)saveDataFromFile:(NSString*)filePath;
- (NSString*)getFileForExport;

@end
