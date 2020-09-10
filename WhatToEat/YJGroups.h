//
//  YJGroups.h
//  WhatToEat
//
//  Created by Zhangguo Huang on 2017/12/23.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "YJObject.h"
#import <WhatToEat-Swift.h>
@interface YJGroups : NSObject
@property (strong,nonatomic) NSArray *groups;
+(instancetype)shared;
-(void)addGroupWith:(NSString *)name and:(NSString *)info;
-(void)group:(Group *) group addPersonWithName:(NSString *)name Info:(NSString *)info;
-(void)deleteGroup:(Group *) group;
-(void)deletePerson:(People *)p;
@end
