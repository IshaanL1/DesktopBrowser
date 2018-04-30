//
//  BrowserTabViewController.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;

@interface BrowserTabViewController : UIViewController

+ (UIViewController*)browserTabWithCompletionHandler:(void (^__nullable)(UIViewController* __nonnull))completion;

@end
