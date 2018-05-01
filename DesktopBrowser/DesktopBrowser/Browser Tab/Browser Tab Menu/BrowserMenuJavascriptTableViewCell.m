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

- (void)setToggleEnabled:(BOOL)enabled
{
    [[self switchControl] setOn:enabled];
}

- (IBAction)switchControlToggled:(id)sender;
{
    BrowserMenuJavascriptTableViewCellValueChangedBlock block = [self valueChangedBlock];
    if (!block) { return; }
    block([[self switchControl] isOn]);
}

@end
