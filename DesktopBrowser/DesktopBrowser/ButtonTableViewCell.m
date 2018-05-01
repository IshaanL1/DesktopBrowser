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

@property (weak, nonatomic) IBOutlet UIButton *button;

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
    [self updateUI];
}

- (void)setButtonTitle:(NSString* __nonnull)newTitle;
{
    [[self button] setTitle:newTitle forState:UIControlStateNormal];
}

- (void)updateUI;
{
    UIColor* color;
    if ([self isDestructive]) {
        color = [UIColor redColor];
    } else {
        color = [[self button] tintColor];
    }
    [[self button] setTitleColor:color forState:UIControlStateNormal];
}

- (IBAction)buttonTapped:(id)sender;
{
    void (^block)(BOOL) = [self actionBlock];
    if (!block) { return; }
    block([self isDestructive]);
}

- (void)prepareForReuse;
{
    [super prepareForReuse];
    [self setDestructive:NO];
    [self setActionBlock:nil];
}

@end
