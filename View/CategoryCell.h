//
//  CategoryCell.h
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *playCountLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
