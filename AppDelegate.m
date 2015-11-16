//
//  AppDelegate.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "MainIntefaceViewController.h"
#import "MainYouShengViewController.h"
#import "LeftViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
//友盟统计中的
#define AppKey @"5632e65ae0f55a556a0013d9"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.sideMenu;
    [self configClobalUIStyle];
    [self.window makeKeyAndVisible];
    
    [UMSocialData setAppKey:AppKey];
    //设置微信AppId、appSecret，分享url
    //iOS9以后，xcode7增加了代码压缩功能，ENABLE_BITCODE。 此功能很多第三方库不支持， 需要手动关闭.
    // Targets->Build Setting-搜索bitcode->改为NO
    [UMSocialWechatHandler setWXAppId:@"wx945b58aef3a271f0" appSecret:@"0ae78dd42761fd9681b04833c79a857b" url:@"http://www.umeng.com/social"];
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

/** 配置全局UI的样式 */
-(void)configClobalUIStyle{
    /** 导航栏不透明 */
    [[UINavigationBar appearance] setTranslucent:NO];
    /** 设置导航栏背景图片 */
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_64"] forBarMetrics:UIBarMetricsDefault];
    /** 配置导航栏题目样式 */
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont flatFontOfSize:17],NSForegroundColorAttributeName:kRGBColor(100, 105, 105)}];
}

-(RESideMenu *)sideMenu{
    if (!_sideMenu) {
        _sideMenu = [[RESideMenu alloc]initWithContentViewController:[MainYouShengViewController standardNavi] leftMenuViewController:[LeftViewController sharedVC] rightMenuViewController:nil];
        //        _sideMenu.backgroundImage = [UIImage imageNamed:@"hear-1"];
        _sideMenu.menuPrefersStatusBarHidden = YES;
    }
    return _sideMenu;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
