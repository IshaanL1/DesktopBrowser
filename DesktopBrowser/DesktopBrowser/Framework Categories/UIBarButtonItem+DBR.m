//
//  UIBarButtonItem+DBR.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "UIBarButtonItem+DBR.h"

@implementation UIBarButtonItem (DBR)

+ (instancetype)newMenuButtonItemWithTarget:(id<UIBarButtonItemBackAndForwardable> __nonnull)target;
{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"⚙︎"
                                                             style:UIBarButtonItemStyleDone target:target
                                                            action:@selector(menuButtonTapped:)];
    return item;
}

+ (instancetype)newDisabledBackButtonItemWithTarget:(id<UIBarButtonItemBackAndForwardable> __nonnull)target;
{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"〈"
                                                             style:UIBarButtonItemStyleDone
                                                            target:target
                                                            action:@selector(backButtonTapped:)];
    [item setEnabled:NO];
    return item;
}

+ (instancetype)newDisabledForwardButtonItemWithTarget:(id<UIBarButtonItemBackAndForwardable> __nonnull)target;
{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"〉"
                                                             style:UIBarButtonItemStyleDone
                                                            target:target
                                                            action:@selector(forwardButtonTapped:)];
    [item setEnabled:NO];
    return item;
}

+ (instancetype)newAddButtonItemWithTarget:(id __nonnull)target action:(SEL __nonnull)action;
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:target action:action];
}

@end
