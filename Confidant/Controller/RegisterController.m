//
//  RegisterController.m
//  Confidant
//
//  Created by Eavawu on 10/29/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "RegisterController.h"
#import <SMS_SDK/SMSSDK.h>
#import "User.h"
#import "ModelUtil.h"

@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"]
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(selectLeftAction:)];
    
    

    self.navigationItem.leftBarButtonItem = backButton;
}

- (IBAction)getVerifyCodeClick:(id)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumTF.text
                                   zone:@"+86"
                       customIdentifier:nil
                                 result:^(NSError *error)
     {
         
         if (!error)
         {
             NSLog(@"验证码发送成功");
         }
         else
         {
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                             message:[NSString stringWithFormat:@"错误描述：%@",[error.userInfo objectForKey:@"getVerificationCode"]]
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                   otherButtonTitles:nil, nil];
             [alert show];
         }
         
     }];

}
-(BOOL)isAvalible:(NSString*)account password:(NSString*)password confirmPassword:(NSString*)confirmPassword{
    NSString *errorTips = @"";
    NSLog(@"account=%@",account);
    NSLog(@"confirmPassword=%@",confirmPassword);
    NSLog(@"password=%@",password);
    NSLog(@"confirm length=%d",confirmPassword.length);
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
    if (![password isEqualToString: confirmPassword]) {
        errorTips = @"两次密码不一致";
        [self showAlertView:errorTips];
        return FALSE;
    }
    return TRUE;
}
-(void)showAlertView:(NSString*)stringTips {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:stringTips message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
- (IBAction)signUpClick:(id)sender {
//    [self performSegueWithIdentifier:@"register2commit" sender:self];
    BOOL isRight = [self isAvalible:_phoneNumTF.text password:_passWordTF.text confirmPassword:_confirmPassWord.text];
    if (isRight) {
//            [SMSSDK commitVerificationCode:self.verifyCodeTF.text phoneNumber:_phoneNumTF.text zone:@"+86" result:^(NSError *error) {
                [self performSegueWithIdentifier:@"register2commit" sender:self];
                User *user = [[User alloc]init];
                [user setAccount:_phoneNumTF.text];
                [user setPassword:_passWordTF.text];
                [[ModelUtl getInstance]setUser:user];
                
                
//            }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectLeftAction:(id)sender
{
 [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectRightAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏右按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}


@end
