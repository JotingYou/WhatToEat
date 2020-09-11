//
//  YJGroups.m
//  WhatToEat
//
//  Created by Zhangguo Huang on 2017/12/23.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "YJGroups.h"
#import "YJFoods.h"
@interface YJGroups()
@property (weak,nonatomic)YJAwardManager *awardManager;
@end
@implementation YJGroups
-(YJAwardManager *)awardManager{
    return [YJAwardManager shared];
}
-(instancetype)init{
    if (self = [super init]) {
        _groups = [[YJAwardManager shared] readGroups];
        if (_groups.count == 0) {
            _groups = @[[YJFoods food]];
        }
        
    }
    return self;
}
-(void)addGroupWith:(NSString *)name and:(NSString *)info{
    Group *g = [[YJAwardManager shared] insertGroup:name :info :true];    
    NSMutableArray *ma = [NSMutableArray arrayWithArray:self.groups];
    [ma addObject:g];
    self.groups = ma;
    
    [self save];
}
-(void)group:(Group *)group addPersonWithName:(NSString *)name Info:(NSString *)info Tel:(NSString *)tel{
    [self.awardManager insertPeople:name :info :tel:group];
    [self save];
}
+(instancetype)shared{
    static YJGroups *g;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g = [[self alloc] init];
    });
    return g;
}
-(void)deleteGroup:(Group *) group{
    for (People *p in group.members.allObjects) {
        [self.awardManager deletePeople:p];
    }
    [self.awardManager deleteGroup:group];
    
    NSMutableArray *ma = [NSMutableArray arrayWithArray:self.groups];
    [ma removeObject:group];
    self.groups = ma;
    
    [self save];
}
-(void)deletePerson:(People *)p{
    [self.awardManager deletePeople:p];
    [self save];
}
-(void)save{
    [self.awardManager save];
}
@end
