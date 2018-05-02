//
//  BrowserTabConfiguration.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import Foundation;

@interface BrowserTabConfiguration : NSObject <NSCopying>
{
    NSString* _urlString;
    double _scale;
    BOOL _javascriptEnabled;
}
@property (nonatomic, strong, readonly, nonnull) NSString* uuid;
@property (nonatomic, strong, readonly, nonnull) NSString* urlString;
@property (nonatomic, readonly) double scale;
@property (nonatomic, readonly) BOOL javascriptEnabled;
- (instancetype)initWithURLString:(NSString* __nonnull)urlString scale:(double)scale javascriptEnabled:(BOOL)jsEnabled;
- (id)copyWithZone:(NSZone *)zone;
@end

@interface MutableBrowserTabConfiguration : BrowserTabConfiguration
@property (nonatomic, strong, nonnull, setter=setURLString:) NSString* urlString;
@property (nonatomic) double scale;
@property (nonatomic) BOOL javascriptEnabled;
@end

@protocol BrowserTabConfigurationChangeDelegate
- (void)changeDidOccurToConfiguration:(BrowserTabConfiguration*)configuration;
@end

@interface BrowserTabConfiguration (Mutating) <NSMutableCopying>
- (id)mutableCopyWithZone:(NSZone *)zone;
@end

