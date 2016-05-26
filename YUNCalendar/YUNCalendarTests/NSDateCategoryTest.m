//
//  NSDateCategoryTest.m
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+YUNCalendarAdditions.h"

@interface NSDateCategoryTest : XCTestCase

@property (nonatomic, strong) NSDate *currentDate;

@end

@implementation NSDateCategoryTest

- (void)setUp {
    [super setUp];
    _currentDate = [NSDate date];
}

- (void)tearDown {
    _currentDate = nil;
    [super tearDown];
}

- (void)test
{
    NSInteger numberOfDays = [_currentDate numberOfDaysInCurrentMonth];
    XCTAssert(numberOfDays == 31);
    
    NSDate *firstDateOfCurrentMonth = [_currentDate firstDayOfCurrentMonth];
    NSInteger month = [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:firstDateOfCurrentMonth];
    NSInteger day = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:firstDateOfCurrentMonth];
    XCTAssert(month == 5);
    XCTAssert(day == 1);
    
    NSUInteger firstWeekday = [_currentDate firstWeekdayInCurrentMonth];
    XCTAssert(firstWeekday == 0);
    
    
    NSDate *followingFirstDate = [_currentDate firstDayOfFollowingMonth:3];
    NSInteger followingMonth = [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:followingFirstDate];
    NSInteger followingDay = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:firstDateOfCurrentMonth];
    XCTAssert(followingMonth == 8);
    XCTAssert(followingDay == 1);
}

@end
