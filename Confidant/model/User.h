//
//  Header.h
//  Confidant
//
//  Created by Eavawu on 11/4/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface User:NSObject
@property(copy, nonatomic) NSString *userName;
@property(copy, nonatomic) NSString *password;
@property(copy, nonatomic) NSString *birthday;
@property(copy, nonatomic) NSString *account;
@property(copy, nonatomic) NSString *habbit;
@property(copy, nonatomic) NSString *userId;
@property(copy,nonatomic)NSString *headIcon;
@property(assign, nonatomic) int sex;
@property(assign, nonatomic)float longtitude;
@property(assign, nonatomic) float latitude;

@end


