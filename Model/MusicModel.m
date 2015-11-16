//
//  MusicModel.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

@end
@implementation MusicFocusimageModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [ModelFocusImagesListModel class]};
}

@end


@implementation ModelFocusImagesListModel

@end


@implementation MusicTagModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [MusicTagListModel class]};
}

@end


@implementation MusicTagListModel

@end


@implementation MusicCategorycontentModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [MusicCategoryContentsListModel class]};
}

@end


@implementation MusicCategoryContentsListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [MusicCategoryContentListListModel class]};
}

@end


@implementation MusicCategoryContentListListModel



@end




