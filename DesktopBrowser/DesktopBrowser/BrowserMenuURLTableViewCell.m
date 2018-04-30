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

+ (UINib*)nib;
{
    Class class = [self class];
    return [UINib nibWithNibName:NSStringFromClass(class) bundle:[NSBundle bundleForClass:class]];
}
+ (NSString*)reuseIdentifier;
{
    Class class = [self class];
    return NSStringFromClass(class);
}

- (IBAction)goButtonTapped:(id)sender;
{
    if ([self urlConfirmedBlock]) {
        [self urlConfirmedBlock]();
    }
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

@end
