//
//  BrowserMenuJavascriptTableViewCell.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;
#import "BrowserMenuAction.h"

typedef void (^BrowserMenuJavascriptTableViewCellValueChangedBlock)(BOOL newValue);

@interface BrowserMenuJavascriptTableViewCell : UITableViewCell

@property (nonatomic, strong, nullable) BrowserMenuJavascriptTableViewCellValueChangedBlock valueChangedBlock;
- (void)setToggleEnabled:(BOOL)enabled;

@end
