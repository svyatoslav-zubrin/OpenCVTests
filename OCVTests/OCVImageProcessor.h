//
//  OCVImageProcessor.h
//  OCVTests
//
//  Created by zubrin on 12/23/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCVImageProcessor : NSObject

+ (instancetype)sharedProcessor;
// hide some methods
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedProcessor instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedProcessor instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedProcessor instead")));


- (NSArray *)basicEffects;
- (NSArray *)detailedEffects;


@end
