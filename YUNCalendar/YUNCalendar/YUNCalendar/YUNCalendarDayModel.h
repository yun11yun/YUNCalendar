//
//  YUNCalendarDayModel.h
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YUNCalendarDayModelType)
{
    YUNCalendarDayModelNone,
    YUNCalendarDayModelPast,
    YUNCalendarDayModelFutur,
    YUNCalendarDayModelWeekend,
    YUNCalendarDayModelHoliday,
};

@interface YUNCalendarDayModel : NSObject

@property (nonatomic, assign, getter=isOptional) BOOL optional;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign) YUNCalendarDayModelType type;

@property (nonatomic, assign) NSUInteger day;
@property (nonatomic, assign) NSUInteger month;
@property (nonatomic, assign) NSUInteger year;
@property (nonatomic, assign) NSUInteger weekday;

@property (nonatomic, copy) NSString *holiday;

- (instancetype)initWithType:(YUNCalendarDayModelType)type NS_DESIGNATED_INITIALIZER;

- (NSDate *)date;
- (NSString *)toString;
- (NSString *)getWeekday;

@end
