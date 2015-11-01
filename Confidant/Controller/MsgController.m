//
//  MsgController.m
//  Confidant
//
//  Created by Eavawu on 10/31/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "MsgController.h"
#import <RongIMKit/RongIMKit.h>
#import "ChatListViewController.h"
@interface MsgController ()

@end

@implementation MsgController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.items = nil;
    _msgList = [[NSArray alloc] initWithObjects:@"Item 1",@"Item 2",@"Item 3", @"Item 4",@"Item 5",@"Item 6",@"Item 7",@"Item 8",@"Item 9",@"Item 10",@"Item 11",@"Item 12", nil];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_msgList count]; // or self.items.count;
}
#pragma mark - TableView Methods



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Step 1: Check to see if we can reuse a cell from a row that has just rolled off the screen
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"MsgTBCell";
    //自定义cell类
     MsgTBCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MsgTBCell" owner:self options:nil] lastObject];
    }
    
    //添加测试数据
    cell.titleLabel.text = @"aaa";
    cell.detailLabel.text = @"这是一些测试数据";
    //测试图片
//    cell.img.image = [UIImage imageNamed:@"testImage.jpg"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.view.frame.size.height-85)/5;
}
// cell被选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];   // 选中cell后,高亮状态立马就消失
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    NSString*token=@"TO8qRzUGBILMbLmWbPcZWtrJmcY9GJoZZQHra6K56U9pNHsiaLQnmbXas1hThSYNtU0sCiGjC9yzOCV7Vc884g==";
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        NSLog(@"Login successfully with userId: %@.", userId);
        dispatch_async(dispatch_get_main_queue(), ^{
            ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
            [self.navigationController pushViewController:chatListViewController animated:YES];
            self.tabBarController.tabBar.hidden = YES;
        });
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];

}
/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"andy" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"andy";
        user.name = @"测试1";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        
        return completion(user);
    }else if([@"haha" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"haha";
        user.name = @"测试2";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
