//
//  DownLoadModel.h
//  Music
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicDetailModel.h"
@interface DownLoadModel : NSObject

@property (nonatomic,strong)UIProgressView * progress;
@property (nonatomic,assign)CGFloat value;
@property (nonatomic,strong)MusicDetailTracksListModel * model;
@end
