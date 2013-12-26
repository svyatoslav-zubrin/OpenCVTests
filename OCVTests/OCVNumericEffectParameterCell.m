//
//  OCVNumericEffectParameterCell.m
//  OCVTests
//
//  Created by zubrin on 12/24/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVNumericEffectParameterCell.h"

#import "OCVEffectParameter.h"


@interface OCVNumericEffectParameterCell ()
//
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
//
@property (nonatomic, strong) OCVEffectParameter *parameter;
@end


@implementation OCVNumericEffectParameterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

#pragma mark - Public methods

- (void)configureWithEffectParameter:(OCVEffectParameter *)parameter_
{
    self.parameter = parameter_;
    // UI
    self.nameLabel.text      = self.parameter.name;
    self.valueLabel.text     = [NSString stringWithFormat:@"%.2f", [self.parameter.def floatValue]];
    self.slider.maximumValue = [self.parameter.max floatValue];
    self.slider.minimumValue = [self.parameter.min floatValue];
    self.slider.value        = [self.parameter.def floatValue];
}

- (NSNumber *)actualParameterValue
{
    return [NSNumber numberWithFloat:self.slider.value];
}

#pragma mark - User actions

- (IBAction)sliderValueChanged:(id)sender
{
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f", self.slider.value];
}

@end
