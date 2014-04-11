//
//  Card.h
//  Matchisimo
//
//  Created by Matias Casanova on 10/04/14.
//  Copyright (c) 2014 Matias Casanova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;


- (int)match:(NSArray *)otherCards;

@end
