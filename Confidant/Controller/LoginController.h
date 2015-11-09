//
//  LoginController.h
//  Confidant
//
//  Created by Eavawu on 10/28/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTF;


@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@end
