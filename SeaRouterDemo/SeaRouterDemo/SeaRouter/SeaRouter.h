//
//  SeaRouter.h
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const SeaRouterKeyViewController;

typedef void(^RouterBlock)(NSDictionary *info);

@interface SeaRouter : NSObject

+ (void)registerURL:(NSString *)url toHandler:(RouterBlock)handler;

+ (void)openURL:(NSString *)url withParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
