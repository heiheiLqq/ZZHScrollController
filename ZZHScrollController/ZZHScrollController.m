//
//  ZZHScrollController.m
//  ZZHScrollController
//
//  Created by zzh on 2017/2/9.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "ZZHScrollController.h"
#import "ZZHTableViewController.h"
#import "ZZHLabel.h"
@interface ZZHScrollController ()
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@end

@implementation ZZHScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self setUpChildVc];
    //添加标题选择按钮
    [self setUpTitle];
    //选择第一个
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}
- (void)setUpTitle{

    // 定义临时变量
    CGFloat labelW = 100;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScrollView.frame.size.height;
    NSInteger count = self.childViewControllers.count;
    // 添加label
    for (NSInteger i = 0; i<count; i++) {
        ZZHLabel *label = [[ZZHLabel alloc] init];
        label.text = [self.childViewControllers[i] title];
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.tag = i;
        [self.titleScrollView addSubview:label];
        //label添加点击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:tap];
    }
    // 设置contentSize
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(count * [UIScreen mainScreen].bounds.size.width, 0);
}

- (void)tap:(UITapGestureRecognizer *)tap{
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    // 让底部的内容scrollView滚动到对应位置
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

- (void)setUpChildVc{

    ZZHTableViewController *social0 = [[ZZHTableViewController alloc] init];
    social0.title = @"头1";
    [self addChildViewController:social0];

    ZZHTableViewController *social1 = [[ZZHTableViewController alloc] init];
    social1.title = @"头2";
    [self addChildViewController:social1];
    
    ZZHTableViewController *social2 = [[ZZHTableViewController alloc] init];
    social2.title = @"头3";
    [self addChildViewController:social2];
    
    ZZHTableViewController *social3 = [[ZZHTableViewController alloc] init];
    social3.title = @"头4";
    [self addChildViewController:social3];
    
    ZZHTableViewController *social4 = [[ZZHTableViewController alloc] init];
    social4.title = @"头5";
    [self addChildViewController:social4];
    
    ZZHTableViewController *social5 = [[ZZHTableViewController alloc] init];
    social5.title = @"头6";
    [self addChildViewController:social5];
    
    ZZHTableViewController *social6 = [[ZZHTableViewController alloc] init];
    social6.title = @"头7";
    [self addChildViewController:social6];
    
}
#pragma mark - <UIScrollViewDelegate>
/**
 * scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    // 让对应的顶部标题居中显示
    ZZHLabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    // 让其他label回到最初的状态
    for (ZZHLabel *otherLabel in self.titleScrollView.subviews) {
        if (otherLabel != label) otherLabel.scale = 0.0;
    }
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    // 如果当前位置的位置已经显示过了，就直接返回
    if ([willShowVc isViewLoaded]) return;
    // 添加控制器的view到contentScrollView中;
    willShowVc.view.frame = CGRectMake(offsetX, -64, width, height);
    [scrollView addSubview:willShowVc.view];
    
}

/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
/**
 * 只要scrollView在滚动，就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > self.titleScrollView.subviews.count - 1) return;
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    ZZHLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    ZZHLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count) ? nil : self.titleScrollView.subviews[rightIndex];
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    // 设置label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}
@end
