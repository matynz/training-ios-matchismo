//
//  PlayingCardGameViewController.m
//  Matchisimo
//
//  Created by jgyonzo on 4/16/14.
//  Copyright (c) 2014 Matias Casanova. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc]init];
}

@end
