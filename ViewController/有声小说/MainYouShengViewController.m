//
//  MainYouShengViewController.m
//  BaseProject
//
//  Created by adam on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MainYouShengViewController.h"
#import "CategoryViewController.h"
#import "CategoryViewModel.h"
#import "NovelNetManager.h"
#import "Factory.h"
#import "JYViewController.h"
@interface MainYouShengViewController ()
@property (nonatomic,strong) CategoryViewModel *categoryVM;
@end

@implementation MainYouShengViewController

+(UINavigationController *)standardNavi{
    static JYViewController *navi = nil;
        MainYouShengViewController *vc = [[MainYouShengViewController alloc]initWithViewControllerClasses:[self viewControllerClasses] andTheirTitles:[self itemNames]];
        vc.menuItemWidth = 80;
        vc.titleColorNormal = kRGBColor(100, 105, 105);
        vc.titleColorSelected = kRGBColor(228, 75, 49);
        vc.pageAnimatable = YES;
        vc.menuViewStyle = WMMenuViewStyleLine;
        vc.keys = [self vcKeys];
        vc.values = [self vcValues];
        navi = [[JYViewController defaultsNavi]initWithRootViewController:vc];
    
    return navi;
}

/** 题目数组 */
+(NSArray *)itemNames{
    return @[@"推荐",@"浪漫言情",@"恐怖悬疑",@"玄幻奇幻",@"历史军事",@"古言宫斗",@"探案推理",@"青春校园",@"都市生活",@"穿越架空",@"武侠仙侠",@"文学名著",@"官场商战",@"科幻游戏",@"诗词散文",@"社科经管",@"QQ阅读",@"读客图书",@"果麦文化",@"中信出版",@"博集天卷",@"速播专场",@"推理世界",@"正能量有声书"];
}
+(NSArray *)vcValues{
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i<[self itemNames].count; i++) {
        [arr addObject:[self itemNames][i]];
    }
    return arr;
}
+(NSArray *)vcKeys{
    NSMutableArray *arr = [NSMutableArray new];
    for (id obj in [self itemNames]) {
        [arr addObject:@"tagName"];
    }
    return arr;
}
+(NSArray *)viewControllerClasses{
    NSMutableArray *arr = [NSMutableArray new];
    for (id obj in [self itemNames]) {
        [arr addObject:[CategoryViewController class]];
    }
    return [arr copy];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"有声书";
    [Factory addMenuItemToVC:self];
    [Factory addDownLoadItemToVC:self];
    //[Factory addDownLoadItemToVC:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
