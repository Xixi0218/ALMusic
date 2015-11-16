//
//  MusicDetailViewController.m
//  Music
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "MusicDetailCell.h"
#import "MusicDetailViewModel.h"
#import "MusicDetailModel.h"
#import "MusicDetailHeadView.h"
#import "PlayView.h"
#import "MusicPlayController.h"

@interface MusicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)MusicDetailViewModel * detailVM;
@property (nonatomic,strong)UIView * coverView;
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation MusicDetailViewController


-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(MusicDetailViewModel *)detailVM
{
    if (_detailVM==nil) {
        _detailVM = [[MusicDetailViewModel alloc] init];
    }
    return _detailVM;
}

-(instancetype)initWithAlbumId:(NSInteger)albumId
{
    if (self = [super init]) {
        self.detailVM.albumId = albumId;
    }
    return self;
}

-(instancetype)init
{
    if (self = [super init]) {
        NSAssert1(NO, @"%s 必须使用initWithAlbumId", __func__);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView * view = [UIView new];
    view.frame=CGRectMake(0, 0, 0, 64);
    self.tableView.tableFooterView = view;
    
    [self.tableView registerClass:[MusicDetailCell class] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.detailVM refreshDataCompletionHandle:^(NSError *error) {
            MusicDetailHeadView * view = [[MusicDetailHeadView alloc] initWithAlbumModel:self.detailVM.model];
            view.frame = CGRectMake(0, 0, 300,170);
            self.tableView.tableHeaderView = view;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];

        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.detailVM getMoreDataCompletionHandle:^(NSError *error) {
            [self.tableView reloadData];
            if (self.detailVM.pageId >= self.detailVM.maxPageId) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
    
    [Factory addBackItemToVC:self];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailVM.rowNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_find_segsel"]];
    
    [cell.coverIV.imageView setImageWithURL:[self.detailVM imageForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    cell.titleLb.text = [self.detailVM titleForRow:indexPath.row];
    cell.sourceLb.text = [self.detailVM nickNameForRow:indexPath.row];
    cell.playCountLb.text = [self.detailVM playTimesForRow:indexPath.row];
    cell.favorCountLb.text = [self.detailVM likeForRow:indexPath.row];
    cell.commentCountLb.text = [self.detailVM commentForRow:indexPath.row];
    cell.durationLb.text = [self.detailVM durationForRow:indexPath.row];
    cell.timeLb.text = [self.detailVM timeForRow:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayController * vc = [MusicPlayController defaultsVC];
    vc.songLists = self.detailVM.dataArr;
    vc.model = self.detailVM.dataArr[indexPath.row];
    self.coverView.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
