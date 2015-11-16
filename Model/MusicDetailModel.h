//
//  MusicDetailModel.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"
@class MusicDetailTracksModel,MusicDetailAlbumModel;
@interface MusicDetailModel : BaseModel
@property (nonatomic, strong) MusicDetailTracksModel *tracks;
@property (nonatomic, strong) MusicDetailAlbumModel *album;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, assign) NSInteger ret;
@end

@interface MusicDetailTracksModel : BaseModel
@property (nonatomic, assign) NSInteger maxPageId;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger pageId;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalCount;
@end

@interface MusicDetailAlbumModel : BaseModel

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, assign) NSInteger serialState;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *coverWebLarge;
@property (nonatomic, strong) NSString *coverMiddle;
@property (nonatomic, assign) BOOL hasNew;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, strong) NSString *avatarPath;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger updatedAt;
@property (nonatomic, strong) NSString *coverLarge;
@property (nonatomic, strong) NSString *coverSmall;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *coverOrigin;
@property (nonatomic, strong) NSString *introRich;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) BOOL isFavorite;
@property (nonatomic, assign) NSInteger serializeStatus;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger playTimes;

@end

@interface MusicDetailTracksListModel : BaseModel

@property (nonatomic, strong) NSString *downloadUrl;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger opType;
@property (nonatomic, assign) NSInteger processState;
@property (nonatomic, strong) NSString *coverMiddle;
@property (nonatomic, strong) NSString *refNickname;
@property (nonatomic, assign) BOOL isPublic;
@property (nonatomic, assign) NSInteger orderNum;
@property (nonatomic, strong) NSString *refSmallLogo;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, strong) NSString *playUrl32;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) NSInteger userSource;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString *playPathAacv224;
@property (nonatomic, assign) NSInteger playtimes;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *playPathAacv164;
@property (nonatomic, strong) NSString *smallLogo;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, strong) NSString *playUrl64;
@property (nonatomic, assign) NSInteger downloadSize;
@property (nonatomic, strong) NSString *coverLarge;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, strong) NSString *downloadAacUrl;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, strong) NSString *albumImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger refUid;
@property (nonatomic, assign) NSInteger downloadAacSize;
@property (nonatomic, strong) NSString *coverSmall;

@end

