//
//  BViewController.m
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "BViewController.h"
#import "SeaRouter.h"

@interface BViewController ()

@end

@implementation BViewController

+ (void)load {
    [SeaRouter registerURL:@"B" toHandler:^(NSDictionary * _Nonnull info) {
        
        UIViewController *keyViewController = info[SeaRouterKeyViewController];
        BViewController *vc = [[BViewController alloc] init];
        [keyViewController.navigationController pushViewController:vc animated:YES];
        NSLog(@"Dic = %@",info);
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
