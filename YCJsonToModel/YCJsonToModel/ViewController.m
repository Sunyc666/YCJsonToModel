//
//  ViewController.m
//  YCJsonToModelFile
//
//  Created by sunyanchao on 2018/8/8.
//  Copyright © 2018年 pbph. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "YCJsonToModelProvider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
    NSDictionary * jsonDicArray = @{
                                    @"msg":@"访问成功",
                                    @"data":@[
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
                                    @"code":@"200"
                                    };
    
    
    NSDictionary * jsonStrArray = @{
                                    @"msg":@"访问成功",
                                    @"data":@[
                                            @"ABC",
                                            @"123"
                                            ],
                                    @"code":@"200"
                                    };
    
    /**
     生成model文件入口
     
     @param className 类名
     @param filePath 文件目标路径：需手动配置model文件上层目录路径
     @param jsonData 数据源
     @param mjSupport 是否支持 MJExtension
     */
    
    [YCModelFileMgr yc_jsonTomodelWithClassName:@"YCTest" filePath:@"/Users/sunyanchao/Desktop/" jsonData:jsonDicSubDic.mj_JSONString mjSupport:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
