//
//  BrowserMenuURLTableViewCell.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;

@interface BrowserMenuURLTableViewCell : UITableViewCell

@property (nonatomic, strong, nullable) void (^urlConfirmedBlock)(NSString* __nonnull);

- (void)setURLString:(NSString* __nonnull)newURL;

@end
