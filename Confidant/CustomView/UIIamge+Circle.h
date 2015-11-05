//
//  UIIamge+Circle.h
//  WeiLove
//
//  Created by Eavawu on 6/30/15.
//  Copyright (c) 2015 Eavawu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Circle)
/**
 *  @param icon         头像图片名称
 *  @param borderImage  边框的图片名称
 *  @param border       边框大小
 *
 *  @return 圆形的头像图片
 */
+ (instancetype)imageWithIconName:(NSString *)icon borderImage:(NSString *)borderImage border:(int)border;
@end
