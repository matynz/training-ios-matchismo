//
//  CardMatchingGame.h
//  Matchisimo
//
//  Created by Matias Casanova on 11/04/14.
//  Copyright (c) 2014 Matias Casanova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject


- (instancetype) initWithCardCount:(NSUInteger) count
                         usingDeck:(Deck *) deck;

- (void) chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic, getter = isPerfectMatchMode) BOOL perfectMatchMode;

@property (nonatomic, getter = hasStarted) BOOL started;
@end
