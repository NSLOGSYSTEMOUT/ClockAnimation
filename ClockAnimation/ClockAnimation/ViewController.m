//
//  ViewController.m
//  ClockAnimation
//
//  Created by leotao on 16/7/25.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    CALayer *_secondLayer;
    CALayer *_miniteLayer;
    CALayer *_hourLayer;
}

// 每秒秒针转6度
#define perSecendA 6

// 每分钟分针转6度
#define perMinuteA 6

// 每小时时针转30度 360/12
#define perHourA 30

// 每分钟时针转30/60度
#define perMinuteHourA 0.5

//角度转化为弧度
#define angle2radian(x) ((x) / 180.0 * M_PI)

@property (weak, nonatomic) IBOutlet UIImageView *clockImageViw;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addSecond];
    [self addMiniture];
    [self addHour];

    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [self update];
}

// 秒针
-(void)addSecond{
    CGFloat  imageW = self.clockImageViw.bounds.size.width;
    CGFloat  imageH = self.clockImageViw.bounds.size.height;
    
    CALayer *secondLayer = [CALayer layer];
    secondLayer.anchorPoint = CGPointMake(0.5, 1);
    secondLayer.position = CGPointMake(imageH*0.5, imageW*0.5);
    secondLayer.bounds = CGRectMake(0, 0, 1, imageH * 0.5 - 20);
    secondLayer.backgroundColor = [UIColor redColor].CGColor;
    _secondLayer = secondLayer;
    [_clockImageViw.layer addSublayer:secondLayer];


}
// 分针
-(void)addMiniture{
    CGFloat  imageW = self.clockImageViw.bounds.size.width;
    CGFloat  imageH = self.clockImageViw.bounds.size.height;
    
    CALayer *miniteLayer = [CALayer layer];
    miniteLayer.anchorPoint = CGPointMake(0.5, 1);
    miniteLayer.position = CGPointMake(imageH*0.5, imageW*0.5);
    miniteLayer.bounds = CGRectMake(0, 0, 2, imageH * 0.5 - 40);
    miniteLayer.backgroundColor = [UIColor greenColor].CGColor;
    _miniteLayer = miniteLayer;
    [_clockImageViw.layer addSublayer:miniteLayer];
    
}
// 时针
-(void)addHour{
    
    CGFloat  imageW = self.clockImageViw.bounds.size.width;
    CGFloat  imageH = self.clockImageViw.bounds.size.height;
    
    CALayer *hourLayer = [CALayer layer];
    hourLayer.anchorPoint = CGPointMake(0.5, 1);
    hourLayer.position = CGPointMake(imageH*0.5, imageW*0.5);
    hourLayer.bounds = CGRectMake(0, 0, 4, imageH * 0.5 - 50);
    hourLayer.backgroundColor = [UIColor blueColor].CGColor;
    _hourLayer = hourLayer;
    [_clockImageViw.layer addSublayer:hourLayer];
}

-(void)update{

    // 获取日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取日期组件
    NSDateComponents *compoents = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    // 获取秒数
    CGFloat sec = compoents.second;
    // 获取分钟
    CGFloat minute = compoents.minute;
    // 获取小时
    CGFloat hour = compoents.hour;
    
    
    // 秒针旋转°
    CGFloat secondA = sec * perSecendA;
    // 分针旋转°
    CGFloat minuteA = minute * perMinuteA;
    // 时针旋转°
    CGFloat hourA = hour * perHourA;
    hourA += minute * perMinuteHourA;
    
    // 旋转
    _secondLayer.transform = CATransform3DMakeRotation(angle2radian(secondA), 0, 0, 1);
    _miniteLayer.transform = CATransform3DMakeRotation(angle2radian(minuteA), 0, 0, 1);
    _hourLayer.transform = CATransform3DMakeRotation(angle2radian(hourA), 0, 0, 1);
    
}

@end
