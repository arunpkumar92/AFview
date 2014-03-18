//
//  FMDropDownCell.h
//  DutyFree
//
//  Created by Arun Kumar.P on 07/01/14.
//  Copyright (c) 2014 Flip Media FZ LLC. All rights reserved.
//

@interface AFDropDownCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;

+ (CGFloat) heightForCellForText:(NSString *)text;

@end
