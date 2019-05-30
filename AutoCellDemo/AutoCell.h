//
//  AutoCell.h
//  AutoCellDemo
//
//  Created by Mac on 2019/5/21.
//  Copyright © 2019年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutoCell : UITableViewCell

@property(assign, nonatomic) CGFloat autoHeight;
@property (strong, nonatomic) AutoModel *model;
@property (copy, nonatomic) void(^refreshBlock)(void);
@property (strong, nonatomic) UITextView *textView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
