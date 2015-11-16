//
//  TopCell.h
//  BaseProject
//
//  Created by adam on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRImageView.h"

@interface TopCell : UITableViewCell
/** 左侧图片 */
@property (nonatomic,strong) TRImageView *iconIV;
/** 题目标签 */
@property (nonatomic,strong) UILabel *titleLb;
/** 长题目标签 */
@property (nonatomic,strong) UILabel *longTitleLb;
@property (nonatomic,strong) UILabel *playCountsLb;
@property (nonatomic,strong) UILabel *tracksLb;
@property (nonatomic,getter=isHasLabel) BOOL hasLabel;
@property (nonatomic) NSInteger row;
@end
