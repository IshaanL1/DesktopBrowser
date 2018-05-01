//
//  ButtonTableViewCell.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "ButtonTableViewCell.h"
#import "NSException+DBR.h"

@interface ButtonTableViewCell ()

@end

@implementation ButtonTableViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    [NSException throwIfNilObject:self];
    _destructive = NO;
    return self;
}

- (void)setDestructive:(BOOL)destructive;
{
    _destructive = destructive;
}

- (IBAction)buttonTapped:(id)sender;
{
    
}

@end
