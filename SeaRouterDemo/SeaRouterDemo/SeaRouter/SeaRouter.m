//
//  SeaRouter.m
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import "SeaRouter.h"

NSString * const SeaRouterKeyViewController = @"keyViewController";

@interface SeaRouter()

@property (nonatomic, strong) NSMutableDictionary *routerMap;

@end

@implementation SeaRouter

#pragma mark - Public Methods

+ (void)registerURL:(NSString *)url toHandler:(RouterBlock)handler {
    [[SeaRouter sharedInstance] registerURL:url toHandler:handler];
}

+ (void)openURL:(NSString *)url withParams:(NSDictionary *)params {
    [[SeaRouter sharedInstance] openURL:url withParams:params];
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

- (NSMutableDictionary *)routerMap {
    if (!_routerMap) {
        _routerMap = [[NSMutableDictionary alloc] init];
    }
    return _routerMap;
}

@end
