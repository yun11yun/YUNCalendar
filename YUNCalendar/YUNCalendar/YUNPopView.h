//
//  YUNPopView.h
//  YUNPopView
//
//  Created by Orange on 4/12/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YUNPopView : UIView

/**
 * contentView用于承载展示的视图,用于展示的视图请全部放在contentView上
 *
 * 默认的size 为 screenSize / 2
 * 默认的center 为 window.center
 */
@property (nonatomic, strong, readonly) UIView *contentView;

/** 
 * contentView的size 
 *
 * 默认为 screenSize / 2,
 */
@property (nonatomic, assign) CGSize contentSize;

/**
 *  取消按钮
 */
@property (nonatomic, strong ,readonly) UIButton *cancelButton;


- (instancetype)initWithContentSize:(CGSize)contentSize NS_DESIGNATED_INITIALIZER;

/**
 * 默认动画为从下往上滑出
 */
- (void)show;

/**
 * 默认动画为往下滑出
 */
- (void)hide;

@end
