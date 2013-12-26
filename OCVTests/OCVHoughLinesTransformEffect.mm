//
//  OCVHoughLinesTransformEffect.m
//  OCVTests
//
//  Created by zubrin on 12/23/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVHoughLinesTransformEffect.h"
#import "OCVEffectBase+Helpers.h"

#import <cmath>


@implementation OCVHoughLinesTransformEffect

- (UIImage *)applyOnImage:(UIImage *)sourceImage
{
    cv::Mat originalMat = [self cvMatFromUIImage:sourceImage];
    cv::Mat resultMat, cannyMat;
    // prepare for hough lines transform
//    cv::GaussianBlur(originalMat, resultMat, cv::Size(9, 9), 2, 2);
    
//    cv::Sobel(originalMat, cannyMat, CV_8U, 1, 0);
//    cv::cvtColor(cannyMat, cannyMat, CV_BGR2GRAY);
    
    cv::Canny(originalMat, cannyMat, 100, 200, 3, true);

//    return [self UIImageFromCVMat:cannyMat];

//    cv::cvtColor(cannyMat, resultMat, CV_GRAY2BGR);
    // get lines
    cv::vector<cv::Vec2f> lines;
    cv::HoughLines(cannyMat, lines, 1, CV_PI/360, 250);
    // draw lines on the original image
    resultMat = originalMat;
    for (size_t i = 0; i < lines.size(); i++)
    {
        float rho   = lines[i][0];
        float theta = lines[i][1];
        cv::Point pt1, pt2;
        double a = cos(theta);
        double b = sin(theta);
        double x0 = a * rho, y0 = b * rho;
        pt1.x = cvRound(x0 + 1000 * (-b));
        pt1.y = cvRound(y0 + 1000 * ( a));
        pt2.x = cvRound(x0 - 1000 * (-b));
        pt2.y = cvRound(y0 - 1000 * ( a));
        cv::line(resultMat, pt1, pt2, cv::Scalar(0, 0, 255));
    }
    
    return [self UIImageFromCVMat:resultMat];
}

@end
