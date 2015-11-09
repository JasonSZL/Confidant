//
//  MsgController.h
//  Confidant
//
//  Created by Eavawu on 10/31/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgTBCell.h"
//tab主页面
@interface MsgController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,retain) NSArray *msgList;

@end
