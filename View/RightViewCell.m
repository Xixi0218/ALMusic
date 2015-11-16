//
//  RightViewCell.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RightViewCell.h"

@implementation RightViewCell

-(void)setArray:(NSArray *)array
{
    _array = array;
    UIView * lastView = nil;
    for (int i = 0 ; i<_array.count; i++) {
        MusicCategoryContentListListModel * model = _array[i];
        UIView * view = [UIView new];
        [self.contentView addSubview:view];
        UIButton * btn = [UIButton buttonWithType:0];
        btn.tag = i;
        [btn bk_addEventHandler:^(UIButton * sender) {
            if ([self.delegate respondsToSelector:@selector(rightViewCell:didSelectedModel:)]) {
                [self.delegate rightViewCell:self didSelectedModel:model];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.coverMiddle] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        
        UILabel * label = [UILabel new];
        label.text = model.title;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldFlatFontOfSize:12];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
        }];
        
        [self.contentView addSubview:view];
        if (lastView == nil) {
            lastView = self;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_left).mas_equalTo(10);
                make.top.bottom.mas_equalTo(self).mas_equalTo(0);
            }];
            lastView = view;
        }
        else
        {
            if (i == _array.count-1) {
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(lastView.mas_right).mas_equalTo(10);
                    make.top.bottom.right.mas_equalTo(self).mas_equalTo(0);
                    make.width.mas_equalTo(lastView);
                    
                }];
            }
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_right).mas_equalTo(10);
                make.top.bottom.mas_equalTo(self).mas_equalTo(0);
                make.width.mas_equalTo(lastView);
            }];
            lastView = view;
        }
        
    }

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //[self array];
    }
    return self;
}

@end
