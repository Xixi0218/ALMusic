//
//  NovelModel.h
//  BaseProject
//
//  Created by adam on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class NovelFocusimagesModel,NovelFocusImageListModel,NovelTagsModel,NovelTagListModel,NovelCategoryModel,NovelCategoryListModel,NovelCategoryListListModel,NovelCategoryListListFirstkresultsModel;
@interface NovelModel : BaseModel

@property (nonatomic, strong) NovelTagsModel *tags;

@property (nonatomic, strong) NovelCategoryModel *categoryContents;

@property (nonatomic, assign) BOOL hasRecommendedZones;

@property (nonatomic, strong) NovelFocusimagesModel *focusImages;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger ret;

@end
@interface NovelFocusimagesModel : BaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<NovelFocusImageListModel *> *list;

@end

@interface NovelFocusImageListModel : BaseModel

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, copy) NSString *shortTitle;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) NSInteger trackId;

@property (nonatomic, assign) BOOL isShare;

@property (nonatomic, assign) BOOL is_External_url;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *longTitle;

@end

@interface NovelTagsModel : BaseModel

@property (nonatomic, assign) NSInteger maxPageId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray<NovelTagListModel *> *list;

@end

@interface NovelTagListModel : BaseModel

@property (nonatomic, copy) NSString *tname;

@property (nonatomic, assign) NSInteger category_id;

@end

@interface NovelCategoryModel : BaseModel

@property (nonatomic, assign) NSInteger ret;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<NovelCategoryListModel *> *list;

@end

@interface NovelCategoryListModel : BaseModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<NovelCategoryListListModel *> *list;

@property (nonatomic, assign) NSInteger moduleType;

@property (nonatomic, assign) BOOL hasMore;

@end

@interface NovelCategoryListListModel : BaseModel

@property (nonatomic, strong) NSArray<NovelCategoryListListFirstkresultsModel *>* firstKResults;
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,assign)NSInteger albumId;
@property (nonatomic,assign)NSInteger uid;
@property (nonatomic,copy)NSString*intro;
@property (nonatomic,copy)NSString*nickname;
@property (nonatomic,copy)NSString*albumCoverUrl290;
@property (nonatomic,copy)NSString*coverMiddle;
@property (nonatomic,strong)NSString*title;
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



@interface NovelCategoryListListFirstkresultsModel : BaseModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *contentType;

@end

