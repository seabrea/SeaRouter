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
NSString * const SEAROUTER_KEYVIEWCONTROLLER = @"SeaRouterKeyViewController";
NSString * const SEAROUTER_CUSTOM_WEB_VC = @"app://CustomWebViewController";

@interface SeaRouter()
// 储存 URL和Block 映射关系的全局字典
@property (nonatomic, strong) NSMutableDictionary *routerMap;

@end

@implementation SeaRouter

#pragma mark - Public Methods

+ (void)registerURL:(NSString *)url toHandler:(RouterBlock)handler {
    [[SeaRouter sharedInstance] registerURL:url toHandler:handler];
}

+ (id)openURL:(NSString *)url withParams:(NSDictionary *)params {
    return [[SeaRouter sharedInstance] openURL:url withParams:params];
}

+ (id)openURL:(NSString *)url {
    return [SeaRouter openURL:url withParams:nil];
}

+ (void)openOtherAPPURL:(NSString *)url {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:nil];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    }
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

- (id)openURL:(NSString *)url withParams:(NSDictionary *)params {
    
    UIViewController *keyVC = [self keyViewController];
    
    NSMutableDictionary *newParams = params ? [[NSMutableDictionary alloc] initWithDictionary:params] : @{}.mutableCopy;
    newParams[SEAROUTER_KEYVIEWCONTROLLER] = keyVC;
    
    return [self parsingURL:url withParams:newParams];
}

- (id)parsingURL:(NSString *)url withParams:(NSMutableDictionary *)params {
    
    if([url rangeOfString:@"://"].location == NSNotFound) {
        // 不符合路由格式
        return nil;
    }
    
    if([url hasPrefix:@"http"] ||
       [url hasPrefix:@"https"]) {
        // 跳转Web界面
        RouterBlock webBlock = [self.routerMap objectForKey:SEAROUTER_CUSTOM_WEB_VC];
        if(!webBlock) {
            [[self keyViewController].navigationController pushViewController:[self makeWebController:[NSURL URLWithString:url]] animated:YES];
        }
        else {
            params[SEAROUTER_URL] = url;
            webBlock(params.copy);
        }
        return nil;
    }
    
    // 取出已注册的URL中的Block对象
    RouterBlock handlerBlock = [self.routerMap objectForKey:url];
    if(!handlerBlock) {
        return nil;
    }
    
    [params setObject:url forKey:SEAROUTER_URL];
    return handlerBlock(params.copy);
}

- (UIViewController *)makeWebController:(NSURL *)URL {
    
    UIViewController *webVC = [[UIViewController alloc] init];
    webVC.view.backgroundColor = [UIColor whiteColor];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:webVC.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:URL]];
    [webVC.view addSubview:webView];
    
    return webVC;
}

- (UIViewController *)keyViewController {
    
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


#pragma mark - Getter

- (NSMutableDictionary *)routerMap {
    if (!_routerMap) {
        _routerMap = [[NSMutableDictionary alloc] init];
    }
    return _routerMap;
}

@end
