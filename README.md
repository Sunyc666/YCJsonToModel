# YCJsonToModel
## 数模转换，直接生成model文件到桌面
### 目标：解决OC开发中，日常接口调试多字段数模转换费时费力的问题

## 使用教程（此处假数据依托于MJExtension进行 NSDictionary -> Json）
* (1)导入
```Objective-C
#import "MJExtension.h"
#import "YCJsonToModelProvider.h"
```
* (2)准备数据源(实战中将Json形式的接口数据传入步骤三中的方法即可)
```Objective-C
NSDictionary * jsonDicSubDic = @{
                                     @"msg":@"访问成功",
                                     @"data":@{
                                             @"userName":@"Sunyc",
                                             @"listData":@[
                                                     @{
                                                         @"money":@"1",
                                                         @"time":@"09:01",
                                                         @"smallName":@"Sunyc"
                                                         },
                                                     @{
                                                         @"money":@"2",
                                                         @"time":@"09:02",
                                                         @"smallName":@"Guan"
                                                         },
                                                     @{
                                                         @"money":@"3",
                                                         @"time":@"09:03",
                                                         @"smallName":@"Liu"
                                                         }
                                                     ],
                                             @"ycAnother":@[
                                                     @{
                                                         @"yc_money":@"1",
                                                         @"yc_time":@"09:01",
                                                         @"yc_smallName":@"Sunyc"
                                                         },
                                                     @{
                                                         @"yc_money":@"2",
                                                         @"yc_time":@"09:02",
                                                         @"yc_smallName":@"Guan"
                                                         },
                                                     @{
                                                         @"yc_money":@"3",
                                                         @"yc_time":@"09:03",
                                                         @"yc_smallName":@"Liu"
                                                         }
                                                     ]
                                             },
                                     @"code":@"200"
                                     };
```
* (3)调用方法生成对应的Model文件(此处默认生成文件地址为桌面，方便导入到工程)
```Objective-C
/**
     生成model文件入口
     
     @param className 类名
     @param jsonData 数据源
     @param mjSupport 是否支持 MJExtension
     */
    [YCModelFileMgr yc_jsonTomodelWithClassName:@"YCTestJsonDicSubDic" jsonData:jsonDicSubDic.mj_JSONString mjSupport:NO];
```

## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我(或联系QQ:987598765)，谢谢
* 如果在使用过程中发现功能不够用，希望你能Issues我(或联系QQ:987598765)，谢谢

## 致歉
* 由于我还没有准备好完全开源，还望使用者们勿怪。
