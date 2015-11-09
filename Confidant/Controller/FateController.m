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
@interface FateController ()

@end

@implementation FateController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    UIBarButtonItem *searchButton = UIButton alloc
    // Dispose of any resources that can be recreated.
//    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search.png"]
//                                                                   style:UIBarButtonSystemItemSearch
//                                                                  target:self
//                                                                  action:@selector(selectRightAction:)];
    //    self.view.
    
//    self.navigationItem.leftBarButtonItem = searchButton;
}
-(void)selectRightAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
    //    self.navigationController setHi
    //    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏左按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alter show];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
      self.automaticallyAdjustsScrollViewInsets =NO;
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
    
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [self.recommondTBView addHeaderWithTarget:self action:@selector(headerRereshing)];
////#warning 自动刷新(一进入程序就下拉刷新)
//    [self.recommondTBView headerBeginRefreshing];
//    
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.recommondTBView addFooterWithTarget:self action:@selector(footerRereshing)];
//    
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.recommondTBView.headerPullToRefreshText = @"下拉可以刷新了";
//    self.recommondTBView.headerReleaseToRefreshText = @"松开马上刷新了";
//    self.recommondTBView.headerRefreshingText = @"MJ哥正在帮你刷新中,不客气";
//    
//    self.recommondTBView.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    self.recommondTBView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
//    self.recommondTBView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)loadMoreData
{
//    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.fakeData insertObject:MJRandomData atIndex:0];
//    }
//    
//    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView headerEndRefreshing];
//    });
}

- (void)footerRereshing
{
//    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.fakeData addObject:MJRandomData];
//    }
//    
//    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.tableView footerEndRefreshing];
//    });
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RecommondTBCell a
   RecommondTBCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"RecommondTBCell" owner:self options:nil] lastObject];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MJTableViewCellIdentifier forIndexPath:indexPath];
//    
//    cell.textLabel.text = self.fakeData[indexPath.row];
//    return cell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"fate2showuser" sender:self];
    
//    NSLog(@"%d",);
//    MJTestViewController *test = [[MJTestViewController alloc] init];
//    [self.navigationController pushViewController:test animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//     RecommondTBCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"RecommondTBCell" owner:self options:nil]
    return 85;
}

@end
