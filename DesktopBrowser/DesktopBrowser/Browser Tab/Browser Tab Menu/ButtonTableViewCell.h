//
//  ButtonTableViewCell.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;

typedef void (^ButtonTableViewCellActionBlock)(BOOL isDestructive);

@interface ButtonTableViewCell : UITableViewCell

@property (nonatomic, getter=isDestructive) BOOL destructive;
@property (nonatomic, strong, nullable) ButtonTableViewCellActionBlock actionBlock;

- (void)setButtonTitle:(NSString* __nonnull)newTitle;

@end
