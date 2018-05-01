//
//  ButtonTableViewCell.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;

@interface ButtonTableViewCell : UITableViewCell

@property (nonatomic, getter=isDestructive) BOOL destructive;
@property (nonatomic, strong, nullable) void (^actionBlock)(BOOL);

- (void)setButtonTitle:(NSString* __nonnull)newTitle;

@end
