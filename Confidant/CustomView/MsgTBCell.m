//
//  MsgTBCell.m
//  Confidant
//
//  Created by Eavawu on 11/1/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "MsgTBCell.h"

@implementation MsgTBCell


- (void)awakeFromNib {
//    CALayer *l = [self.imgAvatarImage layer];   //获取ImageView的层
//    [_img setMasksToBounds:YES];
//    [_img setCornerRadius:6.0];
    _img.layer.cornerRadius = 20;
    _img.layer.masksToBounds = YES;
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
