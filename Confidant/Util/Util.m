//
//  Util.m
//  Confidant
//
//  Created by Eavawu on 11/7/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "Util.h"

@implementation Util
static Util *defaultUtil=NULL;
+(instancetype)getInstance{
    if (!defaultUtil) {
        defaultUtil = [[Util alloc]init];
    }
    return defaultUtil;
}
-(NSString *)getStringFromImg:(UIImage*)img{
    return [UIImagePNGRepresentation(img) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
-(UIImage *)getImgFromString:(NSString *)imgStr{
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:imgStr];
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}
@end
