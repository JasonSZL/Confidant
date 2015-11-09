//
//  CommitInfoController.h
//  Confidant
//
//  Created by Eavawu on 11/3/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWindow+YUBottomPoper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface CommitInfoController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;
@property (weak, nonatomic) IBOutlet UITextField *habbitTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSG;
@property (nonatomic,strong) UIImage *headImg;

@end
