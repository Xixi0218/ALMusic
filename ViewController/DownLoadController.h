//
//  DownLoadController.h
//  Music
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicDetailModel.h"
@class DownLoadController;
@protocol DownLoadControllerDelegate <NSObject>

-(void)downLoadController:(DownLoadController *)downLoadController data:(MusicDetailTracksListModel *)model;

@end



@interface DownLoadController : UITableViewController
@property (nonatomic,strong)MusicDetailTracksListModel * model;
+(DownLoadController *)defaultsVC;

@property (nonatomic,weak)id<DownLoadControllerDelegate> delegate;
@end
