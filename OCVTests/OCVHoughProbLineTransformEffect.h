//
//  OCVHoughProbLineTransformEffect.h
//  OCVTests
//
//  Created by zubrin on 12/23/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVEffectBase.h"

#import "OCVEffectParameter.h"

typedef enum OCVHoughProbLineTransformEffectParameterIndex {
    OCVHoughProbLineTransformEffectParameterIndex_CannyLowThreshold = 0,
    OCVHoughProbLineTransformEffectParameterIndex_CannyUpThreshold  = 1,
    OCVHoughProbLineTransformEffectParameterIndex_HoughAngle        = 2,
    OCVHoughProbLineTransformEffectParameterIndex_HoughThreshold    = 3,
    OCVHoughProbLineTransformEffectParameterIndex_Last = OCVHoughProbLineTransformEffectParameterIndex_HoughThreshold
} OCVHoughProbLineTransformEffectParameterIndex;


@interface OCVHoughProbLineTransformEffect : OCVEffectBase
- (UIImage *)applyOnImage:(UIImage *)sourceImage
    withCannyLowThreshold:(NSNumber *)cannyLow
         cannyUpThreshold:(NSNumber *)cannyUp
               houghAngle:(NSNumber *)houghAngle
           houghThreshold:(NSNumber *)houghThreshold;
@end
