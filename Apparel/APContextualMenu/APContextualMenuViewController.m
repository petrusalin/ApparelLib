//
//  APContextualMenuViewController.m
//  ApparelLibDemo
//
//  Created by Alin Petrus on 11/12/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APContextualMenuViewController.h"
#import "APUtils.h"

@interface APContextualMenuViewController ()

@end

@implementation APContextualMenuViewController

@synthesize contextualMenu = _contextualMenu;

#pragma mark -
#pragma mark lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addGestureRecognizer:longPress];
    
    self.contextualMenu = [[APContextualView alloc] init];
    self.contextualMenu.delegate = self;
    self.contextualMenu.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return YES;
}

#pragma mark -
#pragma mark actions

- (void)longPressed:(UIGestureRecognizer*)recognizer {
    CGPoint center = [recognizer locationInView:self.view];
    
    center = [_contextualMenu convertPoint:center fromView:self.view];
    [_contextualMenu showWithCenter:center];
}

#pragma mark -
#pragma mark contextual menu dataSource

- (NSUInteger)numberOfButtons {
    return 8;
}

#pragma mark -
#pragma mark contextual menu delegate

- (UIImage*)imageForButtonWithIndex:(NSUInteger)index andState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/blackButton.png")];
        case UIControlStateSelected:
            return [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/blackButtonSelected.png")];
        default:
            return nil;
    }
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
    APLog(@"Tapped button at index: %d", index);
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
