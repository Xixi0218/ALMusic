//
//  TRAudioFile.h
//  Music
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"
@interface TRAudioFile : NSObject<DOUAudioFile>
@property(nonatomic,strong)NSURL *audioFileURL;
//-(NSURL *)audioFileURL;
@end
