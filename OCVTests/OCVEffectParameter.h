//
//  OCVEffectParameter.h
//  OCVTests
//
//  Created by zubrin on 12/23/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCVEffectParameter : NSObject
@property (nonatomic, strong) NSNumber *min, *max, *def;
@property (nonatomic, strong) NSString *name;
@end
