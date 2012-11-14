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

- (void)doneWithContextualMenuDemo {
    [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark -
#pragma mark contextual menu dataSource

- (NSUInteger)numberOfButtons {
    return 8;
}

#pragma mark -
#pragma mark contextual menu delegate

- (UIImage*)imageForButtonWithIndex:(NSUInteger)index andState:(UIControlState)state {
    switch (index) {
        case 0:
            if (state == UIControlStateNormal) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/buttonWhite.png")];
            } else if (state == UIControlStateSelected) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/buttonWhiteSelected.png")];
            }
            break;
        case 1:
            if (state == UIControlStateNormal) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/redButton.png")];
            } else if (state == UIControlStateSelected) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/redButtonSelected.png")];
            }
            break;
        case 2:
            if (state == UIControlStateNormal) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/greenButton.png")];
            } else if (state == UIControlStateSelected) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/greenButtonSelected.png")];
            }
            break;
        case 3:
            if (state == UIControlStateNormal) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/blueButton.png")];
            } else if (state == UIControlStateSelected) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/blueButtonSelected.png")];
            }
            break;
        case 4:
            if (state == UIControlStateNormal) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/yellowButton.png")];
            } else if (state == UIControlStateSelected) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/yellowButtonSelected.png")];
            }
            break;
        case 5:
            if (state == UIControlStateNormal) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/orangeButton.png")];
            } else if (state == UIControlStateSelected) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/orangeButtonSelected.png")];
            }
            break;
        case 6:
            if (state == UIControlStateNormal) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/cyanButton.png")];
            } else if (state == UIControlStateSelected) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/cyanButtonSelected.png")];
            }
            break;
        case 7:
            if (state == UIControlStateNormal) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/magentaButton.png")];
            } else if (state == UIControlStateSelected) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/magentaButtonSelected.png")];
            }
            break;
        default:
            if (state == UIControlStateNormal) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/blackButton.png")];
            } else if (state == UIControlStateSelected) {
                return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/blackButtonSelected.png")];
            }
    }
    
    return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/blackButton.png")];
}

- (UIImage*)imageForCloseButtonState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/blackButton.png")];
        case UIControlStateSelected:
            return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/blackButtonSelected.png")];
        default:
            return nil;
    }
}

- (UIImage*)maskImageForButtons {
    return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/circleMask.png")];
}

- (BOOL)shouldUseMask {
    return YES;
}

- (void)tappedButtonAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            self.view.backgroundColor = [UIColor whiteColor];
            break;
        case 1:
            self.view.backgroundColor = [UIColor redColor];
            break;
        case 2:
            self.view.backgroundColor = [UIColor greenColor];
            break;
        case 3:
            self.view.backgroundColor = [UIColor blueColor];
            break;
        case 4:
            self.view.backgroundColor = [UIColor yellowColor];
            break;
        case 5:
            self.view.backgroundColor = [UIColor orangeColor];
            break;
        case 6:
            self.view.backgroundColor = [UIColor cyanColor];
            break;
        case 7:
            self.view.backgroundColor = [UIColor magentaColor];
            break;
        default:
            break;
    }
}

- (void)menuWillAppear {
    APLog(@"Contextual menu will appear");
}

- (void)menuDidAppear {
    APLog(@"Contextual menu did appear");
}

- (void)menuWillDisappear {
    APLog(@"Contextual menu will disappear");
}

- (void)menuDidDisappear {
    APLog(@"Contextual menu did disappear");
}

@end
