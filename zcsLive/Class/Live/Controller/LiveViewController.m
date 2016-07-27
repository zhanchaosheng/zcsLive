//
//  LiveViewController.m
//  zcsLive
//
//  Created by Cusen on 16/7/23.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "LiveViewController.h"
#import "CameraViewController.h"

@interface LiveViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *photoBtn;
@property (nonatomic, strong) UIButton *videoBtn;
@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    [self setupLiveButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _photoBtn.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _videoBtn.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    [UIView animateWithDuration:0.25 animations:^{
        _imageView.frame = CGRectMake(0, KScreanHeight - 221, KScreanWidth, 221);
    }];
    
    [UIView animateWithDuration:0.45 animations:^{
        _photoBtn.transform = CGAffineTransformIdentity;
        _videoBtn.transform = CGAffineTransformIdentity;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGRect outRect = CGRectMake(0, KScreanHeight - 221, KScreanWidth, 221);
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    
    if (!CGRectContainsPoint(outRect, touchPoint)) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setupLiveButton {
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KScreanHeight, KScreanWidth, 221)];
    _imageView.image = [UIImage imageNamed:@"publishPhAndLi"];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"YXDeclineIn"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(KScreanWidth / 2 - 18, 15, 36, 15);
    [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:closeBtn];
    
    CGFloat btnW = 80;
    CGRect rect = _imageView.frame;
    CGFloat space = (rect.size.width - 2 * btnW) / 3;
    CGFloat centerY = rect.size.height / 2;
    
    _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_photoBtn setImage:[UIImage imageNamed:@"YXPhotoPhoto"] forState:UIControlStateNormal];
    _photoBtn.frame = CGRectMake(0, 0, btnW, btnW);
    _photoBtn.center = CGPointMake(space + btnW / 2, centerY);
    [_photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_photoBtn];
    
    _videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_videoBtn setImage:[UIImage imageNamed:@"YXLivephoto"] forState:UIControlStateNormal];
    _videoBtn.frame = CGRectMake(0, 0, btnW, btnW);
    _videoBtn.center = CGPointMake(KScreanWidth - space - btnW / 2, centerY);
    [_videoBtn addTarget:self action:@selector(videoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_videoBtn];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    
    if (flag) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            _imageView.frame = CGRectMake(0, KScreanHeight, KScreanWidth, 221);
            
        } completion:^(BOOL finished) {
            
            [self.view removeFromSuperview];
            
            if (completion) {
                completion();
            }
        }];
    }
    else {
        [self.view removeFromSuperview];
        
        if (completion) {
            completion();
        }
    }
}

- (void)closeBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoBtnClick:(UIButton *)sender {
    NSLog(@"photoBtnClick");
}

- (void)videoBtnClicked:(UIButton *)sender {
    NSLog(@"videoBtnClicked");
    [self dismissViewControllerAnimated:NO completion:nil];
    
    CameraViewController *cameraVC = [[CameraViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:cameraVC
                                                                                 animated:YES
                                                                               completion:nil];
}

@end
