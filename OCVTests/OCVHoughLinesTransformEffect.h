//
//  OCVHoughLinesTransformEffect.h
//  OCVTests
//
//  Created by zubrin on 12/23/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVEffectBase.h"

#import "OCVEffectParameter.h"

typedef enum OCVHoughLineTransformEffectParameterIndex {
    OCVHoughLineTransformEffectParameterIndex_CannyLowThreshold = 0,
    OCVHoughLineTransformEffectParameterIndex_CannyUpThreshold  = 1,
    OCVHoughLineTransformEffectParameterIndex_HoughAngle        = 2,
    OCVHoughLineTransformEffectParameterIndex_HoughThreshold    = 3,
    OCVHoughLineTransformEffectParameterIndex_Last = OCVHoughLineTransformEffectParameterIndex_HoughThreshold
} OCVHoughLineTransformEffectParameterIndex;


@interface OCVHoughLinesTransformEffect : OCVEffectBase
- (UIImage *)applyOnImage:(UIImage *)sourceImage
    withCannyLowThreshold:(NSNumber *)cannyLow
         cannyUpThreshold:(NSNumber *)cannyUp
               houghAngle:(NSNumber *)houghAngle
           houghThreshold:(NSNumber *)houghThreshold;
@end
