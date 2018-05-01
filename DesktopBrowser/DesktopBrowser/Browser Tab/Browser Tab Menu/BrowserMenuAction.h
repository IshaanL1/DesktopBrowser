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

typedef BOOL(^DoubleInDoubleOutBlock)(double scale);

@interface BrowserMenuActionScaleChange: BrowserMenuAction
@property (class, nonatomic, strong, readonly) DoubleInDoubleOutBlock verifyScale;
@property (nonatomic, readonly) double scale;
- (instancetype)initWithScale:(double)scale;
@end

@interface BrowserMenuActionBoolChange: BrowserMenuAction
@property (nonatomic, readonly) BOOL boolValue;
- (instancetype)initWithBool:(BOOL)boolValue;
@end

@interface BrowserMenuActionCloseTab: BrowserMenuAction
@end

@interface BrowserMenuActionHideTab: BrowserMenuAction
@end

