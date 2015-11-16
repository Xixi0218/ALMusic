//
//  CategoryViewModel.h
//  BaseProject
//
//  Created by adam on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "NovelNetManager.h"

@interface CategoryViewModel : BaseViewModel

@property (nonatomic) NSInteger rowNumber;


@property (nonatomic,assign)NSInteger maxPageId;

/** 主标签 */
-(NSString *)titleForSection:(NSInteger)section row:(NSInteger)row;
/** 长标签 */
-(NSString *)introForSection:(NSInteger)section row:(NSInteger)row;
/** 封面图片 */
-(NSURL *)ablumCoverForSection:(NSInteger)section row:(NSInteger)row;
/** 播放次数 */
-(NSString *)playCountsForSection:(NSInteger)section row:(NSInteger)row;
/** 集数 */
-(NSInteger)tracksCountsForSection:(NSInteger)section row:(NSInteger)row;
-(NovelCategoryListListModel *)modelForSection:(NSInteger)section row:(NSInteger)row;
/** 存放头部滚动栏 */
@property (nonatomic,strong) NSArray *indexPicArr;
@property (nonatomic,getter=isExistIndexPic) BOOL  existIndexPic;
/** 滚动展示栏的图片数量 */
@property (nonatomic) NSInteger indexPicNumber;
/** 滚动展示栏的图片 */
-(NSURL *)iconURLForRowInIndexPic:(NSInteger)row;

/** 头标签 */
-(NSString *)titleForSection:(NSInteger)section;

/** 更多分类的标签数 */
@property (nonatomic) NSInteger tagNumber;
/** 更多分类的标签数组 */
@property (nonatomic,strong) NSArray *tagArr;
/** 更多分类 */
-(NSString *)titleForIndex:(NSInteger)index;

/** 是否有滚动栏 */
@property (nonatomic,getter=isExist) BOOL exist;
/** 滚动展示栏的trackId*/
-(NSInteger)trackIdForRowInIndexPic:(NSInteger)row;
@end
