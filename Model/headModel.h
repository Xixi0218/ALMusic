//
//  headModel.h
//  Music
//
//  Created by apple on 15/11/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@class HeadUserinfoModel;
@interface headModel : BaseModel

@property (nonatomic, copy) NSString *coverSmall;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, assign) NSInteger processState;

@property (nonatomic, copy) NSString *coverMiddle;

@property (nonatomic, copy) NSString *richIntro;

@property (nonatomic, assign) BOOL isPublic;

@property (nonatomic, copy) NSString *refSmallLogo;

@property (nonatomic, assign) NSInteger comments;

@property (nonatomic, copy) NSString *playUrl32;

@property (nonatomic, assign) NSInteger userSource;

@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, assign) NSInteger playtimes;

@property (nonatomic, copy) NSString *playPathAacv164;

@property (nonatomic, copy) NSString *albumTitle;

@property (nonatomic, copy) NSString *playPathAacv224;

@property (nonatomic, assign) NSInteger shares;

@property (nonatomic, copy) NSString *playUrl64;

@property (nonatomic, assign) NSInteger downloadSize;

@property (nonatomic, assign) BOOL isRelay;

@property (nonatomic, copy) NSString *coverLarge;

@property (nonatomic, assign) NSInteger trackId;

@property (nonatomic, assign) NSInteger likes;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, assign) long long createdAt;

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSString *downloadAacUrl;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSArray<NSString *> *images;

@property (nonatomic, copy) NSString *lyric;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, assign) NSInteger activityId;

@property (nonatomic, strong) NSArray *trackBlocks;

@property (nonatomic, assign) NSInteger albumId;

@property (nonatomic, assign) BOOL isLike;

@property (nonatomic, copy) NSString *albumImage;

@property (nonatomic, strong) HeadUserinfoModel *userInfo;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger downloadAacSize;

@property (nonatomic, copy) NSString *downloadUrl;

@end
@interface HeadUserinfoModel : NSObject

@property (nonatomic, copy) NSString *smallLogo;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, assign) NSInteger tracks;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) BOOL isVerified;

@property (nonatomic, assign) NSInteger albums;

@property (nonatomic, assign) NSInteger followers;

@property (nonatomic, assign) BOOL isFollowed;

@property (nonatomic, assign) NSInteger followings;

@end

