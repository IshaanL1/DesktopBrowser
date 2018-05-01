//
//  UITableViewCell+DBR.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "UITableViewCell+DBR.h"

@implementation UITableViewCell (DBR)

+ (UINib*)nib;
{
    Class class = [self class];
    return [UINib nibWithNibName:NSStringFromClass(class) bundle:[NSBundle bundleForClass:class]];
}
+ (NSString*)reuseIdentifier;
{
    Class class = [self class];
    return NSStringFromClass(class);
}

@end
