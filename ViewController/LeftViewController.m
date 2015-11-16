//
//  LeftViewController.m
//  Music
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LeftViewController.h"
#import "MainIntefaceViewController.h"
#import "MainYouShengViewController.h"
#import "PlayView.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong)NSArray * itemLists;
@end

@implementation LeftViewController

+(LeftViewController *)sharedVC
{
    static LeftViewController * vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [LeftViewController new];
    });
    return vc;
}

-(NSArray *)itemLists
{
    if (_itemLists==nil) {
        _itemLists = @[@"有声小说",@"电台音乐",@"我的收藏",@"历史记录"];
    }
    return _itemLists;
}

-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kWindowW/2, 176));
        }];
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //bg_loading
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_loading"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.tableView.hidden = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemLists.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.itemLists[indexPath.row];
    cell.textLabel.font = [UIFont boldFlatFontOfSize:20];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[MainYouShengViewController standardNavi] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
        {
            [self.sideMenuViewController setContentViewController:[MainIntefaceViewController defaultVC] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 2:
            break;
        default:
            break;
    }
}

@end
