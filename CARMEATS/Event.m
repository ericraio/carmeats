//
//  Event.m
//  CARMEATS
//
//  Created by Eric Raio on 6/23/13.
//  Copyright (c) 2013 Eric Raio. All rights reserved.
//

#import "Event.h"
#import "AFJSONRequestOperation.h"

@implementation Event


- (id) initWithJSON:(NSDictionary *)event
{
    self = [super init];
    self.title = event[@"title"];
    self.datetime = event[@"datetime"];
    self.address = event[@"address"];
    
    return self;
}

+ (void) fetchAll {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost:3000/events.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             for (NSDictionary *event in JSON) {
                                                 [tempArray addObject:[[Event alloc] initWithJSON:event] ];
                                             }
                                             NSArray *events = [[NSArray alloc] initWithArray:tempArray];
                                             NSDictionary *data = @{ @"events" : events };
                                             [[NSNotificationCenter defaultCenter] postNotificationName:@"eventsJSONFinishedLoading" object:self userInfo:data];
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"NSError: %@", error.localizedDescription);
                                         }];
    [operation start];
}


@end
