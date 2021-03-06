//
//  PacketOtherClientQuit.h
//  Snap
//
//  Created by Jesper Nielsen on 02/08/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "Packet.h"

@interface PacketOtherClientQuit : Packet

@property (nonatomic, copy) NSString *peerID;

+ (id)packetWithPeerID:(NSString *)peerID;

@end
