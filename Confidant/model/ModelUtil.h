//
//  modelUtl.h
//  Confidant
//
//  Created by Eavawu on 11/5/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ModelUtl : NSObject
+(instancetype)getInstance;
@property(nonatomic,strong)User *user;
@property(nonatomic,retain)NSMutableArray<User *> *recommondList;
@property(nonatomic,retain)User *fateUser;
@end
