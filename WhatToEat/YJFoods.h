//
//  YJFoods.h
//  WhatToEat
//
//  Created by 姚家庆 on 2017/8/1.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJFoods : NSObject
@property (nonatomic,strong) NSArray *names;
@property (nonatomic,strong) NSArray *imageNames;
-(void)read;
-(void)write;
@end
