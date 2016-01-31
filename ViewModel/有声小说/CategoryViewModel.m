//
//  CategoryViewModel.m
//  BaseProject
//
//  Created by adam on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CategoryViewModel.h"

@implementation CategoryViewModel

-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    [self getDataFromNetCompleteHandle:completionHandle];
}
-(void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    [self getDataFromNetCompleteHandle:completionHandle];
}
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [NovelNetManager getCategoryContentsCompletionHandle:^(NovelModel *model, NSError *error) {
        NSMutableArray *muArray = [NSMutableArray arrayWithArray:model.categoryContents.list];
        if (model) {
            [muArray removeObjectAtIndex:0];
        }
        
        self.dataArr = [muArray copy];
        self.indexPicArr = model.focusImages.list;
        self.tagArr = model.tags.list;
        completionHandle(error);
    }];
}

-(NSInteger)rowNumber{
    //NSLog(@"%ld",self.dataArr.count);
    return self.dataArr.count;
}

-(NSInteger)indexPicNumber{
    return self.indexPicArr.count;
}

-(BOOL)isExistIndexPic{
    return self.indexPicArr !=nil && self.indexPicArr.count!=0;
}



-(NovelCategoryListListModel *)modelForSection:(NSInteger)section row:(NSInteger)row{
    NovelCategoryListModel * list = self.dataArr[section];
    NovelCategoryListListModel * data = list.list[row];
    return data;
}

-(NSString *)titleForSection:(NSInteger)section row:(NSInteger)row{
    return [self modelForSection:section row:row].title;
}
/** 长标签 */
-(NSString *)introForSection:(NSInteger)section row:(NSInteger)row{
    return [self modelForSection:section row:row].intro;
}
/** 封面图片 */
-(NSURL *)ablumCoverForSection:(NSInteger)section row:(NSInteger)row{
    return [NSURL URLWithString:[self modelForSection:section row:row].albumCoverUrl290];
}
/** 播放次数 */
-(NSString *)playCountsForSection:(NSInteger)section row:(NSInteger)row{
        NSInteger count = [self modelForSection:section row:row].playsCounts;
        if (count<10000) {
            return @([self modelForSection:section row:row].playsCounts).stringValue;
        }else{
            return [NSString stringWithFormat:@"%.1f万",count/10000.0];
        }
}
/** 集数 */
-(NSInteger)tracksCountsForSection:(NSInteger)section row:(NSInteger)row{
    return [self modelForSection:section row:row].tracksCounts;
}

-(NovelFocusImageListModel *)modelForIndexPic:(NSInteger)row{
    return self.indexPicArr[row];
}
/** 滚动展示栏的图片 */
-(NSURL *)iconURLForRowInIndexPic:(NSInteger)row{
    return [NSURL URLWithString:[self modelForIndexPic:row].pic];
}
/** 滚动展示栏的trackId*/
-(NSInteger)trackIdForRowInIndexPic:(NSInteger)row{
    return [self modelForIndexPic:row].trackId;
}
-(NovelCategoryListModel *)modelForSection:(NSInteger)section{
    return self.dataArr[section];
}

/** 头标签 */
-(NSString *)titleForSection:(NSInteger)section{
    return [self modelForSection:section].title;
}


-(NovelTagListModel *)modelForIndex:(NSInteger)index{
    return self.tagArr[index];
}
/** 更多分类的标签数 */
-(NSInteger)tagNumber{
    return self.tagArr.count;
}
/** 更多分类 */
-(NSString *)titleForIndex:(NSInteger)index{
    return [self modelForIndex:index].tname;
}


@end
