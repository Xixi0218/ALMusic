//
//  MusicDetailViewModel.m
//  Music
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MusicDetailViewModel.h"
#import "MusicNetManager.h"
#import "MusicDetailModel.h"
@implementation MusicDetailViewModel

-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle
{
    _pageId = 1;
    [self getDataFromNetCompleteHandle:completionHandle];
}

-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle
{
    _pageId++;
    [self getDataFromNetCompleteHandle:completionHandle];
}

-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    [MusicNetManager getDetailAlbumId:_albumId pageId:_pageId completionHandler:^(MusicDetailModel * model, NSError *error) {
        if (_pageId == 1) {
            [self.dataArr removeAllObjects];
        }
        self.model = model.album;
        self.maxPageId = model.tracks.maxPageId;
        [self.dataArr addObjectsFromArray:model.tracks.list];
        completionHandle(error);
    }];
}

-(NSInteger)rowNumber
{
    return self.dataArr.count;
}

-(MusicDetailTracksListModel *)modelForRow:(NSInteger)row
{
    return self.dataArr[row];
}

/** 某行的图片*/
-(NSURL *)imageForRow:(NSInteger)row
{
    return [NSURL URLWithString:[self modelForRow:row].coverSmall];
}

/** 某行的标题*/
-(NSString *)titleForRow:(NSInteger)row
{
    return [self modelForRow:row].title;
}
/** 某行的出处*/
-(NSString *)nickNameForRow:(NSInteger)row
{
    return [self modelForRow:row].nickname;
}
/** 某行的播放次数*/
-(NSString *)playTimesForRow:(NSInteger)row
{
    NSInteger playtimes = [self modelForRow:row].playtimes;
    if (playtimes >=10000) {
        return [NSString stringWithFormat:@"%.1f",playtimes/10000.0];
    }else
    {
        return [NSString stringWithFormat:@"%ld",playtimes];
    }
}
/** 某行的阅读次数*/
-(NSString *)commentForRow:(NSInteger)row
{
    return [NSString stringWithFormat:@"%ld",[self modelForRow:row].comments];
}
/** 某行的喜欢人数*/
-(NSString *)likeForRow:(NSInteger)row
{
    return [NSString stringWithFormat:@"%ld",[self modelForRow:row].likes];
}
/** 某行的播放时长*/
-(NSString *)durationForRow:(NSInteger)row
{
    NSInteger duration = [self modelForRow:row].duration;
    NSInteger m = duration/60;
    NSInteger s = duration%60;
    return [NSString stringWithFormat:@"%02ld:%02ld",m,s];
}
- (NSString *)timeForRow:(NSInteger)row
{
    //    1447088462000 创建时间,距离1970年的秒数
    //获取当前秒数
    NSTimeInterval currentTime= [[NSDate date] timeIntervalSince1970];
    //算出当前时间和创建时间的间隔秒数
    NSTimeInterval delta = currentTime-[self modelForRow:row].createdAt/1000;
    //秒数转小时
    NSInteger hours = delta/3600;
    if (hours < 24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒数转天数
    NSInteger days = delta/3600/24;
    return [NSString stringWithFormat:@"%ld天前", days];
}

@end
