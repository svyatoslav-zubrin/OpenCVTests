//
//  OCVViewController.m
//  OCVTests
//
//  Created by zubrin on 12/13/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import <CoreText/CoreText.h>

#import "OCVViewController.h"
#import "OCVEffectsAndFiltersViewController.h"

#import "OCVGrayscaleEffect.h"
#import "OCVBlurEffect.h"
#import "OCVErodeEffect.h"
#import "OCVDilateEffect.h"
#import "OCVHoughCircleTransformEffect.h"
#import "OCVHoughLinesTransformEffect.h"
#import "OCVHoughProbLineTransformEffect.h"

#import "MBProgressHUD.h"

#import "OCVImageProcessor.h"


@interface OCVViewController () <
                                 UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate
                                >
@property (nonatomic, strong) IBOutlet UIImageView *originalImage;
@property (nonatomic, strong) IBOutlet UIImageView *filteredImage;
@property (nonatomic, strong) IBOutlet UILabel *selectedEffectNameLabel;
//
@property (nonatomic, strong) NSArray *effectsAndFilters;
@end


@implementation OCVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.effectsAndFilters = [[OCVImageProcessor sharedProcessor] basicEffects];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.selectedEffect)
    {
        [self.selectedEffectNameLabel setText:self.selectedEffect.name];
    }
    else
    {
        [self.selectedEffectNameLabel setText:@""];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User actions

- (IBAction)applyAction:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *original = self.originalImage.image;
        UIImage *filtered = [self.selectedEffect applyOnImage:original];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.filteredImage setImage:filtered];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (IBAction)versionAction:(id)sender
{
    NSString *version = [NSString stringWithCString:CV_VERSION
                                           encoding:NSUTF8StringEncoding];
    [[[UIAlertView alloc] initWithTitle:@"openCV version:"
                                message:version
                               delegate:nil
                      cancelButtonTitle:@"Hi"
                      otherButtonTitles:nil] show];
}

- (IBAction)openNewImageAction:(id)sender
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imgPicker setDelegate:self];
    [self presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.originalImage setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    [self.filteredImage setImage:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MainToEfffectsList"])
    {
        [(OCVEffectsAndFiltersViewController *)segue.destinationViewController setEffects:self.effectsAndFilters];
        [(OCVEffectsAndFiltersViewController *)segue.destinationViewController setOpener:self];
    }
}

@end
