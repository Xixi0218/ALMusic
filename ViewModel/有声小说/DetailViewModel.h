//
//  DetailViewModel.h
//  BaseProject
//
//  Created by adam on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DetailModel.h"
#import "NovelNetManager.h"

@interface DetailViewModel : BaseViewModel

-(instancetype)initWithTagName:(NSString *)tagName;
-(DetailListModel *)modelForRow:(NSInteger)row;
/** 发送网络请求的参数 */
@property (nonatomic,strong) NSString *tagName;
/** 第几页 */
@property (nonatomic) NSInteger pageId;
@property (nonatomic) NSInteger rowNumber;
/** 最大页数 */
@property (nonatomic) NSInteger maxPageId;
/** 题目标签 */
-(NSString *)titleForRow:(NSInteger)row;
/** 长标签 */
-(NSString *)introForRow:(NSInteger)row;
/** 播放数 */
-(NSInteger)playCountsForRow:(NSInteger)row;
/** 集数 */
-(NSInteger)tracksCountsForRow:(NSInteger)row;
/** 封面图片 */
-(NSURL *)albumCoverForRow:(NSInteger)row;

/** 是否还有更多 */
@property (nonatomic,getter=isHasMore) BOOL hasMore;
@end
