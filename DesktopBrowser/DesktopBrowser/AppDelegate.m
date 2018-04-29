//
//  AppDelegate.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "AppDelegate.h"
#import "BrowserTabViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
{

    if (![self window]) {
        [self setWindow:[[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds]];
    }

    UIViewController* vc = [[BrowserTabViewController alloc] initWithCompletionHandler: nil];

    [[self window] setRootViewController:vc];
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];

    return YES;
}


@end
