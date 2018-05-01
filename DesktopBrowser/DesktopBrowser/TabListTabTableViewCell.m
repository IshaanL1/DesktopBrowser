//
//  TabListTabTableViewCell.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 01/05/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "TabListTabTableViewCell.h"

@interface TabListTabTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TabListTabTableViewCell

- (void)awakeFromNib;
{
    [super awakeFromNib];
    [[self titleLabel] setText:@""];
}

- (void)setLabelTitle:(NSString*)newTitle;
{
    [[self titleLabel] setText:newTitle];
}

- (void)prepareForReuse;
{
    [super prepareForReuse];
    [[self titleLabel] setText:@""];
}

@end
