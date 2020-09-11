//
//  YJResultManager.m
//  WhatToEat
//
//  Created by joting on 2020/9/1.
//  Copyright © 2020 Joting. All rights reserved.
//

#import "YJResultManager.h"
#import "YJGroups.h"
#import "YJResultController.h"
#import <WhatToEat-Swift.h>
@interface YJResultManager()
@property (weak,nonatomic) YJAwardManager *awardManager;
@end
@implementation YJResultManager
-(YJAwardManager *)awardManager{
    return [YJAwardManager shared];
}
-(instancetype)init{
    if (self = [super init]) {
        _firstNumber = 1;
        _secondNumber = 2;
        _thirdNumber = 3;
    }
    return self;
}
+(instancetype)shared{
    static YJResultManager *sharedInstace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[self alloc] init];
    });
    return sharedInstace;
}
-(YJResultController *)resultController{
    if (!_resultController) {
        _resultController = [[YJResultController alloc]init];
    }
    return _resultController;
}
-(NSMutableArray *)first{
    if (!_first) {
        _first = [NSMutableArray array];
    }
    return _first;
}
-(NSMutableArray *)second{
    if (!_second) {
        _second = [NSMutableArray array];
    }
    return _second;
}
-(NSMutableArray *)third{
    if (!_third) {
        _third = [NSMutableArray array];
    }
    return _third;
}
-(Boolean)add:(NSObject *)o{
    if ([self addToThird:o]) {
        return true;
    }
    if ([self addToSecond:o]) {
        return true;
    }
    if ([self addToFirst:o]) {
        return true;
    }
    return false;
}
-(Boolean)addToFirst:(NSObject *)o{
    if (self.first.count < self.firstNumber) {
        [self.first addObject:o];
        return true;
    }
    return false;
}
-(Boolean)addToSecond:(NSObject *)o{
    if (self.second.count < self.secondNumber) {
        [self.second addObject:o];
        return true;
    }
    return false;
}
-(Boolean)addToThird:(NSObject *)o{
    if (self.third.count < self.thirdNumber) {
        [self.third addObject:o];
        return true;
    }
    return false;
}
-(void)saveResult{
    Record *r = [self.awardManager insertRecord];
    for (People *p in self.third) {
        [self.awardManager insertHonoree:3 :p :r];
    }
    for (People *p in self.second) {
        [self.awardManager insertHonoree:2 :p :r];
    }
    for (People *p in self.first) {
        [self.awardManager insertHonoree:1 :p :r];
    }
    [self.awardManager save];
}
@end
