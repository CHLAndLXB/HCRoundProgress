//
//  ViewController.m
//  仿蚂蚁信用的进度条
//
//  Created by changhailuo on 2017/10/25.
//  Copyright © 2017年 changhailuo. All rights reserved.
//

#import "ViewController.h"
#import "HCRoundProgress.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HCRoundProgress * progress = [[HCRoundProgress alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    progress.center = CGPointMake(self.view.center.x, 100);
    [progress show];
    
    [self.view addSubview:progress];
    
    progress.progress = 30;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
