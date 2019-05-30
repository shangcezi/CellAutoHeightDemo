//
//  AutoCell.m
//  AutoCellDemo
//
//  Created by Mac on 2019/5/21.
//  Copyright © 2019年 iMac. All rights reserved.
//

#import "AutoCell.h"
#import <Masonry.h>

static const CGFloat margin = 10;
static const CGFloat textHeight = 35;

@interface AutoCell ()<UITextViewDelegate>
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *titleLabel;

//@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) UIButton *commitButton;
@property (strong, nonatomic) UIView *sepView;

@end

@implementation AutoCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cellID";
    AutoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[AutoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    _iconView = [[UIImageView alloc]init];
    _iconView.image = [UIImage imageNamed:@"icon"];
    _iconView.clipsToBounds = YES;
    _iconView.layer.cornerRadius = 25;
    [self addSubview:_iconView];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
    _titleLabel.numberOfLines = 0;
   // _titleLabel.backgroundColor = [UIColor greenColor];
    [self addSubview:_titleLabel];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightHeavy];
    [self addSubview:_nameLabel];
    
    _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
    [_commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    
    [self addSubview:_commitButton];
    
    _textView = [UITextView new];
    _textView.layer.borderColor = UIColor.grayColor.CGColor;
    _textView.layer.borderWidth = 1;
    _textView.clipsToBounds = YES;
    _textView.layer.cornerRadius = 10;
    _textView.delegate = self;

    [self addSubview:_textView];
    
    _sepView = [[UIView alloc]init];
    _sepView.backgroundColor = [UIColor blackColor];
    [self addSubview:_sepView];

   // [self relayoutUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Taped)];
    [self addGestureRecognizer:tap];
}

-(void)Taped{
    
   [self commitButtonClicked];
}

-(void)relayoutUI{
    
    [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin);
        make.left.equalTo(self).offset(margin);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        // make.top.equalTo(self.iconView);
        make.centerY.equalTo(self.iconView.mas_centerY);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
        make.right.mas_equalTo(self.mas_right).offset(-margin);
    }];
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(margin);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
        make.right.equalTo(self.mas_right).offset(-margin);
    }];
    [_commitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(margin);
        make.right.equalTo(self.mas_right).offset(-margin);
        make.height.equalTo(@(textHeight));
        make.width.equalTo(@(80));
       // make.bottom.equalTo(self.mas_bottom).offset(-margin);
    }];
    [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commitButton.mas_bottom);
        make.left.equalTo(self).offset(margin);
        make.right.equalTo(self.mas_right).offset(-margin);
        make.height.equalTo(@(0));
    }];
    
    NSLog(@"self.isunfold--->%d",self.model.fold);
    
    if (!self.model.fold) {
        [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commitButton.mas_bottom);
            make.left.equalTo(self).offset(margin);
            make.right.equalTo(self.mas_right).offset(-margin);
            make.height.equalTo(@(0));
        }];
    }else{
        [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commitButton.mas_bottom);
            make.left.equalTo(self).offset(margin);
            make.right.equalTo(self.mas_right).offset(-margin);
            make.height.equalTo(@(textHeight *4));
            
        }];
    }
   
    
    [_sepView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(5);
        make.left.equalTo(self).offset(margin/2);
        make.right.equalTo(self.mas_right).offset(-margin/2);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(1));
    }];
}
-(void)setModel:(AutoModel *)model{
    
    _model = model;
    _nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    _titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    if (model.fold) {
    [_commitButton setTitle:@"取消评论" forState:UIControlStateNormal];
        [_commitButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    }else{
        [_commitButton setTitle:@"⌨️ 评论" forState:UIControlStateNormal];
        [_commitButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    
    [self relayoutUI];
    
}
/**
 评论按钮点击
 */
-(void)commitButtonClicked{

    _model.fold = !self.model.fold;
      self.refreshBlock();

}

-(void)textViewDidEndEditing:(UITextView *)textView{

    if (textView.text.length == 0) {
//do something
    }else{

        NSString *contentString = [NSString stringWithFormat:@"%@\n\n%@",_model.title,textView.text];
        _model.title = contentString;
        textView.text = @"";
        [self commitButtonClicked];
    }
}


//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if (textView.text.length == 0 || [text isEqualToString:@"\n"]) {
//        //
//       // [self commitButtonClicked];
//
//        return YES;
//
//    }else{
//
//        NSString *contentString = [NSString stringWithFormat:@"%@\n\n%@",_model.title,textView.text];
//        _model.title = contentString;
//        textView.text = @"";
//        [self commitButtonClicked];
//        return NO;
//    }
//}

@end
