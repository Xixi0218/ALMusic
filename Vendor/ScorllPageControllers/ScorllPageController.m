//
//  ScorllPageController.m
//  Music
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ScorllPageController.h"

@interface ScorllPageController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic,strong)NSArray * controllers;

@end

@implementation ScorllPageController

-(instancetype)initWithImages:(NSArray *)images
{
    NSMutableArray * array = [NSMutableArray new];
    for (int i = 0; i<images.count; i++) {
        UIButton * btn = [UIButton buttonWithType:0];
        [btn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:images[i]] placeholderImage:[UIImage imageNamed:@""]];
        UIViewController * vc = [UIViewController new];
        vc.view = btn;
        btn.tag = 1000+i;
        [array addObject:vc];
        [btn bk_addEventHandler:^(UIButton * sender) {
            [self.delegate scorllPageController:self didSelected:sender.tag - 1000];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    self.controllers = [array copy];
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if (_controllers == nil) {
        return;
    }
    // Do any additional setup after loading the view.
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageVC.dataSource = self;
    _pageVC.delegate = self;
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    
    [_pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [_pageVC setViewControllers:@[_controllers.firstObject] direction:0 animated:YES completion:nil];
    
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = _controllers.count;
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(0);
    }];
    
    
    //开启定时器让他自动滚
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:2.0 block:^(NSTimer *timer) {
        UIViewController *vc=_pageVC.viewControllers.firstObject;
        NSInteger index=[_controllers indexOfObject:vc];
        UIViewController *nextVC = nil;
        if (index == _controllers.count -1) {
            nextVC = _controllers.firstObject;
        }else{
            nextVC = _controllers[index +1];
        }
        __block ScorllPageController *vc1= self;
        [_pageVC setViewControllers:@[nextVC] direction:0 animated:YES completion:^(BOOL finished) {
            //DDLogVerbose(@"%@", [NSThread currentThread]);
            [vc1 configPageControl];
        }];
    } repeats:YES];
    
}

-(void)configPageControl//操作圆点
{
    NSInteger index=[_controllers indexOfObject:_pageVC.viewControllers.firstObject];
    _pageControl.currentPage = index;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed && finished) {
        [self configPageControl];
    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index=[_controllers indexOfObject:viewController];
    if (index == 0) {
        return _controllers.lastObject;
    }
    return _controllers[index -1];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index=[_controllers indexOfObject:viewController];
    if (index == _controllers.count -1) {
        return _controllers.firstObject;
    }
    return _controllers[index +1];
}

@end
