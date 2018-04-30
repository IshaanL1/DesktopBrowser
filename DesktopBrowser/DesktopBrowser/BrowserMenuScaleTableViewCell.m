//
//  BrowserMenuScaleTableViewCell.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 30/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "BrowserMenuScaleTableViewCell.h"
#import "NSException+DBR.h"

static NSString* BrowserMenuScaleStringFromDouble(double number)
{
    return [NSString stringWithFormat: @"%0.1f", number];
}


@interface BrowserMenuScaleTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;
@property (nonatomic, strong) NSString* internalScaleRepresentation;

@end

@implementation BrowserMenuScaleTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super initWithCoder:aDecoder];
    [NSException throwIfNilObject:self];
    _internalScaleRepresentation = @"1.0";
    return self;
}

- (void)awakeFromNib;
{
    [super awakeFromNib];
    [[self scaleLabel] setFont:[UIFont monospacedDigitSystemFontOfSize:18 weight:UIFontWeightMedium]];
    [self updateLabel];
}

- (IBAction)plusButtonTapped:(id)sender;
{
    // get the current value
    double value = [[self internalScaleRepresentation] doubleValue];
    // adjust it
    value += 0.1;
    // try to create an action
    BrowserMenuActionScaleChange* action = [[BrowserMenuActionScaleChange alloc] initWithScale:value];
    // if the action is NIL, the value is out of range and we should bail
    if (!action) { return; }
    // update the UI
    [self updateUIWithAction:action];
    // check if our block has been set, if it has call it with the action
    [self callCompletionBlockWithAction:action];
}

- (IBAction)minusButtonTapped:(id)sender;
{
    // get the current value
    double value = [[self internalScaleRepresentation] doubleValue];
    // adjust it
    value -= 0.1;
    // try to create an action
    BrowserMenuActionScaleChange* action = [[BrowserMenuActionScaleChange alloc] initWithScale:value];
    // if the action is NIL, the value is out of range and we should bail
    if (!action) { return; }
    // update the UI
    [self updateUIWithAction:action];
    // check if our block has been set, if it has call it with the action
    [self callCompletionBlockWithAction:action];
}

- (void)updateUIWithAction:(BrowserMenuActionScaleChange* __nonnull)action;
{
    [self setInternalScaleRepresentation:BrowserMenuScaleStringFromDouble([action scale])];
    [self updateLabel];
}

- (void)callCompletionBlockWithAction:(BrowserMenuActionScaleChange* __nonnull)action;
{
    void (^block)(BrowserMenuActionScaleChange* __nonnull) = [self scaleChangedBlock];
    if (!block) { return; }
    block(action);
}

- (void)setScale:(BrowserMenuActionScaleChange* __nonnull)newScale;
{
    [self setInternalScaleRepresentation:BrowserMenuScaleStringFromDouble([newScale scale])];
    [self updateLabel];
}

- (void)updateLabel;
{
    [[self scaleLabel] setText:[self internalScaleRepresentation]];
}

- (void)prepareForReuse;
{
    [super prepareForReuse];
    [self updateLabel];
    [self setScaleChangedBlock:nil];
}

@end
