//
//  ViewController.m
//  YUNCalendar
//
//  Created by Orange on 5/25/16.
//  Copyright © 2016 yun11yun. All rights reserved.
//

#import "ViewController.h"

#import "YUNCalendarView.h"

#import "YUNPopView.h"
#import "YUNPopCalendarView.h"

@interface ViewController ()<YUNCalendarViewDelegate, YUNPopCalendarViewDelegate>

@property (nonatomic, strong) YUNCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _calendarView = [[YUNCalendarView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    _calendarView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
    _calendarView.center = self.view.center;
    _calendarView.maxInterval = 12;
    _calendarView.delegate = self;
    _calendarView.selectedColor = [UIColor blueColor];
    _calendarView.dimmedColor = [UIColor purpleColor];
    _calendarView.dimmedDates = @[@"2016-06-12",@"2016-06-23",@"2016-07-01",@"2016-07-23"];
    _calendarView.selectedDates = @[@"2016-06-01", @"2016-06-02", @"2016-06-03"];
    [self.view addSubview:_calendarView];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//    button.center = self.view.center;
//    [button setTitle:@"点击" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    button.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.1].CGColor;
//    button.layer.borderWidth = 1.0f;
//    button.layer.cornerRadius = 5.f;
//    button.layer.masksToBounds = YES;
//    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
}

- (void)buttonClicked:(UIButton *)sender
{
    YUNPopCalendarView *popView = [[YUNPopCalendarView alloc] init];
    popView.maxInterval = 6;
    popView.delegate = self;
    popView.dimmedDates = @[@"2016-06-12",@"2016-06-23",@"2016-07-01",@"2016-07-23"];
    popView.selectedDates = @[@"2016-06-01", @"2016-06-02", @"2016-06-03"];
    [popView show];
}

- (void)popCalendarView:(YUNPopCalendarView *)popView didSelectedDates:(NSArray *)dateArray
{
    
}

@end
