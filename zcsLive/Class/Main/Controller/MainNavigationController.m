//
//  MainNavigationController.m
//  zcsLive
//
//  Created by Cusen on 16/7/22.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MainNavigationController

+ (void)initialize {
    
    // 设置navigation背景
    if (self == [MainNavigationController class]) {
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
        [bar setBackgroundImage:[UIImage imageNamed:@"NavigationBar"]
                  forBarMetrics:UIBarMetricsDefault];
        bar.tintColor = [UIColor whiteColor];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 实现全屏滑动返回
    id target = self.interactivePopGestureRecognizer.delegate;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan =
        [[UIPanGestureRecognizer alloc] initWithTarget:target
                                                action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    [self.view addGestureRecognizer:pan];
    
    // 取消边缘滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    pan.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    
    // 当前不是在根控制器则可滑动返回
    return self.childViewControllers.count > 1;
}

#pragma mark - override pushViewController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 非根控制器隐藏底部tabbar
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

@end
