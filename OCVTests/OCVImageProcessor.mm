//
//  OCVImageProcessor.m
//  OCVTests
//
//  Created by zubrin on 12/23/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVImageProcessor.h"

#import "OCVEffectBase.h"
#import "OCVGrayscaleEffect.h"
#import "OCVBlurEffect.h"
#import "OCVErodeEffect.h"
#import "OCVDilateEffect.h"
#import "OCVHoughCircleTransformEffect.h"
#import "OCVHoughLinesTransformEffect.h"
#import "OCVHoughProbLineTransformEffect.h"


@interface OCVImageProcessor ()

@property (nonatomic, strong) NSArray *bEffects, *dEffects;

@end


@implementation OCVImageProcessor

+ (instancetype)sharedProcessor
{
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
        
    });
    return shared;
}

- (id)initUniqueInstance
{
    self = [super init];
    if (self) {
        self.bEffects = [NSArray arrayWithObjects:
                         [[OCVEffectBase alloc] initWithName:@"None"],
                         [[OCVGrayscaleEffect alloc] initWithName:@"Grayscale"],
                         [[OCVBlurEffect alloc] initWithName:@"Blur"],
                         [[OCVErodeEffect alloc] initWithName:@"Erode"],
                         [[OCVDilateEffect alloc] initWithName:@"Dilate"],
                         [[OCVHoughCircleTransformEffect alloc] initWithName:@"Hough circle tansform"],
                         [[OCVHoughLinesTransformEffect alloc] initWithName:@"Hough lines tansform"],
                         [[OCVHoughProbLineTransformEffect alloc] initWithName:@"Hough prob. lines tansform"],
                         nil];
        self.dEffects = [NSArray arrayWithObjects:
//                         [[OCVEffectBase alloc] initWithName:@"None"],
//                         [[OCVGrayscaleEffect alloc] initWithName:@"Grayscale"],
//                         [[OCVBlurEffect alloc] initWithName:@"Blur"],
//                         [[OCVErodeEffect alloc] initWithName:@"Erode"],
//                         [[OCVDilateEffect alloc] initWithName:@"Dilate"],
//                         [[OCVHoughCircleTransformEffect alloc] initWithName:@"Hough circle tansform"],
                         [[OCVHoughLinesTransformEffect alloc] initWithName:@"Hough lines tansform"],
                         [[OCVHoughProbLineTransformEffect alloc] initWithName:@"Hough prob. lines tansform"],
                         nil];
        
    }
    return self;
}

#pragma mark - Public methods

- (NSArray *)basicEffects
{
    return self.bEffects;
}

- (NSArray *)detailedEffects
{
    return self.dEffects;
}

@end
