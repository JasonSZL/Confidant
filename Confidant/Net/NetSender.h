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

-(void)sendVerifyRequest:(NSString *)verifyCode phoneNum:(NSString *)phoneNum zone:(NSString *)zone;
-(void)sendPhoneNumRequest:(NSString *)PhoneNum;
-(NSString *)getParamString:(NSMutableDictionary *)params;
-(NSString *)getCompleteUrl:(NSMutableArray *)params;
-(void)sendRegisterRequest:(NSString *)pwd nickname:(NSString *)nickname phoneNum:(NSString *)phoneNum smsCode:(NSString *)smsCode sex:(NSString *)sex channel:(NSString *)channel portrait:(NSString *)portrait;
-(void)sendLoginRequest:(NSString *)account pwd:(NSString *)pwd;
@end
