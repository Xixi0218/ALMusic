//
//  JYCategoryViewController.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCategoryViewController : UICollectionViewController

@property (nonatomic,copy)NSString*tagName;

+ (JYCategoryViewController *)defaultVC;
@end
