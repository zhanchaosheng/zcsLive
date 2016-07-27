//
//  MineViewController.m
//  zcsLive
//
//  Created by Cusen on 16/7/23.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    // 设置导航条透明
    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"YXUserEdit"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(leftBarButtonItemClicked:)];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"YXUserSetting"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(rightBarButtonItemClicked:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonItemClicked:(UIBarButtonItem *)sender {
    
}

- (void)rightBarButtonItemClicked:(UIBarButtonItem *)sender {
    
}

@end
