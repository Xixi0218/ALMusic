//
//  NovelNetManager.h
//  BaseProject
//
//  Created by adam on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "NovelModel.h"
#import "DetailModel.h"
@interface NovelNetManager : BaseNetManager

/** 获取分类内容 */
+(id)getCategoryContentsCompletionHandle:(void(^)(id model,NSError *error))completionHandle;

/** 请求获得各个分类的参数*/
+(id)getTagName:(NSString *)tagName pageId:(NSInteger)pageId completionHandler:(void(^)(id model, NSError *error))complete;

/**  请求获得详情页*/
+(id)getDetailAlbumId:(NSInteger)albumId pageId:(NSInteger)pageId completionHandler:(void(^)(id model, NSError *error))complete;

/** 头部滚动栏被点击发出请求*/
+(id)getHeadTrackId:(NSInteger)trackId completionHandler:(void(^)(id model,NSError * error))complete;
@end
