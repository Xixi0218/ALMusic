//
//  MainIntefaceViewController.m
//  Music
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MainIntefaceViewController.h"
#import "MenuTableViewController.h"
#import "RightMenuViewController.h"
#import "JYCategoryViewController.h"
#import "PlayView.h"
#import "MusicPlayController.h"
#import "MusicDetailModel.h"
#import "MBProgressHUD+MJ.h"
#import "JYViewController.h"
#import "coverView.h"
@interface MainIntefaceViewController ()<MenuTableViewControllerDelegate,PlayViewDelegate>

@property (nonatomic,strong)MenuTableViewController * vc;

@property (nonatomic,strong)RightMenuViewController * rvc;

@property (nonatomic,strong)JYCategoryViewController * cvc;

@property (nonatomic,strong)UIView * coverView;

@property (nonatomic,strong)MusicDetailTracksListModel * model;

@end

@implementation MainIntefaceViewController

+(UINavigationController *)defaultVC
{
    static JYViewController * vc = nil;
        vc = [[JYViewController defaultsNavi]initWithRootViewController:[MainIntefaceViewController new]];
    return vc;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Factory addMenuItemToVC:self];
    [Factory addDownLoadItemToVC:self];
    self.navigationController.navigationBar.barTintColor = [UIColor greenSeaColor];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_loading"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self setContent];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePlayer:) name:@"ChangePlayer" object:nil];
}

-(void)changePlayer:(NSNotification *)notification
{
    PlayView * view = [PlayView sharedInstance];
    view.player = notification.userInfo[@"player"];
    NSNumber * status = notification.userInfo[@"status"];
    if (status.integerValue == 1) {
        view.playBtn.selected = YES;
    }else
    {
        view.playBtn.selected = NO;
    }
    self.model = notification.userInfo[@"model"];
    view.titleLB.text = self.model.title;
    view.descLB.text = self.model.nickname;
}

-(void)setContent
{
   
    UIWindow * window = [UIApplication sharedApplication].windows.firstObject;
    
    coverView * coverView1 = [coverView defaultView];
    [window addSubview:coverView1];
    [coverView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    PlayView * view = [PlayView sharedInstance];
    [coverView1 addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    view.delegate = self;
    
    coverView1.backgroundColor = [UIColor clearColor];
    
    self.vc =[[MenuTableViewController alloc] init];
    self.vc.delegate = self;
    [self addChildViewController:self.vc];
    [self.view addSubview:self.vc.view];
    [self.vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(110);
    }];
    
    
    self.rvc = [RightMenuViewController defaultVC];
    [self addChildViewController:self.rvc];
    [self.view addSubview:self.rvc.view];
    [self.rvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.vc.view.mas_right).mas_equalTo(0);
    }];
}

#pragma makr -- PlayViewDelegate
-(BOOL)playViewDidClick:(PlayView *)PlayView
{
    if (!PlayView.player) {
        [MBProgressHUD showError:@"请先选择" toView:self.view];
        return NO;
    }
    MusicPlayController * vc = [MusicPlayController defaultsVC];
    [self.navigationController pushViewController:vc animated:YES];
    return YES;
}

-(BOOL)playStatus:(PlayView *)playView
{
    if (!playView.player) {
        return NO;
    }
    return YES;
}

#pragma mark -- UITableView
-(void)tableViewController:(MenuTableViewController *)tableViewController didSelected:(NSInteger)row selectedTagName:(NSString *)tagName
{
    if([tagName isEqualToString:@"推荐列表"])
    {
        [self.cvc.view removeFromSuperview];
        [self.cvc removeFromParentViewController];
        
        self.rvc = [RightMenuViewController defaultVC];
        [self addChildViewController:self.rvc];
        [self.view addSubview:self.rvc.view];
        [self.rvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.vc.view.mas_right).mas_equalTo(0);
        }];
    }
    else
    {
        [self.rvc.view removeFromSuperview];
        [self.rvc removeFromParentViewController];
        //self.rvc = nil;
        
        self.cvc = [JYCategoryViewController defaultVC];
        [self addChildViewController:self.cvc];
        [self.view addSubview:self.cvc.view];
        self.cvc.tagName = tagName;
        [self.cvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.vc.view.mas_right).mas_equalTo(0);
        }];
        //cvc.tagName = tagName;
        
    }
}

@end
