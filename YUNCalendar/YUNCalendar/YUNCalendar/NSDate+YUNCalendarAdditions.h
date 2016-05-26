//
//  NSDate+YUNCalendarAdditions.h
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YUNCalendarAdditions)

+ (NSDateComponents *)yun_calendarComponentsFromDate:(NSDate *)date;

- (NSUInteger)numberOfDaysInCurrentMonth;

- (NSUInteger)firstWeekdayInCurrentMonth;

- (NSDate *)firstDayOfCurrentMonth;

- (NSDate *)firstDayOfFollowingMonth:(NSUInteger)month;

- (NSDate *)dateFromString:(NSString *)dateString;

- (NSString *)stringFromDate:(NSDate *)date;

@end
