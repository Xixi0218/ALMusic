//
//  DetailModel.m
//  BaseProject
//
//  Created by adam on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [DetailListModel class]};
}
@end
@implementation DetailListModel
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end


