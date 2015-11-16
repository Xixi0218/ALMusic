//
//  PlayView.h
//  Music
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOUAudioStreamer.h"
@class PlayView;
@protocol PlayViewDelegate <NSObject>

-(BOOL)playViewDidClick:(PlayView*)PlayView;
-(BOOL)playStatus:(PlayView*)playView;

@end

@interface PlayView : UIView

+ (PlayView *)sharedInstance;

@property (nonatomic,strong)UIButton * playBtn;
@property (nonatomic,strong)DOUAudioStreamer * player;
@property (nonatomic,weak)id<PlayViewDelegate> delegate;
@property (nonatomic,strong)UILabel * titleLB;
@property (nonatomic,strong)UILabel * descLB;
@end
