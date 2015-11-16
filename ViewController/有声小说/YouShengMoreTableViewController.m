//
//  YouShengMoreTableViewController.m
//  Music
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "YouShengMoreTableViewController.h"
#import "DetailCell.h"
#import "DetailViewModel.h"
#import "NSObject+Common.h"
#import "MusicDetailViewController.h"
@interface YouShengMoreTableViewController ()
@property (nonatomic,strong) DetailViewModel *detailVM;
@end

@implementation YouShengMoreTableViewController

-(DetailViewModel *)detailVM{
    if (!_detailVM) {
        _detailVM = [[DetailViewModel alloc]initWithTagName:_tagName];
    }
    return _detailVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[DetailCell class] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.detailVM refreshDataCompletionHandle:^(NSError *error) {
            if (error) {
                [self showErrorMsg:error.localizedDescription];
            }else{
                [self.tableView reloadData];
                //self.tableView.tableHeaderView = nil;
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
    
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.titleLb.text = [self.detailVM titleForRow:indexPath.row];
    cell.introLb.text = [self.detailVM introForRow:indexPath.row];
    cell.playCountsLb.text = @([self.detailVM playCountsForRow:indexPath.row]).stringValue;
    cell.tracksLb.text = @([self.detailVM tracksCountsForRow:indexPath.row]).stringValue;
    [cell.iconView.imageView setImageWithURL:[self.detailVM albumCoverForRow:indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailListModel * model = [self.detailVM modelForRow:indexPath.row];
    MusicDetailViewController * vc = [[MusicDetailViewController alloc] initWithAlbumId:model.albumId];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
