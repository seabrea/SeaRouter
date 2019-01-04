//
//  SeaRouter.h
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeaRouter : NSObject

+ (void)registerURL:(NSString *)url toHandler:(void(^)(NSDictionary *info))handler;

+ (void)openURL:(NSString *)url withParams:(NSDictionary *)params;

+ (UIViewController *)keyViewController;

@end

NS_ASSUME_NONNULL_END
