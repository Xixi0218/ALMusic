//
//  MusicCategoryModel.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MusicCategoryModel.h"

@implementation MusicCategoryModel


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [MusicCateoryListModel class]};
}
@end
@implementation MusicCateoryListModel

@end


