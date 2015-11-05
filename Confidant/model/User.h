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
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *password;
@property(nonatomic,strong) NSString *birthday;
@property(nonatomic,strong) NSString *account;
@property(nonatomic,strong) NSString *habbit;
@property(nonatomic,strong) NSString *userId;
@property int sex;
@property float longtitude;
@property float latitude;

@end


