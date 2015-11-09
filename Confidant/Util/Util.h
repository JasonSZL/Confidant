//
//  Util.h
//  Confidant
//
//  Created by Eavawu on 11/7/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Util : NSObject
-(NSString *)getStringFromImg:(UIImage*)img;
-(UIImage *)getImgFromString:(NSString *)imgStr;
+(instancetype)getInstance;
-(void)showAlertView:(NSString*)stringTips parent:(UIViewController*)parent;
-(long)getSystemTime;
@end
