//
//  FMDropDownCell.m
//  DutyFree
//
//  Created by Arun Kumar.P on 07/01/14.
//  Copyright (c) 2014 Flip Media FZ LLC. All rights reserved.
//

#import "AFDropDownCell.h"

@implementation AFDropDownCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Getter Methods

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 230, 20)];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor orangeColor];
        _contentLabel.text = @"Example Text";
        _contentLabel.font = [UIFont fontWithName:@"GillSans" size:17];
        _contentLabel.highlightedTextColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

#pragma mark - Coustom Functions

- (void)populateData{
    
}

+ (CGFloat) heightForCellForText:(NSString *)text{
    float drawWidth = 230.0f;
    UIFont *titleFont = [UIFont fontWithName:@"Ariel" size:17];
    CGSize titleTextSize = [text sizeWithFont:titleFont
                            constrainedToSize:CGSizeMake(drawWidth, 999.0)
                                lineBreakMode:NSLineBreakByWordWrapping];
    return titleTextSize.height+35;
}

#pragma mark - Draw Functions

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self addSubview:self.contentLabel];
    [self.contentLabel sizeToFit];
}

@end
