//
//  JYViewController.m
//  Music
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "JYViewController.h"

@interface JYViewController ()

@end

@implementation JYViewController

+(JYViewController *)defaultsNavi
{
    static JYViewController * navi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        navi = [JYViewController new];
    });
    return navi;
}

@end
