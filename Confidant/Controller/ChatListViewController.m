//
//  ChatListViewController.m
//  RongCloudDemo
//
//  Created by 杜立召 on 15/4/18.
//  Copyright (c) 2015年 dlz. All rights reserved.
//

#import "ChatListViewController.h"
@interface ChatListViewController ()

@end

@implementation ChatListViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self login];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
//    //自定义导航左右按钮
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"单聊" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
//    [rightButton setTintColor:[UIColor whiteColor]];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 6, 67, 23);
//    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigator_btn_back"]];
//    backImg.frame = CGRectMake(-10, 0, 22, 22);
//    [backBtn addSubview:backImg];
//    UILabel *backText = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 65, 22)];
//    backText.text = @"退出";
//    backText.font = [UIFont systemFontOfSize:15];
//    [backText setBackgroundColor:[UIColor clearColor]];
//    [backText setTextColor:[UIColor whiteColor]];
//    [backBtn addSubview:backText];
//    [backBtn addTarget:self action:@selector(leftBarButtonItemPressed:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
//    self.navigationItem.rightBarButtonItem = rightButton;
    self.conversationListTableView.tableFooterView = [UIView new];
    
}
-(void) viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
//    [super viewDidAppear];
    
    
}
/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.userName =model.conversationTitle;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"会话";    
}

/**
 *  退出登录
 *
 *  @param sender <#sender description#>
 */
- (void)leftBarButtonItemPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alertView show];
}
-(void)login{

    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    NSString*token=@"TO8qRzUGBILMbLmWbPcZWtrJmcY9GJoZZQHra6K56U9pNHsiaLQnmbXas1hThSYNtU0sCiGjC9yzOCV7Vc884g==";
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        NSLog(@"Login successfully with userId: %@.", userId);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
//            [self.navigationController pushViewController:chatListViewController animated:YES];
//            self.tabBarController.tabBar.hidden = YES;
//        });
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
}
/*
*此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
*/
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"1" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"andy";
        user.name = @"测试1";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        
        return completion(user);
    }else if([@"2" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"haha";
        user.name = @"测试2";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    }
}
/**
 *  重载右边导航按钮的事件
 *
 *  @param sender <#sender description#>
 */
-(void)rightBarButtonItemPressed:(id)sender
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = @"1"; //这里模拟自己给自己发消息，您可以替换成其他登录的用户的UserId
    conversationVC.userName = @"测试1";
    conversationVC.title = @"自问自答";
    [self.navigationController pushViewController:conversationVC animated:YES];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[RCIM sharedRCIM]disconnect];
        
        [self.navigationController popViewControllerAnimated:YES];
//        self.tabBarController.tabBar.hidden    = NO;
    }
}

@end