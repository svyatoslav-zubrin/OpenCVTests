//
//  OCVBlurEffect.m
//  OCVTests
//
//  Created by zubrin on 12/16/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVBlurEffect.h"
#import "OCVEffectBase+Helpers.h"


@implementation OCVBlurEffect

- (UIImage *)applyOnImage:(UIImage *)sourceImage
{
    cv::Mat originalMat = [self cvMatFromUIImage:sourceImage];
    cv::Mat resultMat;
    cv::blur(originalMat, resultMat, cv::Size(25,25));
    return [self UIImageFromCVMat:resultMat];
    
}

@end
