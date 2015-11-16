//
//  NovelModel.m
//  BaseProject
//
//  Created by adam on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NovelModel.h"

@implementation NovelModel

@end
@implementation NovelFocusimagesModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [NovelFocusImageListModel class]};
}

@end


@implementation NovelFocusImageListModel
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


@implementation NovelTagsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [NovelTagListModel class]};
}

@end


@implementation NovelTagListModel

@end


@implementation NovelCategoryModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [NovelCategoryListModel class]};
}

@end


@implementation NovelCategoryListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [NovelCategoryListListModel class]};
}

@end


@implementation NovelCategoryListListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"firstKResults" : [NovelCategoryListListFirstkresultsModel class]};
}

@end

@implementation NovelCategoryListListFirstkresultsModel
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


