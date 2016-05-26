//
//  YUNCalendarMonthModel.m
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import "YUNCalendarMonthModel.h"
#import "NSDate+YUNCalendarAdditions.h"

@implementation YUNCalendarMonthModel
{
    NSDate *_referenceDate;
    NSMutableArray *_dayModels;
}

- (instancetype)initWithDate:(NSDate *)date
{
    if (self = [super init]) {
        _referenceDate = date;
        NSDate *firstDate = [date firstDayOfCurrentMonth];
        NSDateComponents *dateComponents = [NSDate yun_calendarComponentsFromDate:firstDate];
        _year = dateComponents.year;
        _month = dateComponents.month;
        _firstWeekday = [firstDate firstWeekdayInCurrentMonth];
        
        NSDate *today = [[NSCalendar currentCalendar] dateFromComponents:[NSDate yun_calendarComponentsFromDate:[NSDate date]]];
        
        NSUInteger numberOfDays = [firstDate numberOfDaysInCurrentMonth];
        _dayModels = [NSMutableArray arrayWithCapacity:numberOfDays];
        for (NSInteger index = 0; index < numberOfDays; index ++) {
            YUNCalendarDayModel *dayModel = [[YUNCalendarDayModel alloc] init];
            dayModel.year = _year;
            dayModel.month = _month;
            dayModel.day = (index + 1);
            
            NSComparisonResult result = [today compare:[dayModel date]];
            if (result == NSOrderedAscending || result == NSOrderedSame) {
                dayModel.type = YUNCalendarDayModelFutur;
            } else {
                dayModel.type = YUNCalendarDayModelPast;
            }
            [_dayModels addObject:dayModel];
        }
        
        for (NSInteger index = 0; index < _firstWeekday; index ++) {
            YUNCalendarDayModel *emptyDayModel = [[YUNCalendarDayModel alloc] initWithType:YUNCalendarDayModelNone];
            [_dayModels insertObject:emptyDayModel atIndex:0];
        }
        
        NSInteger number = 42 - _dayModels.count;
        if (number > 0) {
            for (NSInteger index = 0; index < number; index ++) {
                YUNCalendarDayModel *emptyDayModel = [[YUNCalendarDayModel alloc] initWithType:YUNCalendarDayModelNone];
                [_dayModels addObject:emptyDayModel];
            }
        }
    }
    return self;
}

- (YUNCalendarMonthModel *)calendarMonthModelWithInterval:(NSInteger)interval
{
    NSDate *firstDate = [_referenceDate firstDayOfFollowingMonth:interval];
    return [[[self class] alloc] initWithDate:firstDate];
}

- (NSArray *)dayModels
{
    return [_dayModels copy];
}

@end
