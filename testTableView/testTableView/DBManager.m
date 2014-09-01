//
//  DBManager.m
//  testTableView
//
//  Created by Leonel Roberto Perea Trejo on 9/1/14.
//  Copyright (c) 2014 Leonel Roberto Perea Trejo. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>

@implementation DBManager

+(BOOL)checkOrCreateDataBase{
    BOOL isDbOk;
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *databasePath;
    sqlite3 *inventoryDB;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Inventory.sqlite3"]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if([filemgr fileExistsAtPath:databasePath] == NO){
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &inventoryDB) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS FOODS (ID INTEGER PRIMARY KEY AUTOINCREMENT, REMOTE_ID INTEGER, NAME TEXT, DESCRIPTION TEXT, CATEGORY TEXT, MENU_TYPE TEXT, PRICE FLOAT, URL_PIC TEXT, URL_THUMB TEXT, LOCAL_THUMB TEXT, LOCAL_PIC TEXT, RECOMMENDATIONS BLOB, DESCRIPTION_ES TEXT, DESCRIPTION_HE TEXT, NAME_RU TEXT, DESCRIPTION_RU TEXT, NAME_FR TEXT, DESCRIPTION_FR TEXT, NAME_CN TEXT, DESCRIPTION_CN TEXT, NAME_JP TEXT, DESCRIPTION_JP TEXT, NAME_DE TEXT, DESCRIPTION_DE TEXT, NAME_IT TEXT, DESCRIPTION_IT TEXT, NAME_ARABIC TEXT, DESCRIPTION_ARABIC TEXT, NAME_IR TEXT, DESCRIPTION_IR TEXT, NAME_HI TEXT, DESCRIPTION_HI TEXT, SORT_ID INTEGER)";
            if (sqlite3_exec(inventoryDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                isDbOk = NO;
                NSLog(@"table fail...");
            }else{
                isDbOk = YES;
            }
            const char* sql_stmt_wishlists = "CREATE TABLE IF NOT EXISTS WISHLIST (ID INTEGER PRIMARY KEY AUTOINCREMENT, FOOD_ID INTEGER, FOOD_NAME TEXT, FOOD_DES TEXT, FOOD_PRICE FLOAT, FOOD_QUANTITY INTEGER, TABLE_NUM INTEGER, STATUS INTEGER, ISSUED BOOL, TOKEN_ID TEXT)";
            if (sqlite3_exec(inventoryDB, sql_stmt_wishlists, NULL, NULL, &errMsg) != SQLITE_OK) {
                isDbOk = NO;
                NSLog(@"wishlist table fail...");
            }else{
                isDbOk = YES;
            }
            sqlite3_close(inventoryDB);
        }else{
            NSLog(@"db fail...");
            isDbOk = NO;
        }
    }else{
        isDbOk = YES; // DB already exists
    }
    return isDbOk;
}

+(void)insertProduct:(NSDictionary*)product{
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *databasePath;
    sqlite3 *inventoryDB = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Inventory.sqlite3"]];
    
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &inventoryDB) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO FOODS (remote_id, name, description, category, menu_type, price, url_pic, url_thumb, local_thumb, local_pic, description_es, description_he, sort_id) VALUES (\"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%.2f\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\")", [[product objectForKey:@"id"] intValue], [product objectForKey:@"name"], [product objectForKey:@"description"], [product objectForKey:@"category"], [product objectForKey:@"menu"], ([product objectForKey:@"price"] != [NSNull null])?[[product objectForKey:@"price"] floatValue]:0, [product objectForKey:@"picture"], [product objectForKey:@"picture_thumb"], ([product objectForKey:@"picture_thumb"] != [NSNull null])?[NSString stringWithFormat:@"thumb_%@.jpg",[product objectForKey:@"id"]]: [NSNull null], ([product objectForKey:@"picture"] != [NSNull null])?[NSString stringWithFormat:@"pic_%@.jpg", [product objectForKey:@"id"]]: [NSNull null], [product objectForKey:@"description_es"], [product objectForKey:@"description_he"], [[product objectForKey:@"position"] intValue]];
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(inventoryDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"fiel error... %s - %@", sqlite3_errmsg(inventoryDB),[product objectForKey:@"id"]);
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(inventoryDB);
}

@end
