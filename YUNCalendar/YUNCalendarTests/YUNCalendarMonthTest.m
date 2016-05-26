//
//  YUNCalendarMonthTest.m
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "YUNCalendarMonthModel.h"

@interface YUNCalendarMonthTest : XCTestCase

@property (nonatomic, strong) YUNCalendarMonthModel *monthModel;

@end

@implementation YUNCalendarMonthTest

- (void)setUp {
    [super setUp];
    _monthModel = [[YUNCalendarMonthModel alloc] initWithDate:[NSDate date]];
}

- (void)tearDown {
    _monthModel = nil;
    [super tearDown];
}

- (void)test
{
    XCTAssert(_monthModel.dayModels.count == 42);
    
    YUNCalendarDayModel *firstDayModel = [_monthModel.dayModels firstObject];
    XCTAssert(firstDayModel.type == YUNCalendarDayModelPast);
    
    YUNCalendarMonthModel *nextMonthModel = [_monthModel calendarMonthModelWithInterval:2];
    XCTAssert(nextMonthModel.dayModels.count == 42);
    
}

@end
