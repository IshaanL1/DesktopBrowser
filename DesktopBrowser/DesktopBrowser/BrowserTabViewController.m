//
//  BrowserTabViewController.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserTabViewController.h"
#import "NSException+DBR.h"

@interface BrowserTabViewController ()

@property (nonatomic, copy, nullable) void (^completion)(UIViewController*);

@end

@implementation BrowserTabViewController

- (UIViewController*)initWithCompletionHandler:(void (^__nullable)(UIViewController*))completion;
{
    self = [super init];
    [NSException throwIfNilObject:self];
    _completion = completion;
    return self;
}

- (void)viewDidLoad;
{
    [super viewDidLoad];
}

@end
