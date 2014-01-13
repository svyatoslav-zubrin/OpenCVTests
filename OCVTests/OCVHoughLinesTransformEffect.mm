//
//  OCVHoughLinesTransformEffect.m
//  OCVTests
//
//  Created by zubrin on 12/23/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVHoughLinesTransformEffect.h"

#import "OCVEffectBase+Helpers.h"
#import "OCVEffectParameter.h"

#import <cmath>


@implementation OCVHoughLinesTransformEffect

- (id)initWithName:(NSString *)name
{
    self = [super initWithName:name];
    if (self)
    {
        OCVEffectParameter *cannyLowThreshold = [[OCVEffectParameter alloc] init];
        cannyLowThreshold.name = @"Canny Low Threshold";
        cannyLowThreshold.min  = [NSNumber numberWithInt:1];
        cannyLowThreshold.max  = [NSNumber numberWithInt:400];
        cannyLowThreshold.def  = [NSNumber numberWithInt:50];
        
        OCVEffectParameter *cannyUpThreshold = [[OCVEffectParameter alloc] init];
        cannyUpThreshold.name = @"Canny Up Threshold";
        cannyUpThreshold.min  = [NSNumber numberWithInt:1];
        cannyUpThreshold.max  = [NSNumber numberWithInt:400];
        cannyUpThreshold.def  = [NSNumber numberWithInt:200];
        
        OCVEffectParameter *houghLinesThreshold = [[OCVEffectParameter alloc] init];
        houghLinesThreshold.name = @"Hough Lines Threshold";
        houghLinesThreshold.min  = [NSNumber numberWithInt:1];
        houghLinesThreshold.max  = [NSNumber numberWithInt:200];
        houghLinesThreshold.def  = [NSNumber numberWithInt:75];
        
        OCVEffectParameter *houghLinesAngle = [[OCVEffectParameter alloc] init];
        houghLinesAngle.name = @"Hough Lines Angle";
        houghLinesAngle.min  = [NSNumber numberWithFloat:0];
        houghLinesAngle.max  = [NSNumber numberWithFloat:CV_PI];
        houghLinesAngle.def  = [NSNumber numberWithFloat:(CV_PI/180)];
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:(OCVHoughLineTransformEffectParameterIndex_Last + 1)];
        [array insertObject:cannyLowThreshold   atIndex:OCVHoughLineTransformEffectParameterIndex_CannyLowThreshold];
        [array insertObject:cannyUpThreshold    atIndex:OCVHoughLineTransformEffectParameterIndex_CannyUpThreshold];
        [array insertObject:houghLinesAngle     atIndex:OCVHoughLineTransformEffectParameterIndex_HoughAngle];
        [array insertObject:houghLinesThreshold atIndex:OCVHoughLineTransformEffectParameterIndex_HoughThreshold];
        self.parameters = [NSArray arrayWithArray:array];
    }
    return self;
}

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

- (UIImage *)applyOnImage:(UIImage *)sourceImage
    withCannyLowThreshold:(NSNumber *)cannyLow
         cannyUpThreshold:(NSNumber *)cannyUp
               houghAngle:(NSNumber *)houghAngle
           houghThreshold:(NSNumber *)houghThreshold
{
    cv::Mat originalMat = [self cvMatFromUIImage:sourceImage];
    cv::Mat resultMat, cannyMat;
    
    // prepare for hough lines transform
    // blur the image at first
    // cv::GaussianBlur(originalMat, resultMat, cv::Size(9, 9), 2, 2);
    
//    // select blue component only
//    cv::vector<cv::Mat> arrayOfColorComponents;
//    cv::split(originalMat, arrayOfColorComponents);
    
//    return [self UIImageFromCVMat:arrayOfColorComponents[2]];
    
    // find edges
    cv::Canny(originalMat/*arrayOfColorComponents[2]*/, cannyMat, [cannyLow intValue], [cannyUp intValue], 3, true);
    
//    return [self UIImageFromCVMat:cannyMat];
    
//    cv::cvtColor(cannyMat, resultMat, CV_GRAY2BGR);
    // get lines
    cv::vector<cv::Vec4i> lines;
    cv::HoughLines(cannyMat, lines, 1, [houghAngle floatValue], [houghThreshold intValue]);
    // draw lines on the original image
    resultMat = originalMat;
    for (size_t i = 0; i < lines.size(); i++)
    {
        cv::Vec4i l = lines[i];
        cv::line(resultMat, cv::Point(l[0], l[1]), cv::Point(l[2], l[3]), cv::Scalar(255, 0, 0));
    }
    
    return [self UIImageFromCVMat:resultMat];
}


@end
