//
//  RegisterController.m
//  Confidant
//
//  Created by Eavawu on 10/29/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "RegisterController.h"
#import <SMS_SDK/SMSSDK.h>
@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"]
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(selectLeftAction:)];
//    self.view.
    
    self.navigationItem.leftBarButtonItem = backButton;
    
//    UIBarButtonSystemItem systemItemOut = [value integerValue];
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(selectLeftAction:)];
//    self.navigationItem.leftBarButtonItem = leftButton;
//    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(selectRightAction:)];
//    self.navigationItem.rightBarButtonItem = rightButton;
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
//             [self presentViewController:verify animated:YES completion:^{
//                 ;
//             }];
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

- (IBAction)signUpClick:(id)sender {
    [SMSSDK commitVerificationCode:self.verifyCodeTF.text phoneNumber:_phoneNumTF.text zone:@"+86" result:^(NSError *error) {
        
        if (!error) {
            NSLog(@"验证成功了，叼毛兽");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectLeftAction:(id)sender
{
 [self dismissViewControllerAnimated:YES completion:nil];    
//    [self.navigationController popViewControllerAnimated:YES];
//    self.navigationController setHi
//    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏左按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alter show];
}

-(void)selectRightAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏右按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
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
