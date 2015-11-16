//
//  MenuTableViewController.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuTableViewController;
@protocol MenuTableViewControllerDelegate <NSObject>

-(void)tableViewController:(MenuTableViewController *)tableViewController didSelected:(NSInteger)row selectedTagName:(NSString *)tagName;

@end

@interface MenuTableViewController : UITableViewController

@property (nonatomic,weak)id<MenuTableViewControllerDelegate> delegate;

@end
