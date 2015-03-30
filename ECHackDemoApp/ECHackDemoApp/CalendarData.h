//
//  CalendarData.h
//  ECHackDemoApp
//
//  Created by Administrator on 3/30/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarData : NSObject {

}

@property NSMutableDictionary *calendarDictionary;
- (void) loadCalendarData;
- (void) recordCalendarData: (NSDate*)date wage:(double)wage timeWorked: (NSString*)timeWorked;
- (void) saveCalendarData;
@end
