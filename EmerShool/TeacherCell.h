//
//  TeacherCell.h
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *letftBoxView;

@property (weak, nonatomic) IBOutlet UIImageView *leftIconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *letftBoxViewWidthContstrain;

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabelCell;

@property (weak, nonatomic) IBOutlet UIButton *editRatingButton;
- (IBAction)changeRatingBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *changeLinkStatusButton;
- (IBAction)changeLinkStatusBtnPressed:(id)sender;

@end
