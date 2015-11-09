//
//  modelUtl.m
//  Confidant
//
//  Created by Eavawu on 11/5/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "ModelUtil.h"

@implementation ModelUtl

static ModelUtl *defaultUtil = nil;

+ (ModelUtl *)getInstance {
    if (!defaultUtil) defaultUtil = [[self allocWithZone:NULL] init];
    return defaultUtil;
}
@end
