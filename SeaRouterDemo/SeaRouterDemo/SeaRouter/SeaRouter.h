//
//  SeaRouter.h
//  SeaRouterDemo
//
//  Created by Bob on 2019/1/4.
//  Copyright © 2019年 seabrea. All rights reserved.
//

#import <UIKit/UIKit.h>

// info信息中URL值的KEY
extern NSString * const SEAROUTER_URL;
// info信息中获取当前控制器的KEY
extern NSString * const SEAROUTER_KEYVIEWCONTROLLER;
// 自定义Web控制器的lURL地址,注册自定义Web控制器的URL必须是这个固定URL
extern NSString * const SEAROUTER_CUSTOM_WEB_VC;

typedef void(^RouterBlock)(NSDictionary *info);

@interface SeaRouter : NSObject

/**
 * 注册Router，通常在响应控制器的 +(void)load 中添加
 *
 * @param  url     注册URL
 * @param  handler 保存的Block对象
 */
+ (void)registerURL:(NSString *)url toHandler:(void(^)(NSDictionary *info))handler;

/**
 * 路由访问
 *
 * @param  url    访问路径
 * @param  params 传入的参数
 */
+ (void)openURL:(NSString *)url withParams:(NSDictionary *)params;

/**
 * 路由访问
 *
 * @param  url    访问路径
 */
+ (void)openURL:(NSString *)url;

/**
 * 跨APP跳转
 *
 * @param  url    访问路径
 */
+ (void)openOtherAPPURL:(NSString *)url;

@end
