//
//  JYCategoryViewModel.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "JYCategoryViewModel.h"
#import "MusicNetManager.h"
#import "MusicCategoryModel.h"
@implementation JYCategoryViewModel

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
    [MusicNetManager getTagName:_tagName pageId:_pageId completionHandler:^(MusicCategoryModel * model, NSError *error) {
        if (_pageId == 1) {
            [self.dataArr removeAllObjects];
        }
        self.maxPageId = model.maxPageId;
        [self.dataArr addObjectsFromArray:model.list];
        completionHandle(error);
    }];
}

-(NSInteger)rowNumber
{
    return self.dataArr.count;
}

-(MusicCateoryListModel *)modelForRow:(NSInteger)row
{
    return self.dataArr[row];
}

-(NSURL *)iamgeForRow:(NSInteger)row
{
    return [NSURL URLWithString:[self modelForRow:row].coverMiddle];
}

-(NSString *)playCounrForRow:(NSInteger)row
{
    return [NSString stringWithFormat:@"%ld",[self modelForRow:row].playsCounts];
}

-(NSString *)titleForRow:(NSInteger)row
{
    return [self modelForRow:row].title;
}

@end
