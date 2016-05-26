//
//  YUNCalendarCell.m
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import "YUNCalendarCell.h"
#import "YUNCalendarDayModel.h"

@implementation YUNCalendarCell
{
    UIImageView *_backgroundView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialzeCalendarCell];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialzeCalendarCell];
    }
    return self;
}

- (void)initialzeCalendarCell
{
    _backgroundView = [[UIImageView alloc] init];
    [self.contentView addSubview:_backgroundView];
    
    _dayLabel = [[UILabel alloc] init];
    _dayLabel.font = [UIFont systemFontOfSize:14.f];
    _dayLabel.textColor = [UIColor grayColor];
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_dayLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize cellSize = self.contentView.bounds.size;
    
    _backgroundView.frame = CGRectMake(0, 0, cellSize.width, cellSize.height);
    _dayLabel.frame = CGRectMake(0, 0, cellSize.width, cellSize.height);
}

- (void)setModel:(YUNCalendarDayModel *)model
{
    _model = model;
    if (_model) {
        _dayLabel.text = [NSString stringWithFormat:@"%ld",_model.day];
        
        if (_model.type == YUNCalendarDayModelNone) {
            _dayLabel.hidden = YES;
        } else {
            _dayLabel.hidden = NO;
        }
        
        if (_model.type == YUNCalendarDayModelPast) {
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
        
        if (_model.type == YUNCalendarDayModelNone ||
            _model.type == YUNCalendarDayModelPast ||
            _model.isOptional == NO) {
            self.userInteractionEnabled = NO;
        } else {
            self.userInteractionEnabled = YES;
        }
        
        if (_model.isSelected == YES && _model.isOptional == YES) {
            _backgroundView.backgroundColor = [UIColor orangeColor];
        } else if (_model.isOptional == NO) {
            _backgroundView.backgroundColor = [UIColor darkGrayColor];
        } else {
            _backgroundView.backgroundColor = [UIColor clearColor];
        }
    }
}

@end
