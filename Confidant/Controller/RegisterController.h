//
//  RegisterController.h
//  Confidant
//
//  Created by Eavawu on 10/29/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;

@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassWord;

@end
