//
//  YJObject.h
//  WhatToEat
//
//  Created by Zhangguo Huang on 2017/12/23.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJObject : NSObject
@property (copy,nonatomic) NSString *name;
@property (nonatomic,strong) NSArray *names;
@property (nonatomic,strong) NSArray *imageNames;
@property (assign,nonatomic,getter=isSelected) BOOL selected;

+(instancetype)readWithName:(NSString *)name;
-(void)write;
-(instancetype)initWithName:(NSString *)name;
@end
