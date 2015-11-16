//
//  NovelNetManager.m
//  BaseProject
//
//  Created by adam on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NovelNetManager.h"
#import "headModel.h"
#import "headDetailModel.h"
@implementation NovelNetManager

#define kNovelPath      @"mobile.ximalaya.com/mobile/discovery/v1/category/album"
#
+(id)getCategoryContentsCompletionHandle:(void(^)(id model,NSError *error))completionHandle{
    NSString *path = @"http://mobile.ximalaya.com/mobile/discovery/v2/category/recommends?categoryId=3&contentType=album&device=iPhone&scale=2&version=4.3.20";
    
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([NovelModel mj_objectWithKeyValues:responseObj],error);
    }];
}

/** 请求获得各个分类的参数*/
+(id)getTagName:(NSString *)tagName pageId:(NSInteger)pageId completionHandler:(void(^)(id model, NSError *error))complete
{
    //http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=3&device=iPhone&pageId=1&pageSize=20&position=0&status=0&tagName=历史军事
    NSString * path = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=3&device=iPhone&pageId=%ld&pageSize=20&status=0",pageId];
    NSDictionary * params = @{@"tagName" : tagName};
    //path = [self percentPathWithPath:path params:nil];
    
    //NSLog(@"%@",path);
    return [self GET:path parameters:params completionHandler:^(DetailModel *responseObj, NSError *error) {
        complete([DetailModel mj_objectWithKeyValues:responseObj],error);
    }];
}

+(id)getDetailAlbumId:(NSInteger)albumId pageId:(NSInteger)pageId completionHandler:(void (^)(id, NSError *))complete
{
    NSString * path = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/%ld/20?device=iPhone",albumId,pageId];
    return [self GET:path parameters:nil completionHandler:^(DetailModel * responseObj, NSError *error) {
        complete([DetailModel mj_objectWithKeyValues:responseObj],error);
    }];
}


+(id)getHeadTrackId:(NSInteger)trackId completionHandler:(void(^)(id model,NSError * error))complete
{
    NSString * path = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=iPhone&trackId=%ld",trackId];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([headModel mj_objectWithKeyValues:responseObj],error);
    }];
    
}



@end
