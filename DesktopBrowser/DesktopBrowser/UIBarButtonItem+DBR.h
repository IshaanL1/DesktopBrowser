//
//  UIBarButtonItem+DBR.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import UIKit;

@protocol UIBarButtonItemBackAndForwardable

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)forwardButtonTapped:(id)sender;
- (IBAction)menuButtonTapped:(id)sender;

@end

@interface UIBarButtonItem (DBR)

+ (instancetype)newMenuButtonItemWithTarget:(id<UIBarButtonItemBackAndForwardable> __nonnull)target;
+ (instancetype)newDisabledBackButtonItemWithTarget:(id<UIBarButtonItemBackAndForwardable> __nonnull)target;
+ (instancetype)newDisabledForwardButtonItemWithTarget:(id<UIBarButtonItemBackAndForwardable> __nonnull)target;

@end
