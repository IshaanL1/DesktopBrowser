//
//  BrowserMenuURLTableViewCell.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuURLTableViewCell.h"

@interface BrowserMenuURLTableViewCell ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BrowserMenuURLTableViewCell

- (IBAction)goButtonTapped:(id)sender;
{
    void (^block)(NSString* __nonnull) = [self urlConfirmedBlock];
    if (!block) { return; }
    block([[self textView] text]);
}

- (void)setURLString:(NSString*)newURL;
{
    [[self textView] setText:newURL];
}

- (void)prepareForReuse;
{
    [super prepareForReuse];
    [self setURLString:@""];
    [self setUrlConfirmedBlock:nil];
}

// MARK: UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if (![text isEqualToString:@"\n"]) { return YES; }
    [textView resignFirstResponder];
    return NO;
}

@end
