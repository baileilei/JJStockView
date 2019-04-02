//
//  ListenerBag.h
//  TfsCore
//
//  Created by CKC on 12/10/10.
//  All rights reserved. © Treasure Frontier System Sdn. Bhd.
//

#import <Foundation/Foundation.h>
#import "ActionListener.h"
#import "ItemListener.h"
#import "ChangeListener.h"

@interface ListenerBag : NSObject {
    NSMutableArray *actionListeners;
    NSMutableArray *itemListeners;
    NSMutableArray *changeListeners;
//    NSObject *source;
	
    NSObject* actionListenerArray[100];
    NSObject* itemListenerArray[100];
    NSObject* changeListenerArray[100];

}

//@property (nonatomic, retain) NSMutableArray *actionListeners;
//@property (nonatomic, retain) NSMutableArray *itemListeners;
//@property (nonatomic, retain) NSMutableArray *changeListeners;
@property (nonatomic, assign) NSObject *source;

- (id) init:(NSObject *) source_;

- (void) addActionListener:(id<ActionListener>) l;
- (void) removeActionListener:(id<ActionListener>) l;
- (void) fireActionListener;
- (void) fireActionListener:(NSString *) command;

- (void) addItemListener:(id<ItemListener>) l;
- (void) removeItemListener:(id<ItemListener>) l;
- (void) fireItemListener:(int) stateChange;

- (void) addChangeListener:(id<ChangeListener>) l;
- (void) removeChangeListener:(id<ChangeListener>) l;
- (void) fireChangeListener;
@end
