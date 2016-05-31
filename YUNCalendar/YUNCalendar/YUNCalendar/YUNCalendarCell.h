//
//  YUNCalendarCell.h
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YUNCalendarDayModel;

@interface YUNCalendarCell : UICollectionViewCell

@property (nonatomic, weak) YUNCalendarDayModel *model;

@property (nonatomic, strong, readonly) UILabel *dayLabel;

/**
 *  被选择时的背景颜色, 默认颜色为[UIColor orangeColor];
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 *  不可选时的颜色, 默认颜色为[UIColor darkGrayColor];
 */
@property (nonatomic, strong) UIColor *dimmedColor;

/**
 *  日期被选择是显示的图片，默认为nil.
 */
@property (nonatomic, strong) UIImage *selectedImage;

/**
 *  不可选的日期显示的图片,默认为nil.
 */
@property (nonatomic, strong) UIImage *dimmedImage;

@end
