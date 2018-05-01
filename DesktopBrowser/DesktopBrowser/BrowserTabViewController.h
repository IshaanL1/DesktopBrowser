//
//  BrowserTabViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserMenuAction.h"

@interface BrowserTabViewController : UIViewController

+ (UIViewController*)browserTabWithCompletionHandler:(void (^__nullable)(UIViewController* __nonnull, BrowserMenuAction* __nonnull))completion;

@end
