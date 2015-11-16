//
//  MusicDetailHeadView.m
//  Music
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MusicDetailHeadView.h"
#import "TRImageView.h"
@implementation MusicDetailHeadView

-(instancetype)init
{
    if (self = [super init]) {
        NSAssert1(NO, @"%s 必须使用initWithAlbumModel", __func__);
    }
    return self;
}

-(instancetype)initWithAlbumModel:(MusicDetailAlbumModel *)album
{
    if (self = [super init]) {
        UIImageView * bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_transparent"]];
        
        [self addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        TRImageView * bigImage = [[TRImageView alloc] init];
        [bigImage.imageView setImageWithURL:[NSURL URLWithString:album.coverOrigin]];
        [self addSubview:bigImage];
        [bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(100,100));
        }];
        
        TRImageView * smallImage = [[TRImageView alloc] init];
        [smallImage.imageView setImageWithURL:[NSURL URLWithString:album.avatarPath]];
        [self addSubview:smallImage];
        [smallImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bigImage.mas_right).mas_equalTo(20);
            make.topMargin.mas_equalTo(bigImage.mas_topMargin);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        smallImage.layer.cornerRadius = 25/2;
        
        UILabel * titlelabel = [UILabel new];
        titlelabel.text = album.nickname;
        titlelabel.font = [UIFont boldFlatFontOfSize:15];
        titlelabel.textColor = [UIColor whiteColor];
        [self addSubview:titlelabel];
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(smallImage);
            make.left.mas_equalTo(smallImage.mas_right).mas_equalTo(10);
        }];
        
        UILabel * sourceLabel = [UILabel new];
        sourceLabel.text = album.introRich;
        sourceLabel.font = [UIFont boldFlatFontOfSize:12];
        sourceLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:sourceLabel];
        
        [sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(smallImage.mas_leftMargin);
            make.right.lessThanOrEqualTo(self.mas_right);
            make.centerY.mas_equalTo(bigImage);
        }];
        
        
        UILabel * typeLabel = [UILabel new];
        typeLabel.text = [NSString stringWithFormat:@"类型:%@",album.tags];
        typeLabel.font = [UIFont boldFlatFontOfSize:12];
        typeLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(smallImage.mas_leftMargin);
            make.bottomMargin.mas_equalTo(bigImage.mas_bottomMargin).mas_equalTo(0);
        }];
        
        
        
        UIButton * collectButton = [UIButton new];
        [collectButton setImage:[UIImage imageNamed:@"album_collected_non"] forState:UIControlStateNormal];
        [collectButton setImage:[UIImage imageNamed:@"album_collected"] forState:UIControlStateSelected];
        [self addSubview:collectButton];
        
        [collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        
        UIView * line = [UIView new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(collectButton.mas_top).mas_equalTo(5);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

@end
