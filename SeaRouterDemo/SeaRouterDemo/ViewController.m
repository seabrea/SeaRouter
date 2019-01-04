//
//  ViewController.m
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "ViewController.h"
#import "SeaRouter/SeaRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushVCBtn:(UIButton *)sender {
    
    if([sender.titleLabel.text isEqualToString:@"A"]) {
        [SeaRouter openURL:@"A" withParams:nil];
    }
    else if([sender.titleLabel.text isEqualToString:@"B"]) {
        [SeaRouter openURL:@"B" withParams:@{@"code":@"123"}];
    }
}

@end
