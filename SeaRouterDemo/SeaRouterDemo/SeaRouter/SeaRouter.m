//
//  SeaRouter.m
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "SeaRouter.h"

typedef void(^RouterBlock)(NSDictionary *info);

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
    [self.routerMap setObject:handler forKey:url];
}

- (void)openURL:(NSString *)url withParams:(NSDictionary *)params {
    
    RouterBlock handlerBlock = [self.routerMap objectForKey:url];
    NSMutableDictionary *info = params ? [[NSMutableDictionary alloc] initWithDictionary:params] : @{}.mutableCopy;
    handlerBlock(info);
}


#pragma mark - Getter

- (NSMapTable *)routerMap {
    if (!_routerMap) {
        _routerMap = [NSMapTable strongToWeakObjectsMapTable];
    }
    return _routerMap;
}

@end
