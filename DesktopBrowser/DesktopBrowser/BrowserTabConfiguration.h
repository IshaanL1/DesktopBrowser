//
//  BrowserTabConfiguration.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import Foundation;

@interface BrowserTabConfiguration : NSObject <NSCopying>

@property (nonatomic, strong, readonly, nonnull) NSString* UUIDString;
@property (nonatomic, strong, readonly, nonnull) NSString* URLString;
@property (nonatomic, strong, readonly, nonnull) NSString* pageTitle;
@property (nonatomic, readonly) double scale;
@property (nonatomic, readonly) BOOL javascriptEnabled;

- (instancetype)initWithURLString:(NSString*)URLString
                        pageTitle:(NSString*)pageTitle
                            scale:(double)scale
                javascriptEnabled:(BOOL)jsEnabled;
- (id)copyWithZone:(NSZone *)zone;

@end

@interface MutableBrowserTabConfiguration : BrowserTabConfiguration

@property (nonatomic, strong, nonnull) NSString* URLString;
@property (nonatomic, strong, nonnull) NSString* pageTitle;
@property (nonatomic) double scale;
@property (nonatomic) BOOL javascriptEnabled;

@end

@interface BrowserTabConfiguration (Mutating) <NSMutableCopying>
- (id)mutableCopyWithZone:(NSZone *)zone;
@end

@protocol BrowserTabConfigurationChangeDelegate
- (void)changeDidOccurToConfiguration:(BrowserTabConfiguration*)configuration;
@end

