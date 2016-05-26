//
//  YUNCalendarView.m
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import "YUNCalendarView.h"
#import "YUNCalendarCell.h"
#import "YUNCalendarMonthModel.h"
#import "NSDate+YUNCalendarAdditions.h"
#import "NSDateFormatter+YUNCalendarAdditions.h"

@interface YUNCalendarView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *dateButton;
@property (nonatomic, strong) NSMutableArray *weekLabels;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) YUNCalendarMonthModel *originMonthModel;
@property (nonatomic, strong) YUNCalendarMonthModel *currentMonthModel;
@property (nonatomic, assign) NSUInteger interval;

@end

static const CGFloat kTopViewHeight = 60;

static NSString * const kCollectionViewCellIdentifier = @"collectionViewCell";
static NSString * const kCalendarCellIdentifier = @"calendarCell";

@implementation YUNCalendarView
{
    NSMutableArray *_selectDates;
}

#pragma mark - Lifecycle

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeCalendarView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeCalendarView];
    }
    return self;
}

- (void)initializeCalendarView
{
    _interval = 0;
    _maxInterval = 4;
    _selectDates = [NSMutableArray array];
    _originMonthModel = [[YUNCalendarMonthModel alloc] initWithDate:[NSDate date]];
    _currentMonthModel = [_originMonthModel calendarMonthModelWithInterval:_interval];
    
    // 头部
    _topView = [[UIView alloc] init];
    [self addSubview:_topView];
    
    _leftButton = [[UIButton alloc] init];
    [_leftButton setTitle:@"←" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_leftButton];
    
    _rightButton = [[UIButton alloc] init];
    [_rightButton setTitle:@"→" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_rightButton];
    
    _dateButton = [[UIButton alloc] init];
    _dateButton.userInteractionEnabled = NO;
    [_dateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_topView addSubview:_dateButton];
    
    NSArray *weekStrings = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    _weekLabels = [NSMutableArray array];
    for (NSInteger i = 0; i < 7; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = weekStrings[i];
        [_topView addSubview:label];
        [_weekLabels addObject:label];
    }
    
    //日历主体
    _mainView = [[UIView alloc] init];
    [self addSubview:_mainView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [self getCollectionViewCellSize];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.headerReferenceSize = CGSizeZero;
    flowLayout.footerReferenceSize = CGSizeZero;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    [_collectionView registerClass:[YUNCalendarCell class] forCellWithReuseIdentifier:kCalendarCellIdentifier];
    [_mainView addSubview:_collectionView];
    
    [self reloadView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize viewSize = self.bounds.size;
    
    _topView.frame = CGRectMake(0, 0, viewSize.width, kTopViewHeight);
    CGFloat topButtonLeft = 30;
    CGFloat buttonTop = 10;
    CGFloat buttonHeight = 30;
    _leftButton.frame = CGRectMake(topButtonLeft, buttonTop, 50, buttonHeight);
    _rightButton.frame = CGRectMake(viewSize.width - 80, buttonTop, 50, buttonHeight);
    _dateButton.frame = CGRectMake(CGRectGetMaxX(_leftButton.frame), buttonTop, viewSize.width - CGRectGetMaxX(_leftButton.frame) * 2, buttonHeight);
    
    CGFloat weekLabelY = CGRectGetMaxY(_dateButton.frame);
    CGFloat weekLabelWidth = viewSize.width / 7;
    CGFloat weekLabelHeight = 24.f;
    [_weekLabels enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.frame = CGRectMake(weekLabelWidth * idx, weekLabelY, weekLabelWidth, weekLabelHeight);
    }];
    
    _mainView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), viewSize.width, [self getCollectionViewCellSize].height * 6);
    _collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(_mainView.frame), CGRectGetHeight(_mainView.frame));
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YUNCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCalendarCellIdentifier forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.1].CGColor;
    cell.layer.borderWidth = 1.0f;
    cell.model = _currentMonthModel.dayModels[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YUNCalendarDayModel *dayModel = _currentMonthModel.dayModels[indexPath.row];
    dayModel.selected = !dayModel.selected;
    
    if (dayModel.selected == YES) {
        [_selectDates addObject:[dayModel toString]];
    } else {
        [_selectDates removeObject:[dayModel toString]];
    }
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:didSelectedDates:)]) {
        [self.delegate calendarView:self didSelectedDates:[self.selectDates copy]];
    }
}

#pragma mark - Publlic methods

+ (CGFloat)viewHeightWithWidth:(CGFloat)width
{
    CGFloat itemWidth = width / 7;
    return itemWidth * 6 + kTopViewHeight;
}

#pragma mark - Properties

- (void)setSelectDates:(NSArray *)selectDates
{
    _selectDates = [selectDates mutableCopy];
    [self reloadData];
}

#pragma mark - Action

- (void)leftButtonClicked:(UIButton *)sender
{
    _interval --;
    [self reloadView];
}

- (void)rightButtonClicked:(UIButton *)sender
{
    _interval ++;
    [self reloadView];
}

#pragma mark - Private methods

- (CGSize)getCollectionViewCellSize
{
    CGFloat itemWidth = self.bounds.size.width / 7;
    return CGSizeMake(itemWidth, itemWidth);
}

- (void)reloadView
{
    if (_interval == 0) {
        _leftButton.hidden = YES;
    } else {
        _leftButton.hidden = NO;
    }
    
    if (_interval == _maxInterval) {
        _rightButton.hidden = YES;
    } else {
        _rightButton.hidden = NO;
    }
    
    _currentMonthModel = [_originMonthModel calendarMonthModelWithInterval:_interval];
    
    NSString *monthString = [NSString stringWithFormat:@"%ld年%ld月", _currentMonthModel.year, _currentMonthModel.month];
    [_dateButton setTitle:monthString forState:UIControlStateNormal];
    
    [self reloadData];
    
    [_collectionView reloadData];
}

- (void)reloadData
{
    NSDateFormatter *dateFormatter = [NSDateFormatter yun_dateFormatter];
    
    for (YUNCalendarDayModel *dayModel in _currentMonthModel.dayModels) {
        for (NSString *dateString in self.selectDates) {
            NSDate *date = [dateFormatter dateFromString:dateString];
            if ([date isEqualToDate:[dayModel date]]) {
                dayModel.selected = YES;
            }
        }
        for (NSString *dateString in self.notOptionalDates) {
            NSDate *date = [dateFormatter dateFromString:dateString];
            if ([date isEqualToDate:[dayModel date]]) {
                dayModel.optional = NO;
            }
        }
    }
}

@end
