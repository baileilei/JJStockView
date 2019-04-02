//
//  ActionEvent.m
//  TfsCore
//
//  Created by CKC on 12/10/10.
//  All rights reserved. © Treasure Frontier System Sdn. Bhd.
//

#import "ActionEvent.h"

@implementation ActionEvent
@synthesize actionCommand;
@synthesize when;

- (id)init:(NSObject *) source_ idNo:(int)idNo_ command:(NSString *)command
{
	return [self init:source_ idNo:idNo_ command:command when:0];
}

- (id)init:(NSObject *) source_ idNo:(int)idNo_ command:(NSString *)command when:(long long int)when_
{
	if ((self = [super init:source_ idNo:idNo_]))
	{
		self.actionCommand = command;
		self.when = when_;
	}
	return self;
}

- (void) dealloc
{
//    [actionCommand release];
//    [super dealloc];
}

@end
