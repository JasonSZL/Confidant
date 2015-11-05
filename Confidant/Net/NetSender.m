//
//  NetSender.m
//  WeiLove
//
//  Created by Eavawu on 7/1/15.
//  Copyright (c) 2015 Eavawu. All rights reserved.
//

#import "NetSender.h"
#import "NetDefine.h"
#import "User.h"
static NSString* const BaseURLString = @"http://120.25.244.11/WeLoveServer/";
@implementation NetSender
-(void)initRequest{

}
-(void)sendRegisterRequest:(NSString *)pwd nickname:(NSString *)nickname phoneNum:(NSString *)phoneNum smsCode:(NSString *)smsCode sex:(NSString *)sex channel:(NSString *)channel portrait:(NSString *)portrait;{
    NSMutableArray *paramArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:pwd forKey:@"password"];
    [dict setValue:nickname forKey:@"userName"];
    [dict setValue:portrait forKey:@"headIcon"];
    [dict setValue:phoneNum forKey:@"mobileNum"];
    [dict setValue:sex forKey:@"sex"];
    NSString *paramString = [self getParamString:dict];
    [paramArr addObject:@"login"];
    [paramArr addObject:paramString];
    NSString *url = [self getCompleteUrl :paramArr];
    
    NSLog(@"url=====%@",url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", operation.responseString);
        // 2.将JSON字符串转为User模型
//        NSString*jsonString = @"111";
        User *user = [User objectWithKeyValues:operation.responseString];
        [[NSNotificationCenter defaultCenter] postNotificationName:CODE_SUCESS object:user userInfo:nil];
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        [[NSNotificationCenter defaultCenter] postNotificationName:REGISTER_FAILED object:error userInfo:nil];
    }];
    [operation start];
    
    
    
};
//发送验证码
-(void)sendVerifyRequest:(NSString *)verifyCode phoneNum:(NSString *)phoneNum zone:(NSString *)zone{
    NSMutableArray *paramArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:phoneNum forKey:@"phone"];
    [dict setValue:zone forKey:@"zone"];
    [dict setValue:verifyCode forKey:@"code"];
    [dict setValue:@"ios" forKey:@"device"];
    NSString *paramString = [self getParamString:dict];
    
    
    [paramArr addObject:@"captch/smsCode.do?"];
    [paramArr addObject:paramString];
    NSString *url = [self getCompleteUrl :paramArr];
    
    NSLog(@"url=====%@",url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@", operation.responseString);
    
            NSString *requestTmp = [NSString stringWithString:operation.responseString];
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:CODE_SUCESS object:resultDic userInfo:nil];
        NSLog(@"%@",resultDic);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failure: %@", error);
            
             [[NSNotificationCenter defaultCenter] postNotificationName:CODE_FAILED object:error userInfo:nil];
        }];
        [operation start];
}
//手机号是否可以注册
-(void)sendPhoneNumRequest:(NSString *)PhoneNum{
    NSMutableArray *paramArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:PhoneNum forKey:@"phone"];
    NSString *paramString = [self getParamString:dict];
    [paramArr addObject:@"user/checkIsRegister.do?"];
    [paramArr addObject:paramString];
    NSString *url = [self getCompleteUrl :paramArr];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", operation.responseString);
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
              [[NSNotificationCenter defaultCenter] postNotificationName:PHONE_SUCCESS object:resultDic userInfo:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        [[NSNotificationCenter defaultCenter] postNotificationName:PHONE_FAILED object:error userInfo:nil];
        
    }];
    [operation start];
};
//根据map来获取字符串参数
-(NSString *)getParamString:(NSMutableDictionary *)params{
    NSString *resultString = [[NSString alloc]init];
    NSEnumerator * enumeratorKey = [params keyEnumerator];
    NSArray * allKeys = [params allKeys];
    //快速枚举遍历所有KEY的值
    for (NSObject *object in enumeratorKey) {
        NSLog(@"遍历KEY的值: %@",object);
        NSObject *objectValue = [params objectForKey:object];
        NSString *tempParamStr = [[NSString alloc]initWithFormat:@"%@=%@",(NSString *)object,objectValue];
        if ([object isEqual:allKeys[allKeys.count-1]] ) {

            resultString = [[NSString alloc]initWithFormat:@"%@%@",resultString,tempParamStr];
        }else{
            resultString = [[NSString alloc]initWithFormat:@"%@%@&",resultString,tempParamStr];
            
        }
    }
    NSLog(@"getParamString===%@",resultString);
    return resultString;
};
-(void)sendLoginRequest:(NSString *)account pwd:(NSString *)pwd{
    NSMutableArray *paramArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:account forKey:@"account"];
    [dict setValue:pwd forKey:@"pwd"];


    NSString *paramString = [self getParamString:dict];
    
    
    [paramArr addObject:@"user/login.do?"];
    [paramArr addObject:paramString];
    NSString *url = [self getCompleteUrl :paramArr];
    
    NSLog(@"url=====%@",url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", operation.responseString);
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUCESS object:resultDic userInfo:nil];
        NSLog(@"%@",resultDic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_FAILED object:error userInfo:nil];
    }];
    [operation start];
};
//获取完整的url
-(NSString *)getCompleteUrl:(NSMutableArray *)params{
    NSString *resultString = [[NSString alloc]initWithFormat:@"%@",BaseURLString];
    for (int i=0; i<params.count; i++) {
        resultString = [[NSString alloc]initWithFormat:@"%@%@",resultString,params[i]];
    }
 return resultString;
};


@end
