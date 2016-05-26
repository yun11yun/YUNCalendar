//
//  YUNCalendarView.h
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YUNCalendarViewDelegate;

@interface YUNCalendarView : UIView

@property (nonatomic, assign) NSUInteger maxInterval;

@property (nonatomic, strong) NSArray *notOptionalDates;

@property (nonatomic, strong) NSArray *selectDates;

@property (nonatomic, weak) id<YUNCalendarViewDelegate> delegate;

+ (CGFloat)viewHeightWithWidth:(CGFloat)width;

@end

@protocol YUNCalendarViewDelegate <NSObject>

@optional
- (void)calendarView:(YUNCalendarView *)calendarView didSelectedDates:(NSArray *)dateArray;

@end