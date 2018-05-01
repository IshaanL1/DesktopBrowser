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
    // FIXME: Verify the value is valid
    // if the action is NIL, the value is out of range and we should bail
    // update the UI
    [self setScale:value];
    // check if our block has been set, if it has call it with the action
    BrowserMenuScaleTableViewCellScaleChangedBlock block = [self scaleChangedBlock];
    if (!block) { return; }
    block(value);
}

- (IBAction)minusButtonTapped:(id)sender;
{
    // get the current value
    double value = [[self internalScaleRepresentation] doubleValue];
    // adjust it
    value -= 0.1;
    // try to create an action
    [self setScale:value];
    // check if our block has been set, if it has call it with the action
    BrowserMenuScaleTableViewCellScaleChangedBlock block = [self scaleChangedBlock];
    if (!block) { return; }
    block(value);}

- (void)updateUIWithAction:(double)newScale;
{
    [self setInternalScaleRepresentation:BrowserMenuScaleStringFromDouble(newScale)];
    [self updateLabel];
}

- (void)setScale:(double)newScale;
{
    [self setInternalScaleRepresentation:BrowserMenuScaleStringFromDouble(newScale)];
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
