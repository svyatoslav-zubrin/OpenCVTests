//
//  OCVNumericEffectParameterCell.h
//  OCVTests
//
//  Created by zubrin on 12/24/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCVEffectParameter;

@interface OCVNumericEffectParameterCell : UITableViewCell

- (void)configureWithEffectParameter:(OCVEffectParameter *)parameter;
- (NSNumber *)actualParameterValue;

@end
