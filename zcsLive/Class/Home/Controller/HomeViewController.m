//
//  HomeViewController.m
//  zcsLive
//
//  Created by Cusen on 16/7/23.
//  Copyright © 2016年 Cusen. All rights reserved.
//

#import "HomeViewController.h"
#import "AttentionViewController.h"
#import "HotViewController.h"
#import "FindViewController.h"

static NSString *cellReuseIdentifier = @"cellReuseIdentifier";

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *titleButtons;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChildViewController];
    
    [self setupContentView];
    
    [self setupNavgationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)titleButtons {
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)setupChildViewController {
    
    //关注
    AttentionViewController *attenVc = [[AttentionViewController alloc] init];
    attenVc.title = @"关注";
    [self addChildViewController:attenVc];
    
    //热门
    HotViewController *hotVc = [[HotViewController alloc] init];
    hotVc.title = @"热门";
    [self addChildViewController:hotVc];
    
    //发现
    FindViewController *findVc = [[FindViewController alloc] init];
    findVc.title = @"发现";
    [self addChildViewController:findVc];
}

- (void)setupNavgationBar {
    
    //搜索
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"YXUserSearchGary"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(searchBtnClicked:)];
    
    //信息
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"YXMessageButton"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(InfoBtnClicked:)];
    
    //标题导航项
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    self.navigationItem.titleView = _titleView;
    
    [self setupTitleButton];
}

- (void)setupTitleButton {
    
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat btnW = 50;
    CGFloat btnSpace = 18;
    CGFloat btnH = self.titleView.bounds.size.height;
    
    CGFloat L = (self.titleView.bounds.size.width - count * (btnW + btnSpace)) / 2;
    
    CGFloat btnCenterX;
    
    for (int i = 0; i < count; i++) {
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        
        UIViewController *vc = self.childViewControllers[i];
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:17];
        
        btnCenterX = L + (btnW + btnSpace) * (i + 0.5);
        titleButton.frame = CGRectMake(0, 0, btnW, btnH);
        titleButton.center = CGPointMake(btnCenterX, self.titleView.center.y);
        
        [titleButton addTarget:self
                        action:@selector(titleBtnClick:)
              forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleView addSubview:titleButton];
        
        // 添加下划线
        if (i == 0) {
            
            CGFloat h = 2;
            CGFloat y = 37;
            
            UIView *lineView = [[UIView alloc] init];
            CGRect lineFrame = lineView.frame;
            
            lineFrame.size.height = h;
            
            [titleButton.titleLabel sizeToFit];
            CGRect textFrame = titleButton.titleLabel.frame;
            lineFrame.size.width = textFrame.size.width + 8;
            
            lineFrame.origin.y = y;
            
            lineView.frame = lineFrame;
            
            CGPoint center = CGPointMake(titleButton.center.x, lineView.center.y);
            lineView.center = center;
            
            lineView.backgroundColor = [UIColor orangeColor];
            _lineView = lineView;
            
            [self.titleView addSubview:lineView];
            
            [self titleBtnClick:titleButton];
        }
        
        [self.titleButtons addObject:titleButton];
    }
    
}

- (void)setupContentView {
    // 创建一个流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(KScreanWidth, KScreanHeight);
    
    // 设置水平滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                                          collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.scrollsToTop = NO;
    
    // 开启分页
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    
    // 展示cell
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 注册cell
    [collectionView registerClass:[UICollectionViewCell class]
       forCellWithReuseIdentifier:cellReuseIdentifier];
}


#pragma mark - target-action

- (void)searchBtnClicked:(UIBarButtonItem *)sender {
    
}

- (void)InfoBtnClicked:(UIBarButtonItem *)sender {
    
}

- (void)titleBtnClick:(UIButton *)sender {
    
    NSInteger i = sender.tag;
    
    if (sender == self.selectButton) {
        //NSLog(@"重复点击标题按钮");
    }
    
    [self selectedButton:sender];
    
    //滚动collectionView到相应视图
//    CGFloat offsetX = i * KScreanWidth;
//    self.collectionView.contentOffset = CGPointMake(offsetX, 0);
//    CGRect moveRect = CGRectMake(offsetX, 0, KScreanWidth, self.collectionView.frame.size.height);
//    [self.collectionView scrollRectToVisible:moveRect animated:YES];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:YES];
}

- (void)selectedButton:(UIButton *)sender {
    self.selectButton.selected = NO;
    sender.selected = YES;
    self.selectButton = sender;
    
    // 移动下划线的位置
    [UIView animateWithDuration:0.25 animations:^{
        
        CGPoint movePoint = CGPointMake(sender.center.x, self.lineView.center.y);
        self.lineView.center = movePoint;
    }];
    
}

#pragma mark - UICollectionViewDelegate

// 滚动完成的时候就会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获取角标
    NSInteger i = scrollView.contentOffset.x / KScreanWidth;
    
    // 获取选中标题
    UIButton *selButton = self.titleButtons[i];
    
    // 选中标题
    [self selectedButton:selButton];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 只要有新的cell出现,就把对应的子控制器的view添加到新的cell上
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier
                                                                           forIndexPath:indexPath];
    
    // 移除之前子控制器view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    // 取出对应的子控制器添加到对应cell上
    UIViewController *vc = self.childViewControllers[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, KScreanWidth, KScreanHeight);
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

@end
