//
//  YJGroups.h
//  WhatToEat
//
//  Created by Zhangguo Huang on 2017/12/23.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "YJObject.h"

@interface YJGroups : YJObject
@property (strong,nonatomic) NSArray *elements;
+(instancetype)read;
@end
