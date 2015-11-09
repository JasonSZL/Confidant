//
//  FateController.m
//  Confidant
//
//  Created by Eavawu on 10/31/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "FateController.h"
#import "MJRefresh.h"
#import "User.h"
#import "RecommondTBCell.h"
#import "GMDCircleLoader.h"
#import "Util.h"
#import "NetSender.h"
#import "ModelUtil.h"
#import "NetDefine.h"
@interface FateController ()

@end

@implementation FateController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)selectRightAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

    
}
//成功的回调
- (void) getRecommondSucess: (NSNotification*) aNotification
{

    
//    User *user = [aNotification object];
    _recommondList = [ModelUtl getInstance].recommondList;
    
    [GMDCircleLoader hideFromView:self.view animated:YES];

    self.recommondTBView.dataSource = self;
    [self.recommondTBView reloadData];
    
}
//失败的回调
- (void) getRecommondFailed: (NSNotification*) aNotification
{
    NSString *errorMsg = [aNotification object];
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSLog(@"getPhoneRegisterResult");
    [[Util getInstance] showAlertView:errorMsg parent:self];
    

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRecommondSucess:) name:RECOMMOND_SUCCESS object:nil];
    //添加失败监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRecommondFailed:) name:RECOMMOND_FAILED object:nil];
      self.automaticallyAdjustsScrollViewInsets =NO;
    _recommondList = [[NSMutableArray alloc]init];
    int sex = 0;
    if ([ModelUtl getInstance].user.sex==0) {
        sex = 1;
    }
    [[NetSender getInstance]sendRecommondRequest:sex time:[[Util getInstance]getSystemTime] pageNum:1];
    
    // 1.注册cell
//    [self.recommondTBView registerClass:[RecommondTBCell class] forCellReuseIdentifier:@"cell"];
    
    // 2.集成刷新控件
    [self setupRefresh];
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJTableViewController--dealloc---");
}



/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    
    
//    self.recommondTBView. = @"下拉可以刷新了";
//    self.recommondTBView.headerReleaseToRefreshText = @"松开马上刷新了";
//    self.recommondTBView.headerRefreshingText = @"MJ哥正在帮你刷新中,不客气";
//    
//    self.recommondTBView.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    self.recommondTBView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
//    self.recommondTBView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
    
    
    self.recommondTBView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
//    或
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.recommondTBView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
//    [self.recommondTBView.header beginRefreshing];
    
    
    self.recommondTBView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
//    或
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.recommondTBView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
//    [self.recommondTBView.footer beginRefreshing];
    self.recommondTBView.delegate = self;
    self.recommondTBView.dataSource = self;

}

#pragma mark 开始进入刷新状态
- (void)loadMoreData
{

}

- (void)footerRereshing
{

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _recommondList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    RecommondTBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommondTBCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RecommondTBCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    NSUInteger lastIndex = [indexPath indexAtPosition:[indexPath length] - 1]; // Gets you the '2' in [0, 2]
    User *user = [_recommondList objectAtIndex:lastIndex];
    cell.userNameLB.text = user.userName;
//    cell.headIV.image = [UIImage imageNamed:user.headIcon];
    return cell;
//    
//   RecommondTBCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"RecommondTBCell" owner:self options:nil] lastObject];
//
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger lastIndex = [indexPath indexAtPosition:[indexPath length] - 1]; // Gets you the '2' in [0, 2]
    User *user = [_recommondList objectAtIndex:lastIndex];
    [ModelUtl getInstance].fateUser = user;
    [self performSegueWithIdentifier:@"fate2showuser" sender:self];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 85;
}

@end
