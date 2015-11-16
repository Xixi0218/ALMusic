//
//  MusicNetManager.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MusicNetManager.h"
#import "MusicModel.h"
#import "MusicCategoryModel.h"
#import "MusicDetailModel.h"
@implementation MusicNetManager
+(id)getMusicMainInterface:(NSDictionary*)params completionHandler:(void(^)(id model, NSError *error))complete
{
    NSString * path = @"http://mobile.ximalaya.com/mobile/discovery/v2/category/recommends?categoryId=2&contentType=album&device=iPhone&scale=2&version=4.3.20";
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([MusicModel mj_objectWithKeyValues:responseObj],error);
    }];
}

/** 请求获得各个分类的参数*/
+(id)getTagName:(NSString *)tagName pageId:(NSInteger)pageId completionHandler:(void(^)(id model, NSError *error))complete
{
    NSString * path = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=iPhone&pageId=%ld&pageSize=20&status=0",pageId];
    
    //[self percentPathWithPath:path params:nil];
    NSDictionary * params = @{@"tagName" : tagName};
    //NSLog(@"%@",path);
    return [self GET:path parameters:params completionHandler:^(id responseObj, NSError *error) {
        complete([MusicCategoryModel mj_objectWithKeyValues:responseObj],error);
    }];
}

+(id)getDetailAlbumId:(NSInteger)albumId pageId:(NSInteger)pageId completionHandler:(void (^)(id, NSError *))complete
{
    NSString * path = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%ld/true/%ld/20?device=iPhone",albumId,pageId];
    return [self GET:path parameters:nil completionHandler:^(MusicDetailModel * responseObj, NSError *error) {
        complete([MusicDetailModel mj_objectWithKeyValues:responseObj],error);
    }];
}

@end
