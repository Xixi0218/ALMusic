//
//  headDetailModel.h
//  Music
//
//  Created by apple on 15/11/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@class HeadDetailDataModel;
@interface headDetailModel : BaseModel

@property (nonatomic, strong) NSArray<HeadDetailDataModel *> *data;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *albumTitle;

@property (nonatomic, assign) NSInteger ret;

@end
@interface HeadDetailDataModel : NSObject

@property (nonatomic, assign) NSInteger trackId;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, copy) NSString *downloadUrl;

@property (nonatomic, copy) NSString *playPathAacv224;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, copy) NSString *playUrl64;

@property (nonatomic, copy) NSString *playPathAacv164;

@property (nonatomic, copy) NSString *playUrl32;

@end

