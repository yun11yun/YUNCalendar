//
//  YUNPopView.m
//  YUNPopView
//
//  Created by Orange on 4/12/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "YUNPopView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat kAnimationDuration = 0.4;

@interface YUNPopView ()

@property (nonatomic, strong) UIView *canvasView;

@end

static const CGFloat kBackButtonWidth = 40;

@implementation YUNPopView

#pragma mark - Lifecycle

- (instancetype)initWithContentSize:(CGSize)contentSize
{
    if (self = [super initWithFrame:CGRectZero]) {
        
        _contentSize = contentSize;
        
        _canvasView = [[UIView alloc] init];
        _canvasView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _canvasView.alpha = 0.0;
        _canvasView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75];
        [self addSubview:_canvasView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedOnSelf:)];
        [_canvasView addGestureRecognizer:tapGesture];
        
        _contentView = [[UIView alloc] init];
        _contentView.bounds = CGRectMake(0, 0, contentSize.width, contentSize.height);
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        _cancelButton = ({
            UIButton *button = [[UIButton alloc] init];
            button.frame = CGRectMake(CGRectGetWidth(_contentView.bounds) - kBackButtonWidth, 0, kBackButtonWidth, kBackButtonWidth);
            [button addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
        [_contentView addSubview:_cancelButton];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithContentSize:CGSizeZero];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithContentSize:CGSizeZero];
}

- (instancetype)init
{
    return [self initWithContentSize:CGSizeZero];
}

#pragma mark - Public methods

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    self.frame = window.bounds;
    self.canvasView.frame = self.bounds;
    self.contentView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) * 3 / 2);
    [window addSubview:self];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.canvasView.alpha = 1.0f;
        CGPoint contentCenter = self.contentView.center;
        contentCenter.y = CGRectGetHeight(self.frame) / 2;
        self.contentView.center = contentCenter;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.canvasView.alpha = 0.0;
        CGPoint contentCenter = self.contentView.center;
        contentCenter.y = CGRectGetHeight(self.frame) * 3 / 2;
        self.contentView.center = contentCenter;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Actions

- (void)tapedOnSelf:(UITapGestureRecognizer *)recognizer
{
    [self hide];
}

- (void)backButtonClicked:(UIButton *)sender
{
    [self hide];
}

#pragma mark - Properties

- (void)setContentSize:(CGSize)contentSize
{
    _contentSize = contentSize;
    CGRect frame = _contentView.frame;
    frame.size.width = contentSize.width;
    frame.size.height = contentSize.height;
    _contentView.frame = frame;
    [self setNeedsLayout];
}
@end
