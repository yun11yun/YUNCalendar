//
//  YUNPopCalendarView.h
//  YUNCalendar
//
//  Created by Orange on 5/26/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import "YUNPopView.h"

@protocol YUNPopCalendarViewDelegate;

@interface YUNPopCalendarView : YUNPopView

@property (nonatomic, assign) NSUInteger maxInterval;

@property (nonatomic, strong) NSArray *notOptionalDates;

@property (nonatomic, strong) NSArray *selectDates;

@property (nonatomic, weak) id<YUNPopCalendarViewDelegate> delegate;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end

@protocol YUNPopCalendarViewDelegate <NSObject>

@optional
/**
 *  这个代理方法在确认按钮被点击时触发，触发后popCalendarView将调用hide方法
 *
 *  @param popView   popCalendarView自身
 *  @param dateArray 被选择NSString类型的日期列表
 */
- (void)popCalendarView:(YUNPopCalendarView *)popView didSelectedDates:(NSArray *)dateArray;

@end
