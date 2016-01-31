//
//  DownListCell.h
//  Music
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownListCell : UITableViewCell
/** 题目标签 */
@property (nonatomic,strong) UILabel *titleLb;
/** 音乐来源标签 */
@property(nonatomic,strong) UILabel *sourceLb;
/** 每个模型对应的progress*/
@property (nonatomic,strong)UIProgressView * progress;
/** 暂停按钮*/
@property (nonatomic,strong)UIButton * button;

@end
