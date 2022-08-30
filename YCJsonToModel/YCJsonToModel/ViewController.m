//
//  ViewController.m
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//

#import "ViewController.h"
#import "YCJsonToModelProvider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary * jsonDicSubDic = @{
    @"msg":@"访问成功",
    @"data":@{
            @"userName":@"Sunyc",
            @"listData":@[
                    @{
                        @"money":@1,
                        @"time":@"09:01",
                        @"smallName":@"Sunyc"
                        },
                    @{
                        @"money":@2,
                        @"time":@"09:02",
                        @"smallName":@"Guan"
                        },
                    @{
                        @"money":@3,
                        @"time":@"09:03",
                        @"smallName":@"Liu"
                        }
                    ],
            @"ycAnother":@[
                    @{
                        @"yc_money":@1,
                        @"yc_time":@"09:01",
                        @"yc_smallName":@"Sunyc"
                        },
                    @{
                        @"yc_money":@2,
                        @"yc_time":@"09:02",
                        @"yc_smallName":@"Guan"
                        },
                    @{
                        @"yc_money":@3,
                        @"yc_time":@"09:03",
                        @"yc_smallName":@"Liu"
                        }
                    ]
            },
    @"code":@"200",
    };
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ycTestJson" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

//    NSLog(@"%@",contentDic);

    [YCJsonToModelProvider yc_jsonToModelWithClassName:@"YCTest"
                                        superClassName:@""
                                              filePath:@"/Users/a/Desktop/"
                                              jsonData:content
                                         multipleFiles:YES];
}


@end
