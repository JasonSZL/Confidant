//
//  SplashController.m
//  ZhiJi
//
//  Created by Eavawu on 10/4/15.
//  Copyright © 2015 Eavawu. All rights reserved.
//

#import "SplashController.h"

@interface SplashController ()

@end

@implementation SplashController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    //Calling this methods builds the intro and adds it to the screen. See below.
    [self buildIntro];
//     [self performSegueWithIdentifier:@"s2v" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Build MYBlurIntroductionView

-(void)buildIntro{
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"SplashItem"];

    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"SplashItem"];
                                                            
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"SplashItem"];

    
    UIImageView *imgView = (UIImageView *) panel2.subviews[0];
    imgView.image = [UIImage imageNamed:@"guide_image01.png"];
    
    UIImageView *imgView1 = (UIImageView *) panel3.subviews[0];
    imgView1.image = [UIImage imageNamed:@"guide_image02.png"];
    
    UIImageView *imgView2 = (UIImageView *) panel1.subviews[0];
    imgView2.image = [UIImage imageNamed:@"guide_image03.png"];

    NSArray *panels = @[panel1,panel2,panel3];
    
    //Create the introduction view and set its delegate
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    introductionView.delegate = self;
//    introductionView.BackgroundImageView.image = [UIImage imageNamed:@"accost_send_result_bg.png"];
    //introductionView.LanguageDirection = MYLanguageDirectionRightToLeft;
    
    //Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    //Add the introduction to your view
    [self.view addSubview:introductionView];
}

#pragma mark - MYIntroduction Delegate

-(void)introduction:(MYBlurIntroductionView *)introductionView didChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"Introduction did change to panel %ld", (long)panelIndex);
    
    //You can edit introduction view properties right from the delegate method!
    //If it is the first panel, change the color to green!
    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:1]];
    }
    //If it is the second panel, change the color to blue!
    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:1]];
    }
    
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType {
    NSLog(@"Introduction did finish");
//    self.view.window.rootViewController = [[ViewController alloc]init];
//    [self.storyborad performSegueWithIdentifier:@"s2v" sender:self];
    [self performSegueWithIdentifier:@"splash2login" sender:self];
//    NSString * storyboardName = @"Main";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"loginStoryBorad"];
//    
//    [self presentViewController:vc animated:YES completion:nil];
}




@end
