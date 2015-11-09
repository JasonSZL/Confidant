//
//  LoginController.m
//  Confidant
//
//  Created by Eavawu on 10/28/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "LoginController.h"
#import "NetSender.h"
#import "NetDefine.h"
#import "GMDCircleLoader.h"
#import "User.h"
@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLoginSucess:) name:LOGIN_SUCESS object:nil];
    //添加失败监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLoginFailed:) name:LOGIN_FAILED object:nil];
//    CGRect rect = _userNameTF.frame;
//    rect.size.height = 50;
//    _userNameTF.frame = rect;
//    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName: color}];
    // Do any additional setup after loading the view.
}
//登陆成功的回调
- (void) getLoginSucess: (NSNotification*) aNotification
{
    //       [GMDCircleLoader setOnView:self.view withTitle:@"请后..." animated:YES];
    
    User *user = [aNotification object];
    [GMDCircleLoader hideFromView:self.view animated:YES];
    //    [self.navigationController dismissViewControllerAnimated:true];
//    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
    
    [self performSegueWithIdentifier:@"login2maintab" sender:self];
    
}
//失败的回调
- (void) getLoginFailed: (NSNotification*) aNotification
{
    NSString *errorMsg = [aNotification object];
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSLog(@"getPhoneRegisterResult");
    [self showAlertView:errorMsg];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signUpClick:(id)sender {
    NSString *account = _accountTF.text;
    NSString *password=_passwordTF.text;
    BOOL isRight = [self isAvalible:account password:password];
    if (isRight) {
        [[NetSender getInstance]sendLoginRequest:_accountTF.text pwd:_passwordTF.text];;
    }
    
    
}

-(BOOL)isAvalible:(NSString*)account password:(NSString*)password{
    NSString *errorTips = @"";
    if([account isEqualToString:@""] || account.length!=11){
        errorTips = @"账号长度不合法";
        [self showAlertView:errorTips];
        return FALSE;
    }
    if(password.length<6||password.length>20){
        errorTips = @"密码长度不合法";
        [self showAlertView:errorTips];
        return FALSE;
    }

    return TRUE;
}
-(void)showAlertView:(NSString*)stringTips {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:stringTips message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
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
