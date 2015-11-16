//
//  JYCategoryViewModel.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseViewModel.h"
#import "MusicCategoryModel.h"
@interface JYCategoryViewModel : BaseViewModel
/** 数据量*/
@property (nonatomic,assign)NSInteger rowNumber;
/**  代表第几页*/
@property (nonatomic)NSInteger pageId;
/** 某行的图片*/
-(NSURL *)iamgeForRow:(NSInteger)row;
/** 某行的标题*/
-(NSString *)titleForRow:(NSInteger)row;
/** 某行的播放次数*/
-(NSString *)playCounrForRow:(NSInteger)row;
/** 某行对应的模型*/
-(MusicCateoryListModel *)modelForRow:(NSInteger)row;
/** 总共多少页*/
@property (nonatomic,assign)NSInteger maxPageId;
/** 发送网络请求所需的参数 */
@property (nonatomic,copy)NSString*tagName;



@end
