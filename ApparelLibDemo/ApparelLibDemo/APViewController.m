//
//  APViewController.m
//  ApparelLibDemo
//
//  Created by Alin Petrus on 10/8/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APViewController.h"
#import "APNoticeView.h"
#import "APUtils.h"

@interface APViewController ()

@end

@implementation APViewController

#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    APDropDownView *dropDownView = [[APDropDownView alloc] initWithFrame:CGRectMake(30, 80, 260, 20)];
    dropDownView.delegate = self;
    dropDownView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dropDownView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showNoticeViewDemo:(id)sender {
    APNotice *notice1 = [[APNotice  alloc] initWithTitle:@"Title1" andMessage:@"Message1"];
    APNotice *notice2 = [[APNotice  alloc] initWithTitle:@"Title2" andMessage:@"Message2"];
    APNotice *notice3 = [[APNotice  alloc] initWithTitle:@"Title3" andMessage:@"Message3"];
    APNotice *notice4 = [[APNotice  alloc] initWithTitle:@"Title4" andMessage:@"Message4"];
    APNotice *notice5 = [[APNotice  alloc] initWithTitle:@"Title5" andMessage:@"Message5"];
    
    NSArray *array = [[NSArray alloc] initWithObjects:notice1, notice2, notice3, notice4, notice5, nil];
    
    APNoticeView *noticeView = [[APNoticeView alloc] initWithNoticesArray:array];
    [noticeView show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark -
#pragma mark dropdown view delegate methods

- (void)dropDownView:(APDropDownView*)dropDownView didSelectItemAtIndexPath:(NSIndexPath*)indexPath {
    APLog(@"\n\nDid select item at indexPath: %@", indexPath);
}

- (NSInteger)dropDownView:(APDropDownView *)dropDownView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInDropDownView:(APDropDownView *)dropDownView {
    return 1;
}

- (UITableViewCell *)dropDownView:(APDropDownView *)dropDownView itemForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [dropDownView dequeueCellWithReuseIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"Cell";
    
    return cell;
}

@end
