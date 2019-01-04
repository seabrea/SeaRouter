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
    [SeaRouter registerURL:@"A" toHandler:^(NSDictionary * _Nonnull info) {
        
        AViewController *vc = [[AViewController alloc] init];
        [[SeaRouter keyViewController].navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    NSLog(@"已销毁%@",self);
}

@end
