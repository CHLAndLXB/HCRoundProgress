//
//  HCRoundProgress.h
//  仿蚂蚁信用的进度条
//
//  Created by changhailuo on 2017/10/25.
//  Copyright © 2017年 changhailuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCRoundProgress : UIView

/**
 内圈圆半径
 */
@property(nonatomic,assign)CGFloat inRadius;

/**
 外圈圆半径
 */
@property(nonatomic,assign)CGFloat outRadius;

/**
 最大值
 */
@property(nonatomic,assign)CGFloat maxProgress;
/**
 当前的进度
 */
@property(nonatomic,assign)CGFloat progress;

/**
 展示
 */
-(void)show;
@end
