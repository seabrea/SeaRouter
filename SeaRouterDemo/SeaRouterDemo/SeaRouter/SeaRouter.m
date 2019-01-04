//
//  SeaRouter.m
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "SeaRouter.h"
#import <WebKit/WKWebView.h>

NSString * const SEAROUTER_URL = @"SeaRouterURL";
NSString * const SEAROUTER_CUSTOM_WEB_VC = @"app://CustomWebViewController";

@interface SeaRouter()

@property (nonatomic, strong) NSMapTable *routerMap;

@end

@implementation SeaRouter

#pragma mark - Public Methods

+ (void)registerURL:(NSString *)url toHandler:(RouterBlock)handler {
    [[SeaRouter sharedInstance] registerURL:url toHandler:handler];
}

+ (void)openURL:(NSString *)url withParams:(NSDictionary *)params {
    [[SeaRouter sharedInstance] openURL:url withParams:params];
}

+ (void)openURL:(NSString *)url {
    [SeaRouter openURL:url withParams:nil];
}

+ (void)openOtherAPPURL:(NSString *)url {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:nil];
    }
}

+ (UIViewController *)keyViewController {

    UIViewController* currentViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        }
        else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        }
        else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        }
        else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            }
            else {
                
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

#pragma mark - Lify Cycle

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SeaRouter *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}


#pragma mark - Private Methods

- (void)registerURL:(NSString *)url toHandler:(RouterBlock)handler {
    [self.routerMap setObject:[handler copy] forKey:url];
}

- (void)openURL:(NSString *)url withParams:(NSDictionary *)params {
    [self parsingURL:url withParams:params];
}

- (void)parsingURL:(NSString *)url withParams:(NSDictionary *)params {
    
    if([url rangeOfString:@"://"].location == NSNotFound) {
        // 不符合路由格式
        return;
    }
    
    
    
    if([url hasPrefix:@"http"] ||
       [url hasPrefix:@"https"]) {
        // 跳转Web界面
        RouterBlock webBlock = [self.routerMap objectForKey:SEAROUTER_CUSTOM_WEB_VC];
        if(!webBlock) {
            [[SeaRouter keyViewController].navigationController pushViewController:[self makeWebController:[NSURL URLWithString:url]] animated:YES];
        }
        else {
            webBlock(@{SEAROUTER_URL:url});
        }
        return;
    }
    
    // 取出已注册的URL中的Block对象
    RouterBlock handlerBlock = [self.routerMap objectForKey:url];
    
    NSMutableDictionary *info = params ? [[NSMutableDictionary alloc] initWithDictionary:params] : @{}.mutableCopy;
    [info setObject:url forKey:SEAROUTER_URL];
    handlerBlock(info.copy);
}

- (UIViewController *)makeWebController:(NSURL *)URL {
    
    UIViewController *webVC = [[UIViewController alloc] init];
    webVC.view.backgroundColor = [UIColor whiteColor];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:webVC.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:URL]];
    [webVC.view addSubview:webView];
    
    return webVC;
}


#pragma mark - Getter

- (NSMapTable *)routerMap {
    if (!_routerMap) {
        _routerMap = [NSMapTable strongToWeakObjectsMapTable];
    }
    return _routerMap;
}

@end
