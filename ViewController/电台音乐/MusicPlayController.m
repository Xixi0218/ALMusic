//
//  MusicPlayController.m
//  Music
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MusicPlayController.h"
#import "MBProgressHUD+MJ.h"
#import "TRAudioFile.h"
#import "UIView+Rotation.h"
#import "PlayView.h"
#import "UMSocial.h"
#import "MusicDetailViewModel.h"

//微信
//APPID wx945b58aef3a271f0
//APPSECRET 0ae78dd42761fd9681b04833c79a857b
@interface MusicPlayController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *frontBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (nonatomic,strong)DOUAudioStreamer * player;
@property (nonatomic,strong)TRAudioFile * audioFile;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic)NSInteger minute;
@property (nonatomic)NSInteger second;
@property (nonatomic)NSInteger time;
@property (nonatomic,strong)IBOutlet UIImageView * imageView;
@property (nonatomic,strong)MusicDetailTracksListModel * model1;
/** 检验是否是第一次播放这个歌曲*/
@property (nonatomic,assign) NSInteger i;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *playListBtn;

@property (nonatomic,strong)UITableView * tableView;

@property (weak, nonatomic) IBOutlet UIView *featuresView;
@property (nonatomic,strong)MusicDetailViewModel * detailVM;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressBar;
@end

@implementation MusicPlayController

-(MusicDetailViewModel *)detailVM
{
    if (_detailVM==nil) {
        _detailVM = [[MusicDetailViewModel alloc] init];
        _detailVM.albumId = self.model.albumId;
    }
    return _detailVM;
}

-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.featuresView.mas_top).mas_equalTo(0);
            make.width.mas_equalTo(250);
            make.right.mas_equalTo(250);
        }];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

+(MusicPlayController *)defaultsVC
{
    static MusicPlayController * vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MusicPlayController"];
    });
    return vc;
}
/** 开启计时器*/
-(void)startTimer
{
    [self.timer invalidate];
    self.timer = nil;
    if (self.playBtn.selected) {
        [self.imageView rotate:3];
    }
    else
    {
        [self.imageView stopRotate];
    }
    self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer)
    {
        if (self.player.status == 5) {
            [MBProgressHUD showError:@"播放错误"];
            [self.timer invalidate];
            self.timer=nil;
            return;
        }
        if (self.player.currentTime)
        {
            [self.activity stopAnimating];
            if (self.player.status == 1) {
                self.playBtn.selected = NO;
                [self.imageView stopRotate];
            }else
            {
                self.playBtn.selected = YES;
                if (self.i == 0) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangePlayer" object:nil userInfo:@{@"player":self.player,@"status":@(self.playBtn.selected),@"model":self.model}];
                    [self changeContent];
                    self.i++;
                }
                
            }
            self.progressBar.constant = self.progressView.frame.size.width * (self.player.receivedLength*1.0 / self.player.expectedLength * 1.0);
            self.imageView.hidden = NO;
            self.second++;
            self.time++;
            if (self.second%60 == 0) {
                self.minute++;
                self.second = 0;
            }
            self.currentTime.text = [NSString stringWithFormat:@"%02ld:%02ld",self.minute,self.second];
            NSInteger duration = self.player.duration;
            CGFloat progress = self.time / (duration * 1.0);
            [self.progressView setProgress:progress animated:YES];
            if (self.progressView.progress >= 1)
            {
                for (int i = 0; i<self.songLists.count; i++)
                {
                    MusicDetailTracksListModel * song = self.songLists[i];
                    if ([song.playUrl64 isEqualToString:self.model.playUrl64]) {
                        if (i+1>self.songLists.count - 1) {
                            self.model = self.songLists[0];
                            [self startTimer];
                            break;
                        }
                        else
                        {
                            self.model = self.songLists[i+1];
                            [self startTimer];
                            break;
                        }
                        
                    }
                }
            }
        }
        else
        {
            [self.player play];
        }
    } repeats:YES];
}

-(void)changeContent
{
    self.progressView.progress = 0;
    self.time = 0;
    self.second= 0;
    self.minute = 0;
    NSInteger duration = self.player.duration;
    NSInteger m = duration/60;
    NSInteger s = duration%60;
    self.currentTime.text = [NSString stringWithFormat:@"%02ld:%02ld",self.minute,self.second];
    self.totalTime.text = [NSString stringWithFormat:@"%02ld:%02ld",m,s];
    [self.imageView setImageWithURL:[NSURL URLWithString:self.model.coverMiddle]];
    self.imageView.layer.cornerRadius = self.imageView.bounds.size.width/2;
    self.imageView.clipsToBounds = YES;
    
    
    
}

