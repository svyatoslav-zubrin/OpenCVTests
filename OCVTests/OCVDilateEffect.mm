//
//  OCVDilateEffect.m
//  OCVTests
//
//  Created by zubrin on 12/16/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVDilateEffect.h"

@implementation OCVDilateEffect

- (UIImage *)applyOnImage:(UIImage *)sourceImage
{
    cv::Mat originalMat = [self cvMatFromUIImage:sourceImage];
    cv::Mat resultMat;
    int erode_size = 24;
    cv::Mat erodeKernel = cv::getStructuringElement(cv::MORPH_ELLIPSE,
                                                    cv::Size(erode_size, erode_size),
                                                    cv::Point(erode_size/2, erode_size/2));
    cv::dilate(originalMat, resultMat, erodeKernel);
    return [self UIImageFromCVMat:resultMat];
}

@end
