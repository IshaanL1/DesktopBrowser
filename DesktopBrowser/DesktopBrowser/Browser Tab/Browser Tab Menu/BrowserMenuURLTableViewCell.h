//
//  BrowserMenuURLTableViewCell.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;

typedef void (^BrowserMenuURLTableViewCellConfirmBlock)(NSString* __nonnull urlString);

@interface BrowserMenuURLTableViewCell : UITableViewCell

@property (nonatomic, strong, nullable) BrowserMenuURLTableViewCellConfirmBlock urlConfirmBlock;

- (void)setURLString:(NSString* __nonnull)newURL;

@end
