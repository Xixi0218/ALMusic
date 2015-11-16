//
//  MenuTableViewController.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MusicModel.h"
@interface MenuTableViewController ()
@property (nonatomic,strong)NSArray * allMenu;
@property (nonatomic,strong)NSIndexPath * indexpath;
@property (nonatomic,assign)NSInteger i;
@end

@implementation MenuTableViewController

-(NSArray *)allMenu
{
    if (_allMenu==nil) {
        NSDictionary * dict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"]];
        NSMutableArray * array = [NSMutableArray arrayWithArray:dict[@"list"]];
        
        _allMenu = [array copy];
        [self.tableView reloadData];
    }
    return _allMenu;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UITableViewCell *thisCell = [self.tableView cellForRowAtIndexPath:self.indexpath];
    [self.tableView selectRowAtIndexPath:self.indexpath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    thisCell.selectionStyle = UITableViewCellSelectionStyleGray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    UIView * view = [UIView new];
    view.frame=CGRectMake(0, 0, 0, 64);
    self.tableView.tableFooterView = view;
    
    self.indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allMenu.count;
}

kRemoveCellSeparator
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    NSDictionary * list = self.allMenu[indexPath.row];
    cell.textLabel.text = list[@"tname"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_loading"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexpath = indexPath;
    //将当前点击的cell传递给thisCell
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath: indexPath];
    if ([self.delegate respondsToSelector:@selector(tableViewController:didSelected:selectedTagName:)]) {
        [self.delegate tableViewController:self didSelected:indexPath.row selectedTagName:thisCell.textLabel.text];
    }

}
@end
