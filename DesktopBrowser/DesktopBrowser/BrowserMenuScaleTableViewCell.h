//
//  BrowserMenuScaleTableViewCell.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserMenuAction.h"

@interface BrowserMenuScaleTableViewCell : UITableViewCell

@property (nonatomic, strong, nullable) void (^scaleChangedBlock)(BrowserMenuActionScaleChange* __nonnull);

- (void)setScale:(BrowserMenuActionScaleChange* __nonnull)newScale;

@end
