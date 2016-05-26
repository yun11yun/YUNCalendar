//
//  YUNCalendarDayModel.m
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import "YUNCalendarDayModel.h"
#import "NSDateFormatter+YUNCalendarAdditions.h"

@implementation YUNCalendarDayModel

- (instancetype)initWithType:(YUNCalendarDayModelType)type
{
    if (self = [super init]) {
        _type = type;
        _selected = NO;
        _optional = YES;
        _day = 0;
        _month = 0;
        _year = 0;
        _weekday = -1;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithType:YUNCalendarDayModelNone];
}

- (NSDate *)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.year;
    components.month = self.month;
    components.day = self.day;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSString *)toString
{
    NSDate *date = [self date];
    NSString *dateString = [[NSDateFormatter yun_dateFormatter] stringFromDate:date];
    return dateString;
}

- (NSString *)getWeekday
{
    return nil;
}

@end
