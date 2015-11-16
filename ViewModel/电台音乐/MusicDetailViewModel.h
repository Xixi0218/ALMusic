//
//  MusicDetailViewModel.h
//  Music
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseViewModel.h"
#import "MusicDetailModel.h"
@interface MusicDetailViewModel : BaseViewModel

@property (nonatomic,strong)MusicDetailAlbumModel * model;

/** 哪个电台*/
@property (nonatomic)NSInteger albumId;
/** 最大页数*/
@property (nonatomic)NSInteger maxPageId;
/** 当前页数*/
@property (nonatomic)NSInteger pageId;
/** 返回的数据量*/
@property (nonatomic)NSInteger rowNumber;
/** 某行的图片*/
-(NSURL *)imageForRow:(NSInteger)row;
/** 某行的标题*/
-(NSString *)titleForRow:(NSInteger)row;
/** 某行的出处*/
-(NSString *)nickNameForRow:(NSInteger)row;
/** 某行的播放次数*/
-(NSString *)playTimesForRow:(NSInteger)row;
/** 某行的阅读次数*/
-(NSString *)commentForRow:(NSInteger)row;
/** 某行的喜欢人数*/
-(NSString *)likeForRow:(NSInteger)row;
/** 某行的播放时长*/
-(NSString *)durationForRow:(NSInteger)row;
/** 获取某行更新时间 */
- (NSString *)timeForRow:(NSInteger)row;
@end
