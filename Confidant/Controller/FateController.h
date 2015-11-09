//
//  FateController.h
//  Confidant
//
//  Created by Eavawu on 10/31/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface FateController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *recommondTBView;
@property(nonatomic,retain)NSMutableArray<User *> *recommondList;
@end
