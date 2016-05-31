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
    UIColor *_dimmedColor;
    UIColor *_selectedColor;
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
    _selectedColor = [UIColor orangeColor];
    _dimmedColor = [UIColor darkGrayColor];
    
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

#pragma mark - Properties

- (void)setModel:(YUNCalendarDayModel *)model
{
    _model = model;
    [self p_updateView];
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    [self p_updateView];
}

- (UIColor *)selectedColor
{
    if (!_selectedColor) {
        _selectedColor = [UIColor orangeColor];
    }
    return _selectedColor;
}

- (void)setDimmedColor:(UIColor *)dimmedColor
{
    _dimmedColor = dimmedColor;
    [self p_updateView];
}

- (UIColor *)dimmedColor
{
    if (_dimmedColor == nil) {
        _dimmedColor = [UIColor darkGrayColor];
    }
    return _dimmedColor;
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    [self p_updateView];
}

- (void)setDimmedImage:(UIImage *)dimmedImage
{
    _dimmedImage = dimmedImage;
    [self p_updateView];
}

#pragma mark - Private methods

- (void)p_updateView
{
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
            _backgroundView.backgroundColor = self.selectedColor;
            _backgroundView.image = self.selectedImage;
        } else if (_model.isOptional == NO) {
            _backgroundView.backgroundColor = self.dimmedColor;
            _backgroundView.image = self.dimmedImage;
        } else {
            _backgroundView.backgroundColor = [[self class] defaultColor];
            _backgroundView.image = nil;
        }
    }
}

+ (UIColor *)defaultColor
{
    return [UIColor clearColor];
}

@end
