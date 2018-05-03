//
//  BrowserMenuViewController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuViewController.h"
#import "NSException+DBR.h"
#import "UITableViewCell+DBR.h"
#import "BrowserMenuTableViewController.h"

@interface BrowserMenuViewController () <UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong, nonnull) BrowserMenuTableViewController* tableViewController;

@end

@implementation BrowserMenuViewController

// MARK: INIT

+ (UIViewController*)browserMenuWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                                         delegate:(id<BrowserMenuViewControllerDelegate> __nonnull)delegate
                          presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi;
{
    BrowserMenuViewController* menuVC = [[BrowserMenuViewController alloc] initWithConfiguration:configuration
                                                                     delegate:delegate];
    [menuVC setTitle:@"Menu"];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:menuVC];
    [navigationVC setModalPresentationStyle:UIModalPresentationPopover];
    [[navigationVC popoverPresentationController] setBarButtonItem:bbi];
    [[navigationVC popoverPresentationController] setDelegate:menuVC];
    return navigationVC;
}

- (instancetype)initWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                             delegate:(id<BrowserMenuViewControllerDelegate> __nullable)delegate;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _tableViewController = [[BrowserMenuTableViewController alloc] initWithConfiguration:configuration delegate:delegate];
    return self;
}

// MARK: Lifecycle Methods

- (void)viewDidLoad;
{
    [super viewDidLoad];

    // configure childVC
    [self addChildViewController:[self tableViewController]];
    UIView* myview = [self view];
    UIView* subview = [[self tableViewController] view];
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [myview addSubview:subview];
    [myview addConstraints:@[
                             [[myview heightAnchor] constraintEqualToAnchor:[subview heightAnchor]],
                             [[myview widthAnchor] constraintEqualToAnchor:[subview widthAnchor]],
                             [[myview centerXAnchor] constraintEqualToAnchor:[subview centerXAnchor]],
                             [[myview centerYAnchor] constraintEqualToAnchor:[subview centerYAnchor]]
                             ]];
}

// MARK: UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
                                                               traitCollection:(UITraitCollection *)traitCollection;
{
    return UIModalPresentationNone; // Makes a popover show even on iPhone
}

@end


