![LOGO](https://raw.githubusercontent.com/seabrea/SeaRouter/master/SeaRouter.png)

# SeaRouter

![](https://img.shields.io/badge/platform-iOS%209%2B-orange.svg)
![](https://img.shields.io/badge/language-objective--c-blue.svg)
![](https://img.shields.io/badge/license-MIT-ff69b4.svg)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-green.svg?style=flat)](https://cocoapods.org)

SeaRouter是一个简洁的 iOS Router。

## Demo

[Demo项目](https://github.com/seabrea/SeaRouter)

## Installation
支持Cocoapods:

`pod 'SeaRouter'`

## Usage

具体使用可参考Demo项目

SeaRouter主要用于iOS中页面跳转，用于对高耦合的控制器之间的解耦。

首先在需要响应的控制器中注册

```
/**
 * AViewController.m
 */
+ (void)load {
    [SeaRouter registerURL:@"app://A" toHandler:^(NSDictionary * _Nonnull info) {
        
        AViewController *vc = [[AViewController alloc] init];
        [[SeaRouter keyViewController].navigationController pushViewController:vc animated:YES];
    }];
}
```

之后在其他控制器中可以直接使用URL跳转对应的控制器

```
/**
 * 路由跳转
 *
 * @param  url    访问路径
 * @param  params 传递给跳转对象的数据
 */
[SeaRouter openURL:@"app://B" withParams:@{@"code":@"123"}];
```

在不需要传值的时候也可以直接用  

```
+ (void)openURL:(NSString *)url;
```

也可以直接使用SeaRouter打开一个 Web URL

```
[SeaRouter openURL:@"https://m.weibo.cn"];
```

如果你没有先注册好显示用的自定义WebController，那么SeaRouter会自定打开一个默认的控制器用于显示Web内容。

如果你需要自定义一个Web控制器，请使用SeaRouter提供的`SEAROUTER_CUSTOM_WEB_VC `作为注册URL

```
[SeaRouter registerURL:SEAROUTER_CUSTOM_WEB_VC toHandler:^(NSDictionary *info) {
        
        WebViewController *webvc = [[WebViewController alloc] init];
        webvc.url = info[SEAROUTER_URL];
        [[SeaRouter keyViewController].navigationController pushViewController:webvc animated:YES];
    }];
```

其中`SEAROUTER_URL`也是SeaRouter提供的字符串，作为`info`的Key值.

SeaRouter提供打开Web的原因是:方便线上紧急处理有bug的相关页面，可以定制一张包含所有APP内跳转URL信息的表，由服务器提供，当线上APP某个模块出现致命bug的时候，可以让服务端修改这个表，将对应的URL改为一个暂时替用的WebURL，这样用户打开APP的时候，进入相关模块将不会跳转入有bug的页面，而是直接打开一个没有bug的web的页面。

## Author

[SeaBrea](https://seabrea.xyz)

有什么问题或者好的建议可以联系我 <hgdigm@gmail.com>

## License

SeaRouter is available under the MIT license. See the LICENSE file for more info.