-(void)stopTimer
{
    [self.timer invalidate];
    [self.imageView stopRotate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView rotate:3];
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [Factory addBackItemToVC:self];
    //[self startTimer];
    self.playBtn.selected = YES;
    
    [self.playBtn bk_addEventHandler:^(UIButton * sender) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            [self startTimer];
            [self.player play];
        }else
        {
            [self stopTimer];
            [self.player pause];
            self.i=0;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangePlayer" object:nil userInfo:@{@"player":self.player,@"status":@(self.playBtn.selected),@"model":self.model}];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.nextBtn bk_addEventHandler:^(id sender) {
        for (int i = 0; i<self.songLists.count; i++) {
            if (self.songLists[i] == self.model) {
                if (i+1>self.songLists.count - 1) {
                    self.model = self.songLists[0];
                    [self startTimer];
                    break;
                }
                else
                {
                    self.model = self.songLists[i+1];
                    [self startTimer];
                    break;
                }
                
            }
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.frontBtn bk_addEventHandler:^(id sender) {
        for (int i = 0; i<self.songLists.count; i++) {
            if (self.songLists[i] == self.model) {
                if (i-1<0) {
                    self.model = self.songLists[self.songLists.count - 1];
                    [self startTimer];
                    break;
                }
                else
                {
                   self.model = self.songLists[i-1];
                    [self startTimer];
                    break;
                }
                
            }
        }
    } forControlEvents:UIControlEventTouchUpInside];
     //UMSocialUrlResource * music = nil;
    [self.shareBtn bk_addEventHandler:^(id sender) {
        //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
        //NSData * data = [NSData dataWithContentsOfFile:self.model.playUrl64];
        UMSocialUrlResource * music = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeMusic url:self.model.playUrl64];
        UIImageView * imageView = [UIImageView new];
        [imageView setImageWithURL:[NSURL URLWithString:self.model.playUrl64]];
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:self.model.title image:imageView.image location:nil urlResource:music presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.playListBtn bk_addEventHandler:^(UIButton * sender) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            [self.tableView reloadData];
            [UIView animateWithDuration:1000.0 animations:^{
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.bottom.mas_equalTo(self.featuresView.mas_top).mas_equalTo(0);
                    make.width.mas_equalTo(250);
                    make.right.mas_equalTo(0);
                }];
            }];
        }else
        {
            [UIView animateWithDuration:2.0 animations:^{
                [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.bottom.mas_equalTo(self.featuresView.mas_top).mas_equalTo(0);
                    make.width.mas_equalTo(250);
                    make.right.mas_equalTo(250);
                }];
            }];
        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.detailVM refreshDataCompletionHandle:^(NSError *error) {
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
            
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.detailVM getMoreDataCompletionHandle:^(NSError *error) {
            [self.tableView reloadData];
            if (self.detailVM.pageId >= self.detailVM.maxPageId) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)setModel:(MusicDetailTracksListModel *)model
{
    
    _model = model;
    
    if ([self.model1.playUrl64 isEqualToString:model.playUrl64]) {
        [self startTimer];
        return;
    }
    self.i = 0;
    self.model1 = model;
    
    //1. 音频会话对象
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    //2. 设置会话类型
    
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //3. 激活
    [session setActive:YES error:nil];
    
    //创建播放文件对象
    self.audioFile=[[TRAudioFile alloc]init];
    //指定播放的url
    self.audioFile.audioFileURL = [NSURL URLWithString:model.playUrl64];
    //self.player = [DOUAudioStreamer sharedPlayer];
    self.player = [DOUAudioStreamer streamerWithAudioFile:self.audioFile];
    [self.player play];
    [self startTimer];
    [self changeContent];
    self.playBtn.selected = YES;
    self.imageView.hidden = YES;
    self.progressBar.constant = 0;
    [self.activity startAnimating];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    PlayView * view = [PlayView sharedInstance];
    view.superview.hidden = YES;
    view.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    PlayView * view = [PlayView sharedInstance];
    view.superview.hidden = NO;
    view.hidden = NO;
}

#pragma mark -- UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailVM.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    MusicDetailTracksListModel * model = self.detailVM.dataArr[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.font = [UIFont boldFlatFontOfSize:12];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = model.nickname;
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MusicDetailTracksListModel * model = self.detailVM.dataArr[indexPath.row];
    self.model = model;
    [UIView animateWithDuration:2.0 animations:^{
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.featuresView.mas_top).mas_equalTo(0);
            make.width.mas_equalTo(250);
            make.right.mas_equalTo(250);
        }];
    }];
    self.playListBtn.selected = !self.playListBtn.selected;
}

@end
