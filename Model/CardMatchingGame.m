//
//  CardMatchingGame.m
//  Matchisimo
//
//  Created by Matias Casanova on 11/04/14.
//  Copyright (c) 2014 Matias Casanova. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end


@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if(!_cards) _cards = [NSMutableArray new];
    return _cards;
}

static const int CARDS_TO_CHOOSE = 3;

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if(self){
        for (int i=0; i<count; i++) {
            Card *card= [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
        self.started = NO;
    }
    return self;
    
}

- (Card *)  cardAtIndex:(NSUInteger)index{
    return (index< [self.cards count]) ? self.cards[index] : nil;
    
}

static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int MISMATCH_PENALTY = 2;

- (void) chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    //is This OK?
    self.started = YES;
    
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }else{
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
            NSMutableArray *chosenCards = [NSMutableArray new];
            for (Card *c in self.cards) {
                if (c.isChosen && !c.isMatched) {
                    [chosenCards addObject:c];
                }
            }
            NSLog(@"%d turned cards", [chosenCards count]);
            if([chosenCards count] == CARDS_TO_CHOOSE){
                int matchQty = 0;
                int matchSum = 0;
                for (int i = 0; i<[chosenCards count]-1; i++) {
                    for (int j = i+1; j<[chosenCards count]; j++) {
                        int matchScore = [[chosenCards objectAtIndex:i] match:@[[chosenCards objectAtIndex:j]]];
                        if (matchScore) {
                            matchQty++;
                            matchSum += matchScore;
                        }
                    }
                }
                BOOL perfectMatch = matchQty == CARDS_TO_CHOOSE;
                if (self.isPerfectMatchMode) {
                    if (perfectMatch) {
                        self.score += matchSum * MATCH_BONUS;
                        for (Card *card in chosenCards) {
                            card.matched = YES;
                        }
                    }else{
                        self.score -= MISMATCH_PENALTY;
                        for (Card *card in chosenCards) {
                            card.chosen = NO;
                        }
                        //So to see the last turned card
                        card.chosen = YES;
                    }
                }else{
                    if(matchSum){
                        self.score += matchSum;
                        for (Card *card in chosenCards) {
                            card.matched = YES;
                        }
                    }else{
                        self.score -= MISMATCH_PENALTY;
                        for (Card *card in chosenCards) {
                            card.chosen = NO;
                        }
                        //So to see the last turned card
                        card.chosen = YES;

                    }
                }
            }
        }
    }
}


@end
