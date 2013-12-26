//
//  OCVDetailedFilterViewController.m
//  OCVTests
//
//  Created by zubrin on 12/23/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVDetailedFilterViewController.h"

#import "OCVEffectParameter.h"
#import "OCVHoughProbLineTransformEffect.h"

#import "MBProgressHUD.h"
#import "OCVNumericEffectParameterCell.h"


@interface OCVDetailedFilterViewController ()
    <
        UIImagePickerControllerDelegate,
        UINavigationControllerDelegate,
        UITableViewDataSource,
        UITableViewDelegate
    >
//
@property (strong, nonatomic) IBOutlet UILabel *effectNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *originalImageView;
@property (strong, nonatomic) IBOutlet UIImageView *filteredImageView;
@property (strong, nonatomic) IBOutlet UITableView *parametersTableView;
//
@end


@implementation OCVDetailedFilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.effectNameLabel.text = self.effect.name;

    [self.parametersTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User actions

- (IBAction)applyEffectAction:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *original = self.originalImageView.image;
        UIImage *filtered = nil;
        if ([self.effect isKindOfClass:[OCVHoughProbLineTransformEffect class]])
        {
            NSNumber *cannyLowThreshold = [(OCVNumericEffectParameterCell *)[self.parametersTableView cellForRowAtIndexPath:
                                                                             [NSIndexPath indexPathForRow:OCVHoughProbLineTransformEffectParameterIndex_CannyLowThreshold
                                                                                                inSection:0]] actualParameterValue];
            NSNumber *cannyUpThreshold  = [(OCVNumericEffectParameterCell *)[self.parametersTableView cellForRowAtIndexPath:
                                                                             [NSIndexPath indexPathForRow:OCVHoughProbLineTransformEffectParameterIndex_CannyUpThreshold
                                                                                                inSection:0]] actualParameterValue];
            NSNumber *houghAngle        = [(OCVNumericEffectParameterCell *)[self.parametersTableView cellForRowAtIndexPath:
                                                                             [NSIndexPath indexPathForRow:OCVHoughProbLineTransformEffectParameterIndex_HoughAngle
                                                                                                inSection:0]] actualParameterValue];
            NSNumber *houghThreshold    = [(OCVNumericEffectParameterCell *)[self.parametersTableView cellForRowAtIndexPath:
                                                                             [NSIndexPath indexPathForRow:OCVHoughProbLineTransformEffectParameterIndex_HoughThreshold
                                                                                                inSection:0]] actualParameterValue];
            filtered = [(OCVHoughProbLineTransformEffect*)self.effect applyOnImage:original
                                                             withCannyLowThreshold:cannyLowThreshold
                                                                  cannyUpThreshold:cannyUpThreshold
                                                                        houghAngle:houghAngle
                                                                    houghThreshold:houghThreshold];
        }
        else {
            filtered = [self.effect applyOnImage:original];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.filteredImageView setImage:filtered];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
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
    [self.originalImageView setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    [self.filteredImageView setImage:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.effect.parameters count];
}

#pragma mark - UITableViewDelegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NumericEffectParameterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    [(OCVNumericEffectParameterCell *)cell configureWithEffectParameter:[self.effect.parameters objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Helpers

@end
