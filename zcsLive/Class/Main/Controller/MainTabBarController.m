//
//  MainTabBarController.m
//  zcsLive
//
//  Created by Cusen on 16/7/22.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "LiveViewController.h"
#import "AppDelegate.h"

@interface MainTabBarController ()
@property (nonatomic, strong) LiveViewController *liveVC;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewController];
    
    [self setupTabBarButtonItem];
    
    [self setupTabBarBackgroundImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup UI

- (void)setupChildViewController {
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    MainNavigationController *homeNav = [[MainNavigationController alloc] initWithRootViewController:homeVC];
    [self addChildViewController:homeNav];
    
    LiveViewController *liveVC = [[LiveViewController alloc] init];
    MainNavigationController *liveNav = [[MainNavigationController alloc] initWithRootViewController:liveVC];
    [self addChildViewController:liveNav];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    MainNavigationController *mineNav = [[MainNavigationController alloc] initWithRootViewController:mineVC];
    [self addChildViewController:mineNav];
}

- (void)setupTabBarButtonItem {
    
    self.tabBar.tintColor = [UIColor whiteColor];
    
    HomeViewController *homeVC = self.childViewControllers[0];
    homeVC.tabBarItem.title = @"首页";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"YXHome"];
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"YXHomeSelect"];
    
    LiveViewController *liveVC = self.childViewControllers[1];
    liveVC.tabBarItem.enabled = NO;
    [self addLiveButton];
    
    MineViewController *mineVC = self.childViewControllers[2];
    mineVC.tabBarItem.title = @"我的";
    mineVC.tabBarItem.image = [UIImage imageNamed:@"YXMySelf"];
    mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"YXMySelfSelect"];
}

- (void)setupTabBarBackgroundImage {
    
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"TabBarBack"];
}

- (void)addLiveButton {
    
    UIButton *liveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [liveBtn setImage:[UIImage imageNamed:@"YXShoot"] forState:UIControlStateNormal];
    
    [liveBtn sizeToFit];
    
    CGRect tabBarFrame = self.tabBar.bounds;
    liveBtn.center = CGPointMake(tabBarFrame.size.width * 0.5, tabBarFrame.size.height * 0.5 - 5);
    [liveBtn addTarget:self action:@selector(clickLiveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:liveBtn];
    
}

- (void)clickLiveBtn:(UIButton *)sender {
    
    if (self.liveVC == nil) {
        self.liveVC = [[LiveViewController alloc] init];
    }
    
    // presented
//    LiveViewController *liveVC = [[LiveViewController alloc] init];
//    liveVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    
//    [self presentViewController:liveVC animated:YES completion:^{
//        liveVC.view.superview.backgroundColor = [UIColor clearColor];
//    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.liveVC.view];
}

@end
