//
//  RootViewController.m
//  RuntimDemo
//
//  Created by 胡蕾蕾 on 2019/11/28.
//  Copyright © 2019 hll. All rights reserved.
//

#import "RootViewController.h"
#import "ResultVC.h"
#import "UITestVC.h"
#import <FTMobileAgent/FTMobileAgent.h>
#import "UITestManger.h"
#import "AppDelegate.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self isAutoTrackVC]) {
        [[UITestManger sharedManger] addAutoTrackViewScreenCount];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"login" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:button];
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 150, 100)];
    button2.backgroundColor = [UIColor orangeColor];
    [button2 setTitle:@"result logout" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(endBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}
- (void)buttonClick{
    [[FTMobileAgent sharedInstance] bindUserWithName:@"test7" Id:@"1111111" exts:nil];
    if ([self isAutoTrackVC] && [self isAutoTrackUI:UIButton.class]) {
       [[UITestManger sharedManger] addAutoTrackClickCount];
        }
    [self.navigationController pushViewController:[UITestVC new] animated:YES];
}
-(void)endBtnClick{
//    [[FTMobileAgent sharedInstance] logout];
    if ([self isAutoTrackVC] && [self isAutoTrackUI:UIButton.class]) {
    [[UITestManger sharedManger] addAutoTrackClickCount];
     }
    [self.navigationController pushViewController:[ResultVC new] animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
-(void)dealloc{
    if ([self isAutoTrackVC]) {
    [[UITestManger sharedManger] addAutoTrackViewScreenCount];
    }
}
- (BOOL)isAutoTrackUI:(Class )view{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    if (appDelegate.config.whiteViewClass.count>0) {
        [appDelegate.config.whiteViewClass containsObject:view];
    }
    if(appDelegate.config.blackViewClass.count>0)
        return ! [appDelegate.config.blackViewClass containsObject:view];;
    return YES;
}
- (BOOL)isAutoTrackVC{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!appDelegate.config.enableAutoTrack) {
        return NO;
    }
     if (appDelegate.config.whiteVCList.count>0) {
         [appDelegate.config.whiteVCList containsObject:@"RootViewController"];
     }
     if(appDelegate.config.blackVCList.count>0)
         return ! [appDelegate.config.blackVCList containsObject:@"RootViewController"];;
     return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
