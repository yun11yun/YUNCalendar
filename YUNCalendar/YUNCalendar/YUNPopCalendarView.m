//
//  YUNPopCalendarView.m
//  YUNCalendar
//
//  Created by Orange on 5/26/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import "YUNPopCalendarView.h"
#import "YUNCalendarView.h"

static const CGFloat kContentSizeWidth = 300;
static const CGFloat kBottomHeight = 40;

@interface YUNPopCalendarView ()<YUNCalendarViewDelegate>

@property (nonatomic, strong) YUNCalendarView *calendarView;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation YUNPopCalendarView

- (instancetype)init
{
    CGFloat calendarHeight = [YUNCalendarView viewHeightWithWidth:kContentSizeWidth];
    CGFloat contentHeight = calendarHeight + kBottomHeight;
    CGSize contentSize = CGSizeMake(kContentSizeWidth, contentHeight);
    self = [super initWithContentSize:contentSize];
    if (self) {
        _calendarView = [[YUNCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, calendarHeight)];
        _calendarView.delegate = self;
        [self.contentView addSubview:_calendarView];
        
        self.cancelButton.frame = CGRectMake(0, CGRectGetMaxY(_calendarView.frame), contentSize.width / 2, kBottomHeight);
        self.cancelButton.titleLabel.font = [self defaultFont];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[self defaultColor] forState:UIControlStateNormal];
        self.cancelButton.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.1].CGColor;
        self.cancelButton.layer.borderWidth = 1.0f;
        
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(contentSize.width / 2, CGRectGetMaxY(_calendarView.frame), contentSize.width / 2, kBottomHeight)];
        _confirmButton.titleLabel.font = [self defaultFont];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[self defaultColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.1].CGColor;
        _confirmButton.layer.borderWidth = 1.0f;
        [self.contentView addSubview:_confirmButton];
    }
    return self;
}

- (instancetype)initWithContentSize:(CGSize)contentSize
{
    return [self init];
}

- (void)confirmButtonClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popCalendarView:didSelectedDates:)]) {
        [self.delegate popCalendarView:self didSelectedDates:self.selectDates];
    }
}

#pragma mark - YUNCalendarViewDelegate

- (void)calendarView:(YUNCalendarView *)calendarView didSelectedDates:(NSArray *)dateArray
{
    if (dateArray && dateArray.count != 0) {
        self.selectDates = dateArray;
    }
}

#pragma mark - Properties

- (void)setNotOptionalDates:(NSArray *)notOptionalDates
{
    _notOptionalDates = notOptionalDates;
    _calendarView.notOptionalDates = notOptionalDates;
}

- (void)setSelectDates:(NSArray *)selectDates
{
    _selectDates = selectDates;
    _calendarView.selectDates = selectDates;
}

- (void)setMaxInterval:(NSUInteger)maxInterval
{
    _maxInterval = maxInterval;
    _calendarView.maxInterval = maxInterval;
}

#pragma mark- Helper methods

- (UIFont *)defaultFont
{
    return [UIFont systemFontOfSize:14.f];
}

- (UIColor *)defaultColor
{
    return [UIColor grayColor];
}

@end
