//
//  MusicModel.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"
@class MusicFocusimageModel,ModelFocusImagesListModel,MusicTagModel,MusicTagListModel,MusicCategorycontentModel,MusicCategoryContentsListModel,MusicCategoryContentListListModel;
@interface MusicModel : BaseModel
@property (nonatomic, strong) MusicTagModel *tags;

@property (nonatomic, strong) MusicCategorycontentModel *categoryContents;

@property (nonatomic, assign) BOOL hasRecommendedZones;

@property (nonatomic, strong) MusicFocusimageModel *focusImages;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger ret;
@end
@interface MusicFocusimageModel : NSObject

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<ModelFocusImagesListModel *> *list;

@end

@interface ModelFocusImagesListModel : NSObject

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, copy) NSString *shortTitle;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) NSInteger trackId;

@property (nonatomic, assign) BOOL isShare;

@property (nonatomic, assign) BOOL is_External_url;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *longTitle;

@end

@interface MusicTagModel : NSObject

@property (nonatomic, assign) NSInteger maxPageId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray<MusicTagListModel *> *list;

@end

@interface MusicTagListModel : NSObject

@property (nonatomic, copy) NSString *tname;

@property (nonatomic, assign) NSInteger category_id;

@end

@interface MusicCategorycontentModel : NSObject

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<MusicCategoryContentsListModel *> *list;

@end

@interface MusicCategoryContentsListModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<MusicCategoryContentListListModel *> *list;

@property (nonatomic, assign) NSInteger moduleType;

@property (nonatomic, assign) BOOL hasMore;

@property (nonatomic,strong)NSString * calcDimension;

@property (nonatomic,copy)NSString*contentType;

@property (nonatomic,copy)NSString*tagName;
@end

@interface MusicCategoryContentListListModel : NSObject

@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,assign)NSInteger albumId;
@property (nonatomic,assign)NSInteger uid;
@property (nonatomic,copy)NSString*intro;
@property (nonatomic,copy)NSString*nickname;
@property (nonatomic,copy)NSString*albumCoverUrl290;
@property (nonatomic,copy)NSString*coverMiddle;
@property (nonatomic,copy)NSString*title;
@property (nonatomic,copy)NSString*tags;
@property (nonatomic,assign)NSInteger tracks;
@property (nonatomic,assign)NSInteger tracksCounts;
@property (nonatomic,assign)NSInteger playsCounts;
@property (nonatomic,assign)NSInteger lastUptrackId;
@property (nonatomic,assign)NSInteger lastUptrackAt;
@property (nonatomic,assign)NSInteger isFinished;
@property (nonatomic,assign)NSInteger serialState;
@property (nonatomic,copy)NSString*lastUptrackTitle;

@end

