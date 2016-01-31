//
//  DownListCell.m
//  Music
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DownListCell.h"

@implementation DownListCell
- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(self.button.mas_left).mas_equalTo(-10);
            make.height.mas_equalTo(40);
        }];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}
- (UILabel *)sourceLb {
    if(_sourceLb == nil) {
        _sourceLb = [[UILabel alloc] init];
        [self.contentView addSubview:_sourceLb];
        [_sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(self.titleLb.mas_leftMargin);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_equalTo(4);
            make.rightMargin.mas_equalTo(self.titleLb.mas_rightMargin);
        }];
        _sourceLb.font=[UIFont systemFontOfSize:15];
        _sourceLb.textColor=[UIColor lightGrayColor];
    }
    return _sourceLb;
}
-(UIProgressView *)progress
{
    if (_progress==nil) {
        _progress = [[UIProgressView alloc] init];
        [self.contentView addSubview:_progress];
        [_progress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(self.titleLb.mas_leftMargin);
            make.top.mas_equalTo(self.sourceLb.mas_bottom).mas_equalTo(5);
            make.rightMargin.mas_equalTo(self.titleLb.mas_rightMargin);
        }];
    }
    return _progress;
}

-(UIButton *)button
{
    if (_button==nil) {
        _button = [[UIButton alloc] init];
        [_button setBackgroundColor:[UIColor blueColor]];
        [_button setTitle:@"开始下载" forState:UIControlStateNormal];
        [_button setTitle:@"暂停下载" forState:UIControlStateSelected];
        _button.titleLabel.font = [UIFont boldFlatFontOfSize:13];
        [self.contentView addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(60, 40));
        }];
        _button.selected = YES;
    }
    return _button;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.progress.hidden = NO;
    }
    return self;
}
@end
