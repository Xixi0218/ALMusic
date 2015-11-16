//
//  DetailCell.h
//  BaseProject
//
//  Created by adam on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRImageView.h"
@interface DetailCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLb;
@property (nonatomic,strong) UILabel *introLb;
@property (nonatomic,strong) UILabel *playCountsLb;
@property (nonatomic,strong) UILabel *tracksLb;
@property (nonatomic,strong) TRImageView *iconView;

@end
