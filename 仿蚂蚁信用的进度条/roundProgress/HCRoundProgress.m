//
//  HCRoundProgress.m
//  仿蚂蚁信用的进度条
//
//  Created by changhailuo on 2017/10/25.
//  Copyright © 2017年 changhailuo. All rights reserved.
//

#import "HCRoundProgress.h"

#define center CGPointMake(self.center.x, self.frame.size.height)
@interface HCRoundProgress()

@property(nonatomic, strong) UIBezierPath *outSideBezierPath;
@property(nonatomic, strong) CAShapeLayer *outSideShapeLayer;

@property(nonatomic, strong) UIBezierPath *inSideBezierPath;
@property(nonatomic, strong) CAShapeLayer *inSideShapeLayer;

@property(nonatomic, strong) UIView *inView;
@property(nonatomic, strong) UIView *outView;

@end

@implementation HCRoundProgress

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self normalData];
    }
    return self;
}

-(void)normalData{
    self.outRadius = 150;
    self.inRadius = 130;
    self.maxProgress = 100;
}

-(void)createOut{
    self.outSideBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:self.outRadius startAngle:M_PI endAngle:2*M_PI clockwise:YES];
    //划线
    CAShapeLayer *outSideShapeLayer = [CAShapeLayer layer];
    outSideShapeLayer.strokeColor = [UIColor blackColor].CGColor;
    outSideShapeLayer.fillColor = nil; // 默认为blackColor
    outSideShapeLayer.lineWidth = 2;
    outSideShapeLayer.path = self.outSideBezierPath.CGPath;
    [self.layer addSublayer:outSideShapeLayer];
    self.outSideShapeLayer = outSideShapeLayer;
}

-(void)createIn{
    UIBezierPath *inSideBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:self.inRadius startAngle:M_PI endAngle:M_PI * 2 clockwise:YES];
    self.inSideBezierPath = inSideBezierPath;
    
    CAShapeLayer *inSideShapeLayer = [CAShapeLayer layer];
    inSideShapeLayer.lineDashPattern = @[@(5),@(5)];
    inSideShapeLayer.strokeColor = [UIColor blackColor].CGColor;
    inSideShapeLayer.fillColor = nil; // 默认为blackColor
    inSideShapeLayer.lineWidth = 2;
    inSideShapeLayer.path = inSideBezierPath.CGPath;
    [self.layer addSublayer:inSideShapeLayer];
    self.inSideShapeLayer = inSideShapeLayer;
}

-(void)show{
    [self createOut];
    [self createIn];
    [self addSubview:self.inView];
    [self addSubview:self.outView];
}

-(void)setProgress:(CGFloat)progress{
    [self bindDataWithProgress:progress];
}

-(void)bindDataWithProgress:(CGFloat)progress
{
    CGFloat percent = progress / self.maxProgress;
    CGFloat angle = M_PI + M_PI * percent;
    
    UIBezierPath *inPath = [UIBezierPath bezierPathWithArcCenter:center radius:self.inRadius - 20 startAngle:M_PI endAngle:angle clockwise:YES];
    UIBezierPath *outPath = [UIBezierPath bezierPathWithArcCenter:center radius:self.outRadius startAngle:M_PI endAngle:angle clockwise:YES];
    
    [self startAnimationWithLayer:self.inView.layer path:inPath.CGPath duration:3.0 rotationMode:kCAAnimationRotateAuto];
    [self startAnimationWithLayer:self.outView.layer path:outPath.CGPath duration:3.0 rotationMode:kCAAnimationRotateAuto];
    
}

-(void)startAnimationWithLayer:(CALayer *)layer
                          path:(CGPathRef)path
                      duration:(CGFloat)duration
                  rotationMode:(NSString *)rotationMode
{
    CAKeyframeAnimation * animate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animate.path = path;
    animate.duration = duration;
    animate.removedOnCompletion = NO;
    animate.fillMode = kCAFillModeForwards;
    animate.rotationMode = rotationMode;
    CAMediaTimingFunction *linearTim = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animate.timingFunctions = @[linearTim];
    [layer addAnimation:animate forKey:nil];
}

-(UIView *)inView
{
    if (!_inView) {
        _inView = [[UIView alloc]initWithFrame:CGRectMake(center.x - self.inRadius + 20, center.y-5, 20, 20)];
        _inView.backgroundColor = [UIColor redColor];
    }
    return _inView;
}

-(UIView *)outView
{
    if (!_outView) {
        _outView = [[UIView alloc]initWithFrame:CGRectMake(center.x - self.outRadius, center.y-5, 10, 10)];
        _outView.backgroundColor = [UIColor blueColor];
        _outView.layer.cornerRadius = 5;
        _outView.layer.masksToBounds = YES;
    }
    return _outView;
}
@end
