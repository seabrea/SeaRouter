//
//  CViewController.m
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "CViewController.h"
#import "SeaRouter.h"

@interface CViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputView;
@property(nonatomic, copy) void (^inputBlock)(NSString *inputContent);

@end

@implementation CViewController

+ (void)load {
    
    [SeaRouter registerURL:@"app://C" toHandler:^(NSDictionary * _Nonnull info) {
        
        NSLog(@"C = %@",info);
        CViewController *vc = [[CViewController alloc] init];
        vc.inputBlock = info[@"Block"];
        [[SeaRouter keyViewController].navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onClickConfim:(id)sender {
    
    [self.inputView endEditing:YES];
    self.inputBlock(self.inputView.text);
}

- (void)dealloc {
    NSLog(@"已销毁%@",self);
}

@end
