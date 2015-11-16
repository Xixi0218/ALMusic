//
//  RightViewCell.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
@class RightViewCell;
@protocol RightViewCellDelegate <NSObject>

-(void)rightViewCell:(RightViewCell *)rightViewCell didSelectedModel:(MusicCategoryContentListListModel *)model;

@end

@interface RightViewCell : UITableViewCell

@property (nonatomic,strong)NSArray * array;

@property (nonatomic,weak)id<RightViewCellDelegate>  delegate;

@end
