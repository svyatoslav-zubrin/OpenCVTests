//
//  OCVGrayscaleEffect.m
//  OCVTests
//
//  Created by zubrin on 12/16/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVGrayscaleEffect.h"
#import "OCVEffectBase+Helpers.h"


@implementation OCVGrayscaleEffect

- (UIImage *)applyOnImage:(UIImage *)sourceImage
{
    cv::Mat originalMat = [self cvMatFromUIImage:sourceImage];
    cv::Mat resultMat;
    cv::cvtColor(originalMat, resultMat, CV_BGR2GRAY);
    return [self UIImageFromCVMat:resultMat];
}

@end
