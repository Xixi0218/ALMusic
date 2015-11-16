//
//  RightMenuViewController.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RightMenuViewController.h"
#import "RightViewModel.h"
#import "RightViewCell.h"
#import "MusicDetailViewController.h"
@interface RightMenuViewController ()<RightViewCellDelegate>

@property (nonatomic,strong)RightViewModel * rightVM;

@end

@implementation RightMenuViewController


+ (RightMenuViewController *)defaultVC{
    static RightMenuViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [RightMenuViewController new];
    });
    return vc;
}


-(RightViewModel *)rightVM
{
    if (_rightVM == nil) {
        _rightVM = [[RightViewModel alloc] init];
    }
    return _rightVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.rightVM refreshDataCompletionHandle:^(NSError *error) {
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    [self.tableView registerClass:[RightViewCell class] forCellReuseIdentifier:@"SecondCell"];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView.mj_header beginRefreshing];
    
    UIView * view = [UIView new];
    view.frame=CGRectMake(0, 0, 0, 64);
    self.tableView.tableFooterView = view;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rightVM.sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

kRemoveCellSeparator
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FirstCell"];
            
        }
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = [self.rightVM titleForSection:indexPath.section];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        RightViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell" forIndexPath:indexPath];
        cell.array = [self.rightVM arrayForSection:indexPath.section];
        cell.delegate = self;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 85;
    }
    else
    {
        return 20;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)rightViewCell:(RightViewCell *)rightViewCell didSelectedModel:(MusicCategoryContentListListModel *)model
{
    MusicDetailViewController * vc = [[MusicDetailViewController alloc] initWithAlbumId:model.albumId];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
