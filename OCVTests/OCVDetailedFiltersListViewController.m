//
//  OCVDetailedFiltersListViewController.m
//  OCVTests
//
//  Created by zubrin on 12/23/13.
//  Copyright (c) 2013 qarea. All rights reserved.
//

#import "OCVDetailedFiltersListViewController.h"
#import "OCVDetailedFilterViewController.h"

#import "OCVEffectBase.h"
#import "OCVHoughProbLineTransformEffect.h"

#import "OCVImageProcessor.h"



@interface OCVDetailedFiltersListViewController ()
@property (nonatomic, strong) NSArray *effects;
@property (nonatomic, strong) OCVEffectBase *selectedEffect;
@end

@implementation OCVDetailedFiltersListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.effects = [[OCVImageProcessor sharedProcessor] detailedEffects];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.effects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = ((OCVEffectBase *)[self.effects objectAtIndex:indexPath.row]).name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedEffect = [self.effects objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"DetailedFilterSelectionSegue" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"DetailedFilterSelectionSegue"])
    {
        OCVDetailedFilterViewController *vc = (OCVDetailedFilterViewController *)segue.destinationViewController;
        [vc setEffect:self.selectedEffect];
    }
    
}

@end
