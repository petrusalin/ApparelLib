//
//  APDropDownView.m
//  APDropdownView
//
//  Created by Alin Petrus on 9/14/12.
//  Copyright (c) 2012 Alin Petrus. All rights reserved.
//

#import "APDropDownView.h"
#import "APUtils.h"

@interface APDropDownView ()
@property (nonatomic, strong) UIButton *dropDownButton;
@property (nonatomic, strong) APDropDownTableView *dropDownTableView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

- (void)dropDownButtonClicked:(id)sender;
@end

@implementation APDropDownView

@synthesize dropDownButton = _dropDownButton;
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize selectedIndexPath = _selectedIndexPath;

#pragma mark -
#pragma mark initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _selectedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
        _dropDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dropDownButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _dropDownButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [_dropDownButton addTarget:self action:@selector(dropDownButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *image = [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/dropDownButton.png")];
        [_dropDownButton setBackgroundImage:[image stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
        image = [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/dropDownButtonSelected.png")];
        [_dropDownButton setBackgroundImage:[image stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
        [_dropDownButton setBackgroundImage:[image stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateSelected];
        
        image = [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/arrowDown.png")];
        
        [_dropDownButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dropDownButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        _dropDownButton.titleEdgeInsets = UIEdgeInsetsMake(3, -image.size.width + 3, 3, image.size.width + 10);
        [_dropDownButton setTitle:@"Select..." forState:UIControlStateNormal];
        
        [_dropDownButton setImage:image forState:UIControlStateNormal];
        [_dropDownButton setImage:image forState:UIControlStateHighlighted];
        [_dropDownButton setImage:image forState:UIControlStateSelected];
        _dropDownButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat insetRight = image.size.width > image.size.height ? image.size.height : image.size.width;
        [_dropDownButton setImageEdgeInsets:UIEdgeInsetsMake(3, _dropDownButton.frame.size.width - insetRight, 3, 0)];
        [self addSubview:_dropDownButton];
        
        _dropDownTableView = [[APDropDownTableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, CGRectGetMaxY(self.frame), self.frame.size.width, 0)];
        _dropDownTableView.tableView.delegate = self;
        _dropDownTableView.tableView.dataSource = self;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIImage *image = [UIImage imageWithContentsOfFile:APBUNDLE(@"APAssets.bundle/Images/arrowDown.png")];
    CGFloat insetRight = image.size.width > image.size.height ? image.size.height : image.size.width;
    [_dropDownButton setImageEdgeInsets:UIEdgeInsetsMake(3, _dropDownButton.frame.size.width - insetRight, 3, 0)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark actions

- (void)dropDownButtonClicked:(id)sender {
    _dropDownButton.selected = !_dropDownButton.selected;
    
    [_dropDownTableView show];
}

#pragma mark -
#pragma mark public

- (void)setBackgroundImage:(UIImage*)image forState:(UIControlState)state {
    [_dropDownButton setBackgroundImage:image forState:state];
}

- (void)setAccessoryImage:(UIImage*)image forState:(UIControlState)state {
    [_dropDownButton setImage:image forState:UIControlStateNormal];
}

- (void)setDropDownTitle:(NSString*)title forState:(UIControlState)state {
    [_dropDownButton setTitle:title forState:state];
}

- (id)dequeueCellWithReuseIdentifier:(NSString*)identifier {
    return [_dropDownTableView.tableView dequeueReusableCellWithIdentifier:identifier];
}

#pragma mark -
#pragma mark table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownView:didSelectItemAtIndexPath:)]) {
        [_delegate dropDownView:self didSelectItemAtIndexPath:indexPath];
    }
    
    self.selectedIndexPath = indexPath;
    [_dropDownTableView.tableView deselectRowAtIndexPath:indexPath animated:NO];
    //to correctly display the checkmark. would need a better implementation
    [_dropDownTableView.tableView reloadData];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *text = cell.textLabel.text;
    [_dropDownButton setTitle:text forState:UIControlStateNormal];
    
    _dropDownButton.selected = !_dropDownButton.selected;
    [_dropDownTableView hide];
}

#pragma mark -
#pragma mark table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataSource && [_dataSource respondsToSelector:@selector(dropDownView:numberOfItemsInSection:)]) {
        return [_dataSource dropDownView:self numberOfItemsInSection:section];
    }
    
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfSectionsInDropDownView:)]) {
        return [_dataSource numberOfSectionsInDropDownView:self];
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSource && [_dataSource respondsToSelector:@selector(dropDownView:itemForRowAtIndexPath:)]) {
        UITableViewCell *cell =  [_dataSource dropDownView:self itemForRowAtIndexPath:indexPath];
        
        if (indexPath.row == self.selectedIndexPath.row && indexPath.section == self.selectedIndexPath.section) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
    }
    
    return nil;
}



@end
