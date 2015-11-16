//
//  PlayView.m
//  Music
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PlayView.h"
#import "MusicPlayController.h"
@implementation PlayView

+ (PlayView *)sharedInstance{
    static PlayView *p = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        p = [PlayView new];
    });
    return p;
}
- (id)init{
    if (self = [super init]) {
        self.playBtn.hidden = NO;
        self.titleLB.hidden = NO;
        self.descLB.hidden = NO;
        //        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (UIButton *)playBtn{
    if (!_playBtn) {
        UIButton * btn = [UIButton buttonWithType:0];
        [self addSubview:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"bg_transparent"] forState:UIControlStateNormal];
        self.backgroundColor =[UIColor clearColor];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        [btn bk_addEventHandler:^(id sender) {
            if ([self.delegate respondsToSelector:@selector(playViewDidClick:)]) {
                [self.delegate playViewDidClick:self];
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        _playBtn = [UIButton buttonWithType:0];
        
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateSelected];
        [self addSubview:_playBtn];
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.mas_equalTo(0);
            make.width.mas_equalTo(self.mas_height);
        }];
        [_playBtn bk_addEventHandler:^(UIButton *sender) {
            if ([self.delegate playStatus:self]) {
                //selected YES:在播放  NO：暂停
                if (sender.selected) {
                    [_player pause];
                }else{
                    [_player play];
                }
                sender.selected = !sender.selected;
            }
            
        } forControlEvents:UIControlEventTouchUpInside];

    }
    return _playBtn;
}

-(UILabel *)titleLB
{
    if (!_titleLB) {
        _titleLB = [UILabel new];
        _titleLB.font = [UIFont boldFlatFontOfSize:20];
        _titleLB.textColor = [UIColor whiteColor];
        _titleLB.text = @"";
        [self addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_playBtn.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(5);
        }];
    }
    return _titleLB;
}
-(UILabel *)descLB
{
    if (!_descLB) {
        _descLB = [UILabel new];
        _descLB.font = [UIFont boldFlatFontOfSize:15];
        _descLB.textColor = [UIColor whiteColor];
        _descLB.text = @"";
        [self addSubview:_descLB];
        [_descLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(self.titleLB.mas_leftMargin).mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-5);
        }];
    }
    return _descLB;
}
@end
