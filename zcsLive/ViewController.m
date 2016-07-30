//
//  ViewController.m
//  zcsLive
//
//  Created by Cusen on 16/7/22.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "ViewController.h"
#import "MainTabBarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"YXChangeHeaderBackImage"];
    [self. view addSubview:bgImageView];
    
    UIButton *interBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    interBtn.tintColor = [UIColor whiteColor];
    [interBtn addTarget:self action:@selector(interBtnClecked:) forControlEvents:UIControlEventTouchUpInside];
    interBtn.frame = CGRectMake(KScreanWidth/2-50, KScreanHeight - 64 - 15, 100, 30);
    [interBtn setTitle:@"马上进入" forState:UIControlStateNormal];
    [self.view addSubview:interBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)interBtnClecked:(UIButton *)sender {
    
    CATransition *anim = [CATransition animation];
    anim.type = @"rippleEffect";
    anim.duration = 1.5f;
    anim.subtype = kCATransitionFromBottom;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:@"rippleEffectAnimation"];
    [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBarController alloc] init];
}
@end
