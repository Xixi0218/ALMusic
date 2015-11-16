//
//  AppDelegate.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RESideMenu.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,getter=isOnLine) BOOL onLine; //网络状态
@property (nonatomic,strong) RESideMenu *sideMenu;
@end

