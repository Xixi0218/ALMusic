//
//  MusicNetManager.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseNetManager.h"

@interface MusicNetManager : BaseNetManager
/** 请求获得主页面的参数*/
+(id)getMusicMainInterface:(NSDictionary*)params completionHandler:(void(^)(id model, NSError *error))complete;

/** 请求获得各个分类的参数*/
+(id)getTagName:(NSString *)tagName pageId:(NSInteger)pageId completionHandler:(void(^)(id model, NSError *error))complete;

/**  请求获得详情页*/
+(id)getDetailAlbumId:(NSInteger)albumId pageId:(NSInteger)pageId completionHandler:(void(^)(id model, NSError *error))complete;

@end
