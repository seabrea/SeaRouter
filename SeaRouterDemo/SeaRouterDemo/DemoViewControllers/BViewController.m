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

@property (weak, nonatomic) IBOutlet UILabel *showContentLabel;
@property(nonatomic, copy) NSString *code;

@end

@implementation BViewController

+ (void)load {
    [SeaRouter registerURL:@"app://B" toHandler:^(NSDictionary * _Nonnull info) {
        
        NSLog(@"B = %@",info);
        BViewController *vc = [[BViewController alloc] init];
        [[SeaRouter keyViewController].navigationController pushViewController:vc animated:YES];
        vc.code = [info[@"code"] description];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showContentLabel.text = self.code;
}

- (void)dealloc {
    NSLog(@"已销毁%@",self);
}

@end
