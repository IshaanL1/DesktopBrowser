//
//  BrowserMenuJavascriptTableViewCell.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuJavascriptTableViewCell.h"

@interface BrowserMenuJavascriptTableViewCell ()

@property (weak, nonatomic) IBOutlet UISwitch* switchControl;

@end

@implementation BrowserMenuJavascriptTableViewCell

- (void)setJavascriptAction:(BrowserMenuActionBoolChange* __nonnull)action;
{
    [[self switchControl] setOn:[action boolValue]];
}

- (IBAction)switchControlToggled:(id)sender;
{
    void (^block)(BrowserMenuActionBoolChange* __nonnull) = [self valueChangedBlock];
    if (!block) { return; }
    BrowserMenuActionBoolChange* action = [[BrowserMenuActionBoolChange alloc] initWithBool:[[self switchControl]isOn]];
    block(action);
}

@end
