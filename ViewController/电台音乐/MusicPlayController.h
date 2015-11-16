//
//  MusicPlayController.h
//  Music
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicDetailModel.h"
#import "DOUAudioStreamer.h"

@interface MusicPlayController : UIViewController
+(MusicPlayController *)defaultsVC;
@property (nonatomic,strong)MusicDetailTracksListModel * model;
@property (nonatomic,strong)NSArray * songLists;

@end
