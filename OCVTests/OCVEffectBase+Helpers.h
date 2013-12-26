//
//  OCVEffectBase+Helpers.h
//  OCVTests
//
//  Created by zubrin on 12/16/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVEffectBase.h"

@interface OCVEffectBase (Helpers)

- (cv::Mat)cvMatFromUIImage:(UIImage *)image;
- (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;

@end
