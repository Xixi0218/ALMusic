//
//  coverView.m
//  Music
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "coverView.h"

@implementation coverView
+(coverView *)defaultView
{
    static coverView * view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [coverView new];
    });
    return view;
}
@end
