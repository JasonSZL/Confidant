//
//  MsgTBCell.h
//  Confidant
//
//  Created by Eavawu on 11/1/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgTBCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
