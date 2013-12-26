//
//  OCVEffect.h
//  OCVTests
//
//  Created by zubrin on 12/16/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCVEffectBase : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *parameters;

- (id)initWithName:(NSString *)name;
- (UIImage *)applyOnImage:(UIImage *)sourceImage;

@end
