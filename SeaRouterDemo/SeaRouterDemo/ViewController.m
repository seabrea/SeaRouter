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

@property (weak, nonatomic) IBOutlet UITextField *inputView;
@property (weak, nonatomic) IBOutlet UILabel *fromCvalueLable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushVCBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if(sender.tag == 10000) {
        [SeaRouter openURL:@"app://A" withParams:@{}];
    }
    else if(sender.tag == 10001) {
        [SeaRouter openURL:@"app://B" withParams:@{@"code":self.inputView.text}];
    }
    else if(sender.tag == 10002) {
        
        void (^getCvalueBlock)(NSString *content) = ^(NSString *content){
            self.fromCvalueLable.text = content;
        };
        
        [SeaRouter openURL:@"app://C" withParams:@{@"Block":getCvalueBlock}];
    }
    else if(sender.tag == 10003) {
        [SeaRouter openURL:@"https://m.weibo.cn"];
    }
}

@end
