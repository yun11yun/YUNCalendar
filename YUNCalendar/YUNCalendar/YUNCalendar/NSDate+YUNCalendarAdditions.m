//
//  NSDate+YUNCalendarAdditions.m
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import "NSDate+YUNCalendarAdditions.h"

@implementation NSDate (YUNCalendarAdditions)

+ (NSDateComponents *)yun_calendarComponentsFromDate:(NSDate *)date;
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth fromDate:date];
    return dateComponents;
}

- (NSUInteger)numberOfDaysInCurrentMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

- (NSUInteger)firstWeekdayInCurrentMonth
{
    NSDate *firstDate = [self firstDayOfCurrentMonth];
    
    NSUInteger firstWeekday = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:firstDate];
    
    return firstWeekday - 1;
}

- (NSDate *)firstDayOfFollowingMonth:(NSUInteger)month
{
    NSDate *currentFirstDate = [self firstDayOfCurrentMonth];
    
    NSDate *followingFirstDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:month toDate:currentFirstDate options:NSCalendarMatchNextTime];
    
    return followingFirstDate;
}

- (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

- (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy年M月d日"];
    
    return dateFormatter;
}

@end
