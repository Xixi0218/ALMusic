//
//  DownLoadTool.m
//  Music
//
//  Created by apple on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DownLoadTool.h"
#import <FMDB.h>
#import "DownLoadModel.h"
@implementation DownLoadTool
static FMDatabase * _db;
+(void)initialize
{
    NSString * file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"download.sqlite"];
    _db = [FMDatabase databaseWithPath:file];
    if (![_db open]) {
        return;
    }
    [_db executeUpdate:@"create table if not exists download(id integer primary key,download blob not null);"];
}
+(void)addUser:(DownLoadModel*)download
{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:download];
    [_db executeUpdateWithFormat:@"insert into download(download) values(%@);",data];
}
+(NSArray*)allUser
{
    FMResultSet * set = [_db executeQuery:@"select * from download;"];
    NSMutableArray * downloads = [NSMutableArray array];
    while (set.next) {
        DownLoadModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"download"]];
        [downloads addObject:model];
    }
    return [downloads copy];
}
@end
