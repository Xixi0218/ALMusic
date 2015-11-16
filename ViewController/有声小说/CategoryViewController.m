//
//  CategoryViewController.m
//  BaseProject
//
//  Created by adam on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryViewModel.h"
#import "NovelModel.h"
#import "TopCell.h"
#import "TRImageView.h"
#import "iCarousel.h"
#import "Factory.h"
#import "DetailCell.h"
#import "DetailViewModel.h"
#import "NSObject+Common.h"
#import "MusicDetailViewController.h"
#import "YouShengMoreTableViewController.h"
#import "PlayView.h"
#import "MusicPlayController.h" 
#import "MusicDetailModel.h"
#import "coverView.h"
#import "MBProgressHUD+MJ.h"
#import "NovelNetManager.h"
#import "headModel.h"
@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate,iCarouselDataSource,iCarouselDelegate,PlayViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) CategoryViewModel *categoryVM;
@property (nonatomic,strong) DetailViewModel *detailVM;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong)MusicDetailTracksListModel * model;
@end

@implementation CategoryViewController

{
//添加成员变量 因为不需要懒加载，所以不需要是属性
    iCarousel *_ic;
    UIPageControl *_pageControl;
    UILabel *_titleLb;
    NSTimer *_timer;
}
//头部滚动视图
-(UIView *)headView{
    [_timer invalidate];
//如果当前没有滚动视图，返回nil
    if (!self.categoryVM.isExistIndexPic)return nil;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, kWindowW/2)];
    
//添加滚动栏
    _ic  = [iCarousel new];
    [headView addSubview:_ic];
    [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = self.categoryVM.indexPicNumber;
    [_ic addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_ic.mas_centerX);
        make.bottom.mas_equalTo(10);
        make.width.mas_lessThanOrEqualTo(80);
        make.width.mas_greaterThanOrEqualTo(20);
    }];
    _ic.delegate = self;
    _ic.dataSource = self;
    _ic.pagingEnabled = YES;
    _ic.scrollSpeed = 1;
//如果只有一张图，则不显示圆点
    _pageControl.hidesForSinglePage = YES;
//如果只有一张图片，则不滚动
    _ic.scrollEnabled = self.categoryVM.indexPicNumber !=1;
    
    
    if (self.categoryVM.indexPicNumber > 1) {
        _timer = [NSTimer bk_scheduledTimerWithTimeInterval:3 block:^(NSTimer *timer) {
            [_ic scrollToItemAtIndex:_ic.currentItemIndex+1 animated:YES];
        } repeats:YES];
    }
    _pageControl.userInteractionEnabled = NO;
    return headView;
}
#pragma mark - iCarousel Delegate
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.categoryVM.indexPicNumber;
}
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW/2)];
        UIImageView *imageView = [UIImageView new];
        [view addSubview:imageView];
        imageView.tag = 100;
        imageView.contentMode = 2;
        view.clipsToBounds = YES;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    UIImageView *imageView = (UIImageView *)[view viewWithTag:100];
    [imageView setImageWithURL:[self.categoryVM iconURLForRowInIndexPic:index]];
    return view;
}
//循环滚动
-(CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _pageControl.currentPage = carousel.currentItemIndex;
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    /*
     DetailListModel * model = [self.detailVM modelForRow:indexPath.row];
     MusicDetailViewController * vc = [[MusicDetailViewController alloc] initWithAlbumId:model.albumId];
     [self.navigationController pushViewController:vc animated:YES];
     */
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NovelNetManager getHeadTrackId:[self.categoryVM trackIdForRowInIndexPic:index] completionHandler:^(headModel * model, NSError *error) {
            MusicDetailViewController * vc = [[MusicDetailViewController alloc] initWithAlbumId:model.albumId];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    });
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        if ([self.tagName isEqualToString:@"推荐"]) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            _tableView.separatorInset = UIEdgeInsetsMake(0, 76, 0, 0);
        }
        else
        {
            _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            _tableView.separatorInset = UIEdgeInsetsMake(0, 76, 0, 0);
        }
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[TopCell class] forCellReuseIdentifier:@"TopCell"];
        [_tableView registerClass:[DetailCell class] forCellReuseIdentifier:@"DetailCell"];
        _tableView.tableFooterView = [UIView new];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    return _tableView;
}

