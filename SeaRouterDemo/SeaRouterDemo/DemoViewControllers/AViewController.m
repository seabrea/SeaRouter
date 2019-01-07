//
//  AViewController.m
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "AViewController.h"
#import "SeaRouter.h"

@interface AViewController ()

@end

@implementation AViewController

+ (void)load {
    [SeaRouter registerURL:@"app://A" toHandler:^(NSDictionary * _Nonnull info) {
        
        NSLog(@"A = %@",info);
        AViewController *vc = [[AViewController alloc] init];
        UINavigationController *navi = ((UIViewController *)info[SEAROUTER_KEYVIEWCONTROLLER]).navigationController;
        [navi pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    NSLog(@"已销毁%@",self);
}

@end
