//
//  Event.h
//  CARMEATS
//
//  Created by Eric Raio on 6/23/13.
//  Copyright (c) 2013 Eric Raio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *datetime;
@property (strong, nonatomic) NSString *address;

- (id) initWithJSON:(NSDictionary *)event;

+ (void) fetchAll;

@end
