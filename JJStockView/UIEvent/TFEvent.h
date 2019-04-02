//
//  TFEvent.h
//  TfsCore
//
//  Created by CKC on 12/10/10.
//  All rights reserved. © Treasure Frontier System Sdn. Bhd.
//

#import <Foundation/Foundation.h>


@interface TFEvent : NSObject 
{
	int idNo;
	NSObject *source;
}

@property (nonatomic) int idNo;
@property (nonatomic, retain) NSObject *source;

- (id)init:(NSObject *) source_ idNo:(int)idNo_;

@end
