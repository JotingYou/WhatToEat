//
//  YJResultManager.h
//  WhatToEat
//
//  Created by joting on 2020/9/1.
//  Copyright © 2020 Joting. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJGroups;
@class YJResultController;
NS_ASSUME_NONNULL_BEGIN

@interface YJResultManager : NSObject
@property NSInteger firstNumber;
@property NSInteger secondNumber;
@property NSInteger thirdNumber;
@property (nonatomic,strong) NSMutableArray *first;
@property (nonatomic,strong) NSMutableArray *second;
@property (nonatomic,strong) NSMutableArray *third;
@property (nonatomic,strong) YJResultController *resultController;
-(void)saveResult;
+(instancetype)shared;
-(Boolean)add:(NSObject *)o;
-(Boolean)addToFirst:(NSObject *)o;
-(Boolean)addToSecond:(NSObject *)o;
-(Boolean)addToThird:(NSObject *)o;
@end

NS_ASSUME_NONNULL_END
