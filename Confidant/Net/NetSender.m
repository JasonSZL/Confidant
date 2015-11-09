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
#import "ModelUtil.h"
static NSString* const BaseURLString = @"http://localhost:8080/";

@implementation NetSender
-(void)initRequest{

}
-(void)sendRecommondRequest:(int)sex time:(long)time pageNum:(int)pageNum{
    NSMutableArray *paramArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    NSString *sexStr = [ NSString stringWithFormat:@"%d",sex];
    NSString *timeStr = [NSString stringWithFormat:@"%ld",time];
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pageNum];
    [dict setValue:sexStr forKey:@"sex"];
    [dict setValue:timeStr forKey:@"time"];
    [dict setValue:pageNumStr forKey:@"pageNum"];
    
    NSString *paramString = [self getParamString:dict];
    
    
    [paramArr addObject:@"recommond?"];
    [paramArr addObject:paramString];
    NSString *url = [self getCompleteUrl :paramArr];
    NSLog(@"url=====%@",url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", operation.responseString);
        
        int result = [self getResult:operation.responseString];
        User *user =  NULL;
        if (result==RESULT_SUCCESS) {
            NSString* dataStr = [self getData:operation.responseString];
            
//            user = [User objectWithKeyValues:dataStr];
           [ModelUtl getInstance].recommondList = [User objectArrayWithKeyValuesArray:dataStr];
//            [ModelUtl getInstance].recommondList.objectClassInArray
            [[NSNotificationCenter defaultCenter] postNotificationName:RECOMMOND_SUCCESS object:nil userInfo:nil];
        }else{
            NSString *errorMsg = [self getErrorNo:operation.responseString];
            [[NSNotificationCenter defaultCenter] postNotificationName:RECOMMOND_FAILED object:errorMsg userInfo:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_FAILED object:error userInfo:nil];
    }];
    [operation start];
    
};
-(void)sendRegisterRequest:(NSString *)pwd userName:(NSString *)userName account:(NSString *)account sex:(NSString *)sex  headIcon:(UIImage *)headIcon latitude:(NSString *)latitude longtitude:(NSString*)longtitude{

    
    NSData *data =UIImagePNGRepresentation(headIcon);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"password": pwd,@"userName":userName,@"account":account,@"sex":sex,@"latitude":latitude,@"longtitude":longtitude};
    [manager POST:@"http://localhost:8080/register" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"fileUpload" fileName:@"fileUpload" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                int result = [self getResult:operation.responseString];
                User *user =  NULL;
                if (result==RESULT_SUCCESS) {
                    NSString* dataStr = [self getData:operation.responseString];
                    user = [User objectWithKeyValues:dataStr];
                    [[NSNotificationCenter defaultCenter] postNotificationName:REGISTER_SUCESS object:user userInfo:nil];
                }else{
                   NSString *errorMsg = [self getErrorNo:operation.responseString];
                    [[NSNotificationCenter defaultCenter] postNotificationName:REGISTER_FAILED object:errorMsg userInfo:nil];
                }
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
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
    [dict setValue:pwd forKey:@"password"];


    NSString *paramString = [self getParamString:dict];
    
    
    [paramArr addObject:@"login?"];
    [paramArr addObject:paramString];
    NSString *url = [self getCompleteUrl :paramArr];
    
    NSLog(@"url=====%@",url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", operation.responseString);
        
        int result = [self getResult:operation.responseString];
        User *user =  NULL;
        if (result==RESULT_SUCCESS) {
            NSString* dataStr = [self getData:operation.responseString];
            user = [User objectWithKeyValues:dataStr];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUCESS object:user userInfo:nil];
        }else{
            NSString *errorMsg = [self getErrorNo:operation.responseString];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_FAILED object:errorMsg userInfo:nil];
        }
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
static NetSender *defaultSender = nil;

+ (NetSender *)getInstance {
    if (!defaultSender) defaultSender = [[self allocWithZone:NULL] init];
    return defaultSender;
}
-(int)getResult:(NSString *)jsonString{
    NSString *requestTmp = [NSString stringWithString:jsonString];
    NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
    //系统自带JSON解析
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    return [resultDic[@"result"] integerValue];
}
-(NSString *)getData:(NSString *)jsonString{
    NSString *requestTmp = [NSString stringWithString:jsonString];
    NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
    //系统自带JSON解析
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    return resultDic[@"data"] ;
}
-(NSString *)getErrorNo:(NSString *)jsonString{
    NSString *requestTmp = [NSString stringWithString:jsonString];
    NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
    //系统自带JSON解析
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    return resultDic[@"errno"] ;
}
@end
