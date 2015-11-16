//
//  ScorllPageController.h
//  Music
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScorllPageController;
@protocol ScorllPageControllerDelegate <NSObject>

-(void)scorllPageController:(ScorllPageController *)scorllPageController didSelected:(NSInteger)index;

@end

@interface ScorllPageController : UIViewController

-(instancetype)initWithImages:(NSArray *)images;

@property (nonatomic,readonly)UIPageViewController * pageVC;
@property (nonatomic,readonly)NSArray * images;
@property(nonatomic,readonly) UIPageControl *pageControl;
@property (nonatomic,weak)id<ScorllPageControllerDelegate> delegate;
@property (nonatomic,readonly)NSTimer * timer;
@end
