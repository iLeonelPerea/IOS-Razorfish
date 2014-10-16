//
//  DBManager.h
//  testTableView
//
//  Created by Leonel Roberto Perea Trejo on 9/1/14.
//  Copyright (c) 2014 Leonel Roberto Perea Trejo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObject.h"
#import "SkillObject.h"

@interface DBManager : NSObject

+(BOOL)checkOrCreateDataBase;
+(NSString*)getDBPath;
+(NSMutableArray*)getSkills;
+(int)insertUser:(UserObject*)userObject;

@end