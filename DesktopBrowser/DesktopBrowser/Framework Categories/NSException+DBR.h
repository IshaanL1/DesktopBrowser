//
//  NSException+DBR.h
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (DBR)

+ (void)throwIfNilObject:(id __nullable)object;
+ (void)throwIfNSNotFound:(NSInteger)value;

@end
