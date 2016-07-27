//
//  CameraViewController.m
//  zcsLive
//
//  Created by Cusen on 16/7/23.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "CameraViewController.h"
#import "StartLiveView.h"
#import "GPUImageGaussianBlurFilter.h"

@interface CameraViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *myTitle;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景图片高斯模糊
    [self gaussianImage];
    
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    //设置键盘TextField
    [self setupTextField];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark ---- <设置键盘TextField>
- (void)setupTextField {
    
    [_myTitle becomeFirstResponder];
    
    //设置键盘颜色
    _myTitle.tintColor = [UIColor whiteColor];
    
    //设置占位文字颜色
    [_myTitle setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

}

#pragma mark ---- <设置背景图片高斯模糊>
- (void)gaussianImage {
    
    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = 2.0;
    UIImage * image = [UIImage imageNamed:@"bg_zbfx"];
    UIImage *blurredImage = [blurFilter imageByFilteringImage:image];
    
    self.backgroundView.image = blurredImage;
}

//返回主界面
- (IBAction)backMain {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//开始直播采集
- (IBAction)startLiveStream {
    
    [_myTitle resignFirstResponder];
    
    StartLiveView *view = [[StartLiveView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    _backBtn.hidden = YES;
    _middleView.hidden = YES;
    
}

@end
