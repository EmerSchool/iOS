//
//  CellInfo.h
//  EmerShool
//
//  Created by Gbir on 27.05.17.
//  Copyright © 2017 EmerShool. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    typeCellTeacher,
    typeCellPupil,
} typeCellEnum;

@interface CellInfo : NSObject

@property (nonatomic) typeCellEnum typeCell;
@property (strong, nonatomic) NSString *reusIdCell;
@property (strong, nonatomic) NSString *titleCell;
@property (strong, nonatomic) NSString *subTitleCell;

@end
