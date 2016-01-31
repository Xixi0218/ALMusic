//
//  DownLoadController.m
//  Music
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DownLoadController.h"
#import "DownLoadModel.h"
#import "DownListCell.h"
#import "DownLoadTool.h"
#import "MusicPlayController.h"
@interface DownLoadController ()<NSURLSessionDownloadDelegate>

//Session
@property (strong, nonatomic) NSURLSession *session;

@property (nonatomic,strong)NSMutableArray * array;

@property (nonatomic,strong)NSMutableArray * arrayM;

@property (nonatomic,strong)NSMutableDictionary * dict;

@property (nonatomic,strong)NSMutableArray * resumeDatas;

@property (nonatomic,strong)NSData * data;

@property (nonatomic,strong)UISegmentedControl * segmentedControl;

@property (nonatomic,strong)NSMutableArray * finish;

@end

@implementation DownLoadController

-(NSMutableArray *)resumeDatas
{
    if (_resumeDatas==nil) {
        _resumeDatas = [[NSMutableArray alloc] init];
    }
    return _resumeDatas;
}

-(NSMutableArray *)array
{
    if (_array==nil) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}

-(NSMutableArray *)arrayM
{
    if (_arrayM==nil) {
        _arrayM = [[NSMutableArray alloc] init];
    }
    return _arrayM;
}

-(NSMutableDictionary *)dict
{
    if (_dict==nil) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    return _dict;
}

-(NSMutableArray *)finish
{
    if (_finish==nil) {
        _finish = [[NSMutableArray alloc] init];
    }
    return _finish;
}

+(DownLoadController *)defaultsVC
{
    static DownLoadController * vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [DownLoadController new];
    });
    return vc;
}

- (NSURLSession *)session
{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        
    }
    return _session;
}

-(void)setModel:(MusicDetailTracksListModel *)model
{
    _model = model;
    NSURL *url = [NSURL URLWithString:model.playUrl64];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask * task = [self.session downloadTaskWithRequest:request];
    [task resume];
    DownLoadModel * download = [DownLoadModel new];
    download.model = model;
    [self.arrayM addObject:download];
    [self.array addObject:task];
    
    [self.dict setObject:download forKey:task];
    
    NSData * data = [NSData data];
    [self.resumeDatas addObject:data];
    [self.tableView reloadData];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    self.finish = [NSMutableArray arrayWithArray:[DownLoadTool allUser]];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"正在下载",@"已下载"]];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl bk_addEventHandler:^(UISegmentedControl * sender) {
        if (sender.selectedSegmentIndex == 0) {
            [self.tableView reloadData];
        }else
        {
            [self.tableView reloadData];
        }
    } forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    [self.tableView registerClass:[DownListCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return self.arrayM.count;
    }
    else
    {
        return self.finish.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DownListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    DownLoadModel * model = nil;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        model = self.arrayM[indexPath.row];
        cell.progress.hidden = NO;
        cell.button.hidden = NO;
    }
    else
    {
        model = self.finish[indexPath.row];
        cell.progress.hidden = YES;
        cell.button.hidden = YES;
    }
    MusicDetailTracksListModel * data = model.model;
    cell.titleLb.text = data.title;
    cell.sourceLb.text = data.nickname;
    model.progress = cell.progress;
    model.progress.progress = model.value;
    [cell.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

#pragma mark -- 按钮点击
-(void)click:(UIButton *)button
{
    if(button.selected){
        NSURLSessionDownloadTask * task = self.array[button.tag];
        [task cancelByProducingResumeData:^(NSData *resumeData) {
            self.data = resumeData;
            [self.resumeDatas replaceObjectAtIndex:button.tag withObject:resumeData];
        }];
        
    }else{
        NSData * data = self.resumeDatas[button.tag];
        DownLoadModel * model = self.dict [self.array[button.tag]];
        NSURLSessionDownloadTask * task = [self.session downloadTaskWithResumeData:data];
        [task resume];
        [self.array replaceObjectAtIndex:button.tag withObject:task];
        //data = nil;

        [self.dict setObject:model forKey:task];
        
    }
    button.selected = !button.selected;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        MusicPlayController * vc = [MusicPlayController defaultsVC];
        DownLoadModel * model = self.finish[indexPath.row];
        NSMutableArray * array = [NSMutableArray array];
        for (DownLoadModel * model in self.finish) {
            [array addObject:model.model];
        }
        vc.songLists = [array copy];
        vc.isLocation = YES;
        vc.model = model.model;
        
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - NSURLSessionDownloadDelegate
//下载完毕后,调用此方法, location就是下载来的临时文件
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    //将临时文件保存到指定的目录中,比如Documents下
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString * path = [documentPath stringByAppendingPathComponent:@"Music"];
    [[NSFileManager defaultManager]  createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    for (int i = 0; i<self.arrayM.count;i++) {
        if (self.array[i] == downloadTask) {
            DownLoadModel * model = self.arrayM[i];
            MusicDetailTracksListModel * data = model.model;
            NSString * str = [NSString stringWithFormat:@"%@.mp3",data.title];
            NSString *destPath = [path stringByAppendingPathComponent:str];
            NSLog(@"%@",destPath);
            NSError *error = nil;
            BOOL ret = [[NSFileManager defaultManager]moveItemAtPath:[location path] toPath:destPath error:&error];
            if (ret) {
                NSLog(@"成功");
                [self.arrayM removeObject:model];
                [self.array removeObject:downloadTask];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
                [self.delegate downLoadController:self data:data];
                [self.finish addObject:model];
                [DownLoadTool addUser:model];
            }
            else
            {
                NSLog(@"%@",error.userInfo);
            }
        }
    }
}

//下载过程中不断回调此方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //1. 计算当前的下载进度
    
    double progress = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
    //2. 控制进度条的显示(别忘了要回到主线程)
    dispatch_async(dispatch_get_main_queue(), ^{
        DownLoadModel * model = self.dict[downloadTask];
        model.value = progress;
        [model.progress setProgress:progress animated:YES];
    });
}

@end
