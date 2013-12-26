//
// Created by zubrin on 12/17/13.
// Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVHoughCircleTransformEffect.h"
#import "OCVEffectBase+Helpers.h"

#import <cmath>


@implementation OCVHoughCircleTransformEffect

- (UIImage *)applyOnImage:(UIImage *)sourceImage
{
    cv::Mat originalMat = [self cvMatFromUIImage:sourceImage];
    cv::Mat resultMat;
    // prepare for hough circle transform
    cv::cvtColor(originalMat, resultMat, CV_BGR2GRAY);
    cv::GaussianBlur(resultMat, resultMat, cv::Size(9, 9), 2, 2);
    // get circles
    cv::vector<cv::Vec3f> circles;
    cv::HoughCircles(resultMat, circles, CV_HOUGH_GRADIENT, 1, originalMat.rows/50);
    // draw circles on the original image
    resultMat = originalMat;
    for (size_t i = 0; i < circles.size(); i++)
    {
        cv::Point center(cvRound(circles[i][0]),
                         cvRound(circles[i][1]));
        int radius = cvRound(circles[i][2]);
        cv::circle(resultMat, center, radius, cv::Scalar(0, 0, 0), 3);
    }
    return [self UIImageFromCVMat:resultMat];
}

@end