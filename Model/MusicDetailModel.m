//
//  MusicDetailModel.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MusicDetailModel.h"

@implementation MusicDetailModel

@end

@implementation MusicDetailTracksModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"list":[MusicDetailTracksListModel class]};
}
@end


@implementation MusicDetailAlbumModel

@end


@implementation MusicDetailTracksListModel
MJCodingImplementation
@end