//
//  DetailViewModel.m
//  BaseProject
//
//  Created by adam on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DetailViewModel.h"

@implementation DetailViewModel

-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    _pageId = 1;
    [self getDataFromNetCompleteHandle:completionHandle];
}
-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    if (_maxPageId >= _pageId) {
        _pageId += 1;
        [self getDataFromNetCompleteHandle:completionHandle];
    }
}
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [NovelNetManager getTagName:_tagName pageId:_pageId completionHandler:^(DetailModel *model, NSError *error) {
        if (_pageId == 1) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:model.list];
        _maxPageId = model.maxPageId;
        completionHandle(error);
    }];
}
-(NSInteger)rowNumber{
    return self.dataArr.count;
}

-(DetailListModel *)modelForRow:(NSInteger)row{
    return self.dataArr[row];
}

/** 题目标签 */
-(NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
/** 长标签 */
-(NSString *)introForRow:(NSInteger)row{
    return [self modelForRow:row].intro;
}
/** 播放数 */
-(NSInteger)playCountsForRow:(NSInteger)row{
    NSInteger count = [self modelForRow:row].playsCounts;
    if (count < 10000) {
        return [self modelForRow:row].playsCounts;
    }else{
        return ([NSString stringWithFormat:@"%ld万",[self modelForRow:row].playsCounts]).integerValue;
    }
    
}
/** 集数 */
-(NSInteger)tracksCountsForRow:(NSInteger)row{
    return ([NSString stringWithFormat:@"%ld集",[self modelForRow:row].tracks]).integerValue;
}
/** 封面图片 */
-(NSURL *)albumCoverForRow:(NSInteger)row{
    return [NSURL  URLWithString:[self modelForRow:row].albumCoverUrl290];
}

/** 是否还有更多 */
-(BOOL)isHasMore{
    return _maxPageId > _pageId;
}

-(instancetype)initWithTagName:(NSString *)tagName{
    if (self = [super init]) {
        _tagName = tagName;
    }
    return self;
}

@end
