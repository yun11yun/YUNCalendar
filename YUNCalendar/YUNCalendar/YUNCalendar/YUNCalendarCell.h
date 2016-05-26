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


@end
