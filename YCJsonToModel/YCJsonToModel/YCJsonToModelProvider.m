//
//  YCJsonToModelProvider.m
//  YCJsonToModel
//
//  Created by yc on 2021/3/16.
//  Copyright © 2021 syc. All rights reserved.
//

#import "YCJsonToModelProvider.h"


@implementation YCJsonToModelProvider

/// 生成model文件入口
/// @param className 类名
/// @param superClassName 父类名称：如果填写则继承，否则继承 NSObject
/// @param filePath 文件目标路径：需手动配置 model 文件上层目录路径
/// @param jsonData json数据源
/// @param multipleFiles 是否生成多个 model 文件
+(void)yc_jsonToModelWithClassName:(NSString *)className
                    superClassName:(NSString *)superClassName
                          filePath:(NSString *)filePath
                          jsonData:(NSString *)jsonData
                     multipleFiles:(BOOL)multipleFiles
{
    
    //1.判断传入的数据源是否为json数据
    NSDictionary *jsonDic = [YCJsonToModelTools getJsonDicWithJsonData:jsonData];
    if (!jsonDic)
    {
        [YCJsonToModelTools errorLogWithDes:@"数据源不合法：请传入json"];
        return;
    }
    
    //2.数据源正常则进行后续处理
    //2.1生成 .h 文件代码
    NSDictionary *allHFileContentDic = [YCHFileMgr autoCodeHFileWithJsonDic:jsonDic className:className superClassName:superClassName];
    NSLog(@"%@",allHFileContentDic);
    // 2.2生成多个 model 文件
    if (multipleFiles)
    {
        NSDictionary *multipleDic = allHFileContentDic[@"respectivelyContent"];
        NSArray *allNameArr = [multipleDic allKeys];
        for (NSString *className in allNameArr) {
            
            //1.获取 .h 文件头部注释部分内容
            NSString *h_headerAnnotation = [YCJsonToModelFileHeaderMgr getFileHeaderAnnotationWithClassName:[NSString stringWithFormat:@"%@.h",className]];
            
            //2.创建文件并写入
            NSString *h_className   = [NSString stringWithFormat:@"%@.h",className];
            
            NSString * h_pack_fileContent = [YCJsonToModelHFileMgr packingInFormat:multipleDic[className] superClassName:superClassName];
            
            NSString *h_fileContent = [NSString stringWithFormat:@"%@\n%@",h_headerAnnotation,h_pack_fileContent];
            
            [YCJsonToModelTools creatFileWithClassName:h_className
                                           fileContent:h_fileContent];
            
            //3.依据 .h 文件内容生成 .m 的内容
            NSString *m_className = [NSString stringWithFormat:@"%@.m",className];
            NSString *m_headerAnnotation = [YCJsonToModelFileHeaderMgr getFileHeaderAnnotationWithClassName:m_className];
            NSString *m_fileContent = [YCJsonToModelMFileMgr autoCodeMFileWithClassName:className combinationModelNameArr:nil];
            m_fileContent = [NSString stringWithFormat:@"%@\n%@",m_headerAnnotation,m_fileContent];
            
            [YCJsonToModelTools creatFileWithClassName:m_className
                                           fileContent:m_fileContent];
        }
    }else
    {
        className = [YCJsonToModelTools appendModelStrWithOldStr:className];
        NSString *h_className      = [NSString stringWithFormat:@"%@.h",className];
        
        NSString * h_pack_fileContent = [YCJsonToModelHFileMgr packingInFormat:allHFileContentDic[@"allContent"] superClassName:superClassName];
        
        NSString *headerAnnotation = [YCJsonToModelFileHeaderMgr getFileHeaderAnnotationWithClassName:h_className];
        NSString *h_classContent   = [NSString stringWithFormat:@"%@\n%@",headerAnnotation,h_pack_fileContent];
        
        
        [YCJsonToModelTools creatFileWithClassName:[NSString stringWithFormat:@"%@.h",className]
                                       fileContent:h_classContent];
        
     
        //2.2生成 .m 文件代码
        NSString *m_className = [NSString stringWithFormat:@"%@.m",className];
        NSString *m_headerAnnotation = [YCJsonToModelFileHeaderMgr getFileHeaderAnnotationWithClassName:m_className];
        
        NSDictionary *multipleDic = allHFileContentDic[@"respectivelyContent"];
        NSArray *allNameArr = [multipleDic allKeys];
        
        NSString *m_fileContent = [YCJsonToModelMFileMgr autoCodeMFileWithClassName:className combinationModelNameArr:allNameArr];
        
        m_fileContent = [NSString stringWithFormat:@"%@\n%@",m_headerAnnotation,m_fileContent];
        
        [YCJsonToModelTools creatFileWithClassName:m_className
                                       fileContent:m_fileContent];
        
    }
    
}


@end
