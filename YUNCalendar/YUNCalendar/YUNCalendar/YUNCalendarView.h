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
/**
 *  设置可见的月数，默认为3，
 */
@property (nonatomic, assign) NSUInteger maxInterval;

/**
 *  已被选择的日期
 */
@property (nonatomic, strong) NSArray *selectedDates;

/**
 *  不可选择的日期
 */
@property (nonatomic, strong) NSArray *dimmedDates;

/**
 *  日历是否可选， 默认为YES;
 */
@property (nonatomic, assign) BOOL calendarUserInteractionEnabled;

/**
 *  日期被选中时的颜色
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 *  不可选的日期显示的颜色
 */
@property (nonatomic, strong) UIColor *dimmedColor;

/**
 *  日期被选择是显示的图片
 */
@property (nonatomic, strong) UIImage *selectedImage;

/**
 *  不可选的日期显示的图片
 */
@property (nonatomic, strong) UIImage *dimmedImage;


@property (nonatomic, weak) id<YUNCalendarViewDelegate> delegate;


+ (CGFloat)viewHeightWithWidth:(CGFloat)width;

@end

@protocol YUNCalendarViewDelegate <NSObject>

@optional
- (void)calendarView:(YUNCalendarView *)calendarView didSelectedDates:(NSArray *)dateArray;

@end