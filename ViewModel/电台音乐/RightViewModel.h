//
//  RightViewModel.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseViewModel.h"

@interface RightViewModel : BaseViewModel
/** 多少组*/
-(NSInteger)sectionNum;
/** 每组的标题*/
-(NSString *)titleForSection:(NSInteger)section;
/** 每组要显示的内容*/
-(NSArray *)arrayForSection:(NSInteger)section;

@end
