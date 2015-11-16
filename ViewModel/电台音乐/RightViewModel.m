//
//  RightViewModel.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RightViewModel.h"
#import "MusicNetManager.h"
#import "MusicModel.h"

@implementation RightViewModel

-(void)refreshDataCompletionHandle:(CompletionHandle)completionHandle
{
    [self getDataFromNetCompleteHandle:completionHandle];
}

-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    [MusicNetManager getMusicMainInterface:nil completionHandler:^(MusicModel * model, NSError *error) {
        NSMutableArray * array = [NSMutableArray arrayWithArray:model.categoryContents.list];
        [array removeObjectAtIndex:0];
        [self.dataArr addObjectsFromArray:array];
        completionHandle(error);
    }];
}
/** 多少组*/
-(NSInteger)sectionNum
{
    return self.dataArr.count;
}

-(MusicCategoryContentsListModel *)modelForSection:(NSInteger)section
{
    return self.dataArr[section];
}

-(NSString *)titleForSection:(NSInteger)section;
{
    return [self modelForSection:section].title;
}

-(NSArray *)arrayForSection:(NSInteger)section
{
    return [self modelForSection:section].list;
}

@end
