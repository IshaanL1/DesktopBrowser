//
//  BrowserTabConfiguration.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

@import Foundation;

@interface BrowserTabConfiguration : NSObject

@property (nonatomic, strong, nonnull) NSString* uuid;
@property (nonatomic, strong, nullable) NSString* currentURLString;
@property (nonatomic) double scale;
@property (nonatomic) BOOL javascriptEnabled;

- (instancetype)initWithURLString:(NSString*)urlString scale:(double)scale javascriptEnabled:(BOOL)jsEnabled;

@end

@protocol BrowserTabConfigurationChangeDelegate

- (void)changeDidOccurToConfiguration:(BrowserTabConfiguration*)configuration;

@end
