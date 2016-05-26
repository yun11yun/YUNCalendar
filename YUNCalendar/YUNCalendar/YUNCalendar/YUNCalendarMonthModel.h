//
//  YUNCalendarMonthModel.h
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YUNCalendarDayModel.h"

@interface YUNCalendarMonthModel : NSObject

@property (nonatomic, assign, readonly) NSUInteger year;
@property (nonatomic, assign, readonly) NSUInteger month;
@property (nonatomic, assign, readonly) NSUInteger firstWeekday;

@property (nonatomic, copy, readonly) NSArray *dayModels;

- (instancetype)initWithDate:(NSDate *)date;

- (YUNCalendarMonthModel *)calendarMonthModelWithInterval:(NSInteger)interval;

@end
