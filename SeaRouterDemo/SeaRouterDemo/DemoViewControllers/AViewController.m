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
        
        UIViewController *keyViewController = info[SeaRouterKeyViewController];
        AViewController *vc = [[AViewController alloc] init];
        [keyViewController.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
