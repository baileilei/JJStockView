//
//  TFEvent.m
//  TfsCore
//
//  Created by CKC on 12/10/10.
//  All rights reserved. © Treasure Frontier System Sdn. Bhd.
//

#import "TFEvent.h"


@implementation TFEvent
@synthesize idNo;
@synthesize source;

- (id)init:(NSObject *) source_ idNo:(int)idNo_
{
	if ((self = [super init]))
	{
		self.source = source_;
		self.idNo = idNo_;
	}
	return self;
}

- (void) dealloc
{
//    [source release];
//    [super dealloc];
}

@end
