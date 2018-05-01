//
//  BrowserMenuScaleTableViewCell.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserMenuAction.h"

typedef void (^BrowserMenuScaleTableViewCellScaleChangedBlock)(double scale);

@interface BrowserMenuScaleTableViewCell : UITableViewCell
@property (nonatomic, strong, nullable) BrowserMenuScaleTableViewCellScaleChangedBlock scaleChangedBlock;
- (void)setScale:(double)newScale;
@end
