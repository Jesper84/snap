//
//  Player.h
//  Snap
//
//  Created by Jesper Nielsen on 17/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;
@class Stack;
typedef enum{
    PlayerPositionBottom,
    PlayerPositionLeft,
    PlayerPositionTop,
    PlayerPositionRight,
}
PlayerPosition;
@interface Player : NSObject
@property (nonatomic, assign) PlayerPosition position;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *peerID;
@property (nonatomic, assign) int gamesWon;
@property (nonatomic, strong, readonly) Stack *closedCards;
@property (nonatomic, strong, readonly) Stack *openCards;
@property (nonatomic, assign) BOOL receivedResponse;

- (Card *)turnOverTopCard;

@end
