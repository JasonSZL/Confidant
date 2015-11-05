//
//  CommitInfoController.m
//  Confidant
//
//  Created by Eavawu on 11/3/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "CommitInfoController.h"
#define ORIGINAL_MAX_WIDTH 640.0f
@implementation CommitInfoController
- (IBAction)commitClick:(id)sender {
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [_headIV setUserInteractionEnabled:YES];
     [_headIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCategory:)]];
//    [self loadHeadIv];
    [_headIV.layer setCornerRadius:CGRectGetHeight([_headIV bounds]) / 2];
    _headIV.layer.masksToBounds = YES;
   // 然后再给图层添加一个有色的边框，类似qq空间头像那样
    _headIV.layer.borderWidth = 5;
    _headIV.layer.borderColor = [[UIColor whiteColor] CGColor];
    _headIV.layer.contents = (id)[[UIImage imageNamed:@"backgroundImage.png"] CGImage];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        _headIV.image =[ self thumbnailWithImageWithoutScale:portraitImg size:CGSizeMake(140, 140)];
    }];
//    [picker dismissViewControllerAnimated:YES ];

}
-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view.window  showPopWithButtonTitles:@[@"相册",@"相机"] styles:@[YUDefaultStyle,YUDefaultStyle,YUDangerStyle] whenButtonTouchUpInSideCallBack:^(int index  ) {
        if (index==0) {
            [self selectPhotoFromCamera];
        }else if(index==1){
            [self selectPhotoFromGalley];
        }
    }];

    
}
#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL) doesCameraSupportTakingPhotos {
    return TRUE;
}
- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
-(void)selectPhotoFromCamera{
    // 拍照
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([self isFrontCameraAvailable]) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
    }
    
}
-(void)selectPhotoFromGalley{
    // 从相册中选取
    if ([self isPhotoLibraryAvailable]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
    }

}
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}

//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}


@end
