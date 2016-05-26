//
//  NSDateFormatter+YUNCalendarAdditions.m
//  YUNCalendar
//
//  Created by Orange on 5/26/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import "NSDateFormatter+YUNCalendarAdditions.h"

@implementation NSDateFormatter (YUNCalendarAdditions)

+ (NSDateFormatter *)yun_dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return dateFormatter;
}

@end
