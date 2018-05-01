//
//  BrowserMenuJavascriptTableViewCell.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserMenuAction.h"

@interface BrowserMenuJavascriptTableViewCell : UITableViewCell

@property (nonatomic, strong, nullable) void (^valueChangedBlock)(BrowserMenuActionBoolChange* __nonnull);
- (void)setJavascriptAction:(BrowserMenuActionBoolChange* __nonnull)action;

@end
