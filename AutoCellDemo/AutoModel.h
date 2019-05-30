//
//  AutoModel.h
//  AutoCellDemo
//
//  Created by Mac on 2019/5/21.
//  Copyright © 2019年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoModel : NSObject
@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *name;

@property (assign, nonatomic) BOOL fold;

@end

NS_ASSUME_NONNULL_END
