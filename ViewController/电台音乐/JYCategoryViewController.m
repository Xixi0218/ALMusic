//
//  JYCategoryViewController.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "JYCategoryViewController.h"
#import "CategoryCell.h"
#import "JYCategoryViewModel.h"
#import "MusicDetailViewController.h"
@interface JYCategoryViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)JYCategoryViewModel * categoryVM;

@end

@implementation JYCategoryViewController

static NSString * const reuseIdentifier = @"Cell";


+ (JYCategoryViewController *)defaultVC{
    static JYCategoryViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"JYCategoryViewController"];
    });
    return vc;
}

-(JYCategoryViewModel *)categoryVM
{
    if (_categoryVM==nil) {
        _categoryVM = [[JYCategoryViewModel alloc] init];
    }
    return _categoryVM;
}

-(void)setTagName:(NSString *)tagName
{
    _tagName = tagName;
    self.categoryVM.tagName = tagName;
    [self.collectionView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.categoryVM refreshDataCompletionHandle:^(NSError *error) {
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
        }];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.categoryVM getMoreDataCompletionHandle:^(NSError *error) {
            if (self.categoryVM.maxPageId <= self.categoryVM.pageId) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            [self.collectionView reloadData];
            [self.collectionView.mj_footer endRefreshing];
        }];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.backgroundColor = [UIColor clearColor];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryVM.rowNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.imageView setImageWithURL:[self.categoryVM iamgeForRow:indexPath.row]];
    cell.titleLB.text = [self.categoryVM titleForRow:indexPath.row];
    cell.playCountLB.text = [NSString stringWithFormat:@"正在收听%@人",[self.categoryVM playCounrForRow:indexPath.row]];
    cell.playCountLB.textColor = [UIColor blackColor];
    cell.titleLB.textColor = [UIColor whiteColor];
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.view.bounds.size.width - 3*10)/2;
    CGFloat height = width*320/350;
    return CGSizeMake(width, height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCateoryListModel * model = [self.categoryVM modelForRow:indexPath.row];
    MusicDetailViewController * vc = [[MusicDetailViewController alloc] initWithAlbumId:model.albumId];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
