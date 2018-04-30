//
//  BrowserMenuAction.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import Foundation;

/// Abstract Superclass that represents an action taken by the BrowserMenuViewController
@interface BrowserMenuAction : NSObject
@end

@interface BrowserMenuActionURLChange: BrowserMenuAction
@property (nonatomic, strong, readonly) NSString* urlString;
- (instancetype)initWithURLString:(NSString*)url;
@end

@interface BrowserMenuActionScaleChange: BrowserMenuAction
@property (nonatomic, strong, readonly) NSNumber* scaleNumber;
- (instancetype)initWithScaleNumber:(NSNumber*)scale;
@end

@interface BrowserMenuActionCloseTab: BrowserMenuAction
@end

@interface BrowserMenuActionHideTab: BrowserMenuAction
@end
