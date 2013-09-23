//
//  Foundation+Utils.h
//  Quiz
//
//  Created by Alexander Ignatenko on 9/22/13.
//  Copyright (c) 2013 Alexander Ignatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Utils)

- (void)safeSetObject:(id)object forKey:(id<NSCopying>)key;

@end
