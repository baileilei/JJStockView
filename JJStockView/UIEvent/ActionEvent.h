//
//  ActionEvent.h
//  TfsCore
//
//  Created by CKC on 12/10/10.
//  All rights reserved. © Treasure Frontier System Sdn. Bhd.
//

#import <Foundation/Foundation.h>
#import "TFEvent.h"


@interface ActionEvent : TFEvent {
	
	NSString *actionCommand;
	long long int when;
}
@property (nonatomic, retain) NSString *actionCommand;
@property (nonatomic) long long int when;

- (id)init:(NSObject *) source_ idNo:(int)idNo_ command:(NSString *)command;
- (id)init:(NSObject *) source_ idNo:(int)idNo_ command:(NSString *)command when:(long long int)when_;

@end
