//
//  NetSender.h
//  WeiLove
//
//  Created by Eavawu on 7/1/15.
//  Copyright (c) 2015 Eavawu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
@interface NetSender : NSObject
@property  AFHTTPRequestOperation *request;
+ (NetSender *)getInstance ;
-(void)sendVerifyRequest:(NSString *)verifyCode phoneNum:(NSString *)phoneNum zone:(NSString *)zone;

-(NSString *)getParamString:(NSMutableDictionary *)params;
-(NSString *)getCompleteUrl:(NSMutableArray *)params;
-(void)sendRegisterRequest:(NSString *)pwd userName:(NSString *)userName account:(NSString *)account sex:(NSString *)sex  headIcon:(UIImage *)headIcon;
-(void)sendLoginRequest:(NSString *)account pwd:(NSString *)pwd;
-(void)sendRecommondRequest:(int)sex time:(long)time pageNum:(int)pageNum;
@end
