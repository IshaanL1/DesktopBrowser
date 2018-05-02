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

@interface BrowserMenuViewController () <UIPopoverPresentationControllerDelegate, BrowserMenuTableViewControllerDelegate>

@property (nonatomic, strong, nonnull) BrowserTabConfiguration* configuration;
@property (nonatomic, strong, nonnull) BrowserMenuViewControllerCompletionHandler completion;
@property (nonatomic, weak, nullable) BrowserMenuTableViewController* tableViewController;
@property (nonatomic, weak, nullable) id<BrowserTabConfigurationChangeDelegate> configurationChangeDelegate;

@end

@implementation BrowserMenuViewController

// MARK: INIT

+ (UIViewController*)browserMenuWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
                      configurationChangeDelegate:(id<BrowserTabConfigurationChangeDelegate> __nullable)delegate
                          presentingBarButtonItem:(UIBarButtonItem* __nonnull)bbi
                            withCompletionHandler:(BrowserMenuViewControllerCompletionHandler)completion;
{
    BrowserMenuViewController* menuVC = [[BrowserMenuViewController alloc] initWithConfiguration:configuration
                                                                     configurationChangeDelegate:delegate
                                                                           withCompletionHandler:completion];
    [menuVC setTitle:@"Menu"];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:menuVC];
    [navigationVC setModalPresentationStyle:UIModalPresentationPopover];
    [[navigationVC popoverPresentationController] setBarButtonItem:bbi];
    [[navigationVC popoverPresentationController] setDelegate:menuVC];
    return navigationVC;
}

- (instancetype)initWithConfiguration:(BrowserTabConfiguration* __nonnull)configuration
          configurationChangeDelegate:(id<BrowserTabConfigurationChangeDelegate> __nullable)delegate
                withCompletionHandler:(BrowserMenuViewControllerCompletionHandler)completion;
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    [NSException throwIfNilObject:self];
    _configurationChangeDelegate = delegate;
    _completion = completion;
    _configuration = configuration;
    return self;
}

// MARK: Lifecycle Methods

- (void)viewDidLoad;
{
    [super viewDidLoad];

    // configure childVC
    BrowserMenuTableViewController* tableViewController = [[BrowserMenuTableViewController alloc] initWithConfiguration:[self configuration]];
    [tableViewController setDelegate:self];
    [self setTableViewController:tableViewController];
    [self addChildViewController:tableViewController];
    UIView* myview = [self view];
    UIView* subview = [tableViewController view];
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [myview addSubview:subview];
    [myview addConstraints:@[
                             [[myview heightAnchor] constraintEqualToAnchor:[subview heightAnchor]],
                             [[myview widthAnchor] constraintEqualToAnchor:[subview widthAnchor]],
                             [[myview centerXAnchor] constraintEqualToAnchor:[subview centerXAnchor]],
                             [[myview centerYAnchor] constraintEqualToAnchor:[subview centerYAnchor]]
                             ]];
}

// MARK: BrowserMenuTableViewControllerDelegate

- (void)userDidChangeURLString:(NSString* __nonnull)newURLString;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    BrowserMenuAction* action = [[BrowserMenuActionURLChange alloc] initWithURLString:newURLString];
    BrowserTabConfiguration* config = [self configuration];
    //[config setCurrentURLString:newURLString];
    [[self configurationChangeDelegate] changeDidOccurToConfiguration:config];
    block(self, action);
}
- (void)userDidChangeWebViewScale:(double)newScale;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    BrowserMenuActionScaleChange* action = [[BrowserMenuActionScaleChange alloc] initWithScale:newScale];
    BrowserTabConfiguration* config = [self configuration];
    //[config setScale:[action scale]];
    [[self configurationChangeDelegate] changeDidOccurToConfiguration:config];
    block(self, action);
}
- (void)userDidChangeJSEnabled:(BOOL)jsEnabled;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    BrowserMenuAction* action = [[BrowserMenuActionBoolChange alloc] initWithBool:jsEnabled];
    BrowserTabConfiguration* config = [self configuration];
    //[config setJavascriptEnabled:jsEnabled];
    [[self configurationChangeDelegate] changeDidOccurToConfiguration:config];
    block(self, action);
}
- (void)userDidSelectHideTab;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    BrowserMenuAction* action = [[BrowserMenuActionHideTab alloc] init];
    block(self, action);
}
- (void)userDidSelectCloseTab;
{
    BrowserMenuViewControllerCompletionHandler block = [self completion];
    if (!block) { return; }
    BrowserMenuAction* action = [[BrowserMenuActionCloseTab alloc] init];
    block(self, action);
}

// MARK: UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
                                                               traitCollection:(UITraitCollection *)traitCollection;
{
    return UIModalPresentationNone; // Makes a popover show even on iPhone
}

@end


