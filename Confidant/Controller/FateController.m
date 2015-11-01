//
//  FateController.m
//  Confidant
//
//  Created by Eavawu on 10/31/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "FateController.h"

@interface FateController ()

@end

@implementation FateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [self.tableView headerBeginRefreshing];
//    
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
//    
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
//    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
//    self.tableView.headerRefreshingText = @"MJ哥正在帮你刷新中,不客气";
//    
//    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
//    self.tableView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
}

@end
