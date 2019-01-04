//
//  WebViewController.m
//  SeaRouterDemo
//
//  Created by He Bob on 2019/1/5.
//  Copyright © 2019 seabrea. All rights reserved.
//

#import "WebViewController.h"
#import "SeaRouter.h"
#import <WebKit/WKWebView.h>

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (nonatomic, strong) NSString *url;

@end

@implementation WebViewController

+ (void)load {
    
    [SeaRouter registerURL:SEAROUTER_CUSTOM_WEB_VC toHandler:^(NSDictionary *info) {
        
        WebViewController *webvc = [[WebViewController alloc] init];
        webvc.url = info[SEAROUTER_URL];
        [[SeaRouter keyViewController].navigationController pushViewController:webvc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义Web控制器";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
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