-(CategoryViewModel *)categoryVM{
    if (!_categoryVM) {
        _categoryVM = [[CategoryViewModel alloc]init];
    }
    return _categoryVM;
}
-(DetailViewModel *)detailVM{
    if (!_detailVM) {
        _detailVM = [[DetailViewModel alloc]initWithTagName:_tagName];
    }
    return _detailVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.tagName isEqualToString:@"推荐"]) {
        self.view.backgroundColor = [UIColor clearColor];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.categoryVM refreshDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                   [self.tableView reloadData];
                    self.tableView.tableHeaderView = [self headView];
                    [self.tableView.mj_footer resetNoMoreData];
                }
                [self.tableView.mj_header endRefreshing];
            }];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.categoryVM getMoreDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                    [self.tableView reloadData];
                   [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }];
        }];
    }
    else
    {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.detailVM refreshDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                    [self.tableView reloadData];
                    self.tableView.tableHeaderView = nil;
                    [self.tableView.mj_header endRefreshing];
                }
            }];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.detailVM getMoreDataCompletionHandle:^(NSError *error) {
                if (error) {
                    [self showErrorMsg:error.localizedDescription];
                }else{
                    [self.tableView reloadData];
                    if ([self.detailVM isHasMore]) {
                        [self.tableView.mj_footer endRefreshing];
                    }else{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                
            }];
        }];
    }
    [self.tableView.mj_header beginRefreshing];
    
    /** 播放器*/
    UIWindow * window = [UIApplication sharedApplication].windows.firstObject;
    
    coverView * coverView1 = [coverView defaultView];
    [window addSubview:coverView1];
    [coverView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    PlayView * view = [PlayView sharedInstance];
    [coverView1 addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    view.delegate = self;
    
    coverView1.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePlayer:) name:@"ChangePlayer" object:nil];
}
/** 接受通知*/
-(void)changePlayer:(NSNotification *)notification
{
    PlayView * view = [PlayView sharedInstance];
    view.player = notification.userInfo[@"player"];
    NSNumber * status = notification.userInfo[@"status"];
    if (status.integerValue == 1) {
        view.playBtn.selected = YES;
    }else
    {
        view.playBtn.selected = NO;
    }
    self.model = notification.userInfo[@"model"];
    view.titleLB.text = self.model.title;
    view.descLB.text = self.model.nickname;
}

#pragma makr -- PlayViewDelegate
-(BOOL)playViewDidClick:(PlayView *)PlayView
{
    if (!PlayView.player) {
        [MBProgressHUD showError:@"请先选择" toView:self.view];
        return NO;
    }
    MusicPlayController * vc = [MusicPlayController defaultsVC];
    [self.navigationController pushViewController:vc animated:YES];
    return YES;
}
-(BOOL)playStatus:(PlayView *)playView
{
    if (!playView.player) {
        [MBProgressHUD showError:@"请先选择" toView:self.view];
        return NO;
    }
    return YES;
}
#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.tagName isEqualToString:@"推荐"]) {
        return self.categoryVM.rowNumber;
    }else{
        return 1;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (![self.tagName isEqualToString:@"推荐"]) {
        return self.detailVM.rowNumber;
    }else{
        return 3;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.tagName isEqualToString:@"推荐"]) {
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
        cell.titleLb.text = [self.detailVM titleForRow:indexPath.row];
        cell.introLb.text = [self.detailVM introForRow:indexPath.row];
        cell.playCountsLb.text = @([self.detailVM playCountsForRow:indexPath.row]).stringValue;
        cell.tracksLb.text = @([self.detailVM tracksCountsForRow:indexPath.row]).stringValue;
        [cell.iconView.imageView setImageWithURL:[self.detailVM albumCoverForRow:indexPath.row]];
        return cell;
    }
    
    TopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopCell"];
    cell.titleLb.text = [self.categoryVM titleForSection:indexPath.section row:indexPath.row];
    cell.longTitleLb.text = [self.categoryVM introForSection:indexPath.section row:indexPath.row];
    [cell.iconIV.imageView setImageWithURL:[self.categoryVM ablumCoverForSection:indexPath.section row:indexPath.row]];
    cell.playCountsLb.text = [self.categoryVM playCountsForSection:indexPath.section row:indexPath.row];
    cell.tracksLb.text = @([self.categoryVM tracksCountsForSection:indexPath.section row:indexPath.row]).stringValue;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (![self.categoryVM isExistIndexPic]) {
        return 0;
    }else{
        return 35;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.tagName isEqualToString:@"推荐"]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_np_play"]];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        UILabel *label = [UILabel new];
        label.text = [self.categoryVM titleForSection:section];
        label.font = [UIFont systemFontOfSize:12];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(50, 25));
        }];
        UIButton *button = [UIButton buttonWithType:0];
        [button setBackgroundImage:[UIImage imageNamed:@"findsection_more_h"] forState:UIControlStateNormal];
        button.tag = section;
        [button setBackgroundImage:[UIImage imageNamed:@"findsection_more_n"] forState:UIControlStateHighlighted];
        [button bk_addEventHandler:^(UIButton * sender) {
            /** 推出更多的请求*/
            YouShengMoreTableViewController * vc = [YouShengMoreTableViewController new];
            vc.tagName = [self.categoryVM titleForSection:section];
            if ([[self.categoryVM titleForSection:section] isEqualToString:@"最火"]) {
                vc.tagName = @"";
            }
            [self.navigationController pushViewController:vc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(35, 35));
        }];
        return view;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self.tagName isEqualToString:@"推荐"]) {
        return 5;
    }else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.tagName isEqualToString:@"推荐"])
    {
        NovelCategoryListListModel * model = [self.categoryVM modelForSection:indexPath.section row:indexPath.row];
        MusicDetailViewController * vc = [[MusicDetailViewController alloc] initWithAlbumId:model.albumId];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        DetailListModel * model = [self.detailVM modelForRow:indexPath.row];
        MusicDetailViewController * vc = [[MusicDetailViewController alloc] initWithAlbumId:model.albumId];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
