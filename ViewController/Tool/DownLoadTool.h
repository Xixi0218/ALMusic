//
//  DownLoadTool.h
//  Music
//
//  Created by apple on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownLoadModel.h"
@interface DownLoadTool : NSObject
+(void)addUser:(DownLoadModel*)download;
+(NSArray*)allUser;
@end
