//
//  DataModels.m
//  SelfPhotoLibrary
//
//  Created by Hiroyuki Watanabe on 12/06/26.
//  Copyright (c) 2012年 Keio University. All rights reserved.
//

#import "DataModels.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

#define DB_FILE_NAME @"SelfPhoto.sqlite"

#define SQL_CREATE @"CREATE TABLE IF NOT EXISTS Library (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,contents BLOB)"
#define SQL_INSERT @"INSERT INTO Library (title,contents) VALUES (?,?)"
#define SQL_SELECT @"SELECT * FROM Library ORDER BY id DESC"
#define SQL_DROPTABLE @"DELETE FROM Library"

@interface DataModels ()

@end

@implementation DataModels


+ (void)insertTitle:(NSString *)title Contents:(NSData *)contents
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
    
    
	[db open];
    [db executeUpdate:SQL_CREATE];
    [db executeUpdate:SQL_INSERT,title,contents];
    [db close];
}

+ (NSMutableArray *)selectTitle :(NSMutableArray *)array
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
	[db open];
    
	
	FMResultSet*    results = [db executeQuery:SQL_SELECT];
    
    NSString*       titleData;
	
	while( [results next] )
	{
		titleData = [results stringForColumn:@"title"];
        [array addObject:titleData];
	}
	
	[db close];
	
	return array;
}

+ (NSMutableArray *)selectContents :(NSMutableArray *)array
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
    
	[db open];
	
	FMResultSet*    results = [db executeQuery:SQL_SELECT];
    
    NSData*       contentsData;
	
	while( [results next] )
	{
		contentsData = [results dataForColumn:@"contents"];
        [array addObject:contentsData];
	}
	
	[db close];
	
	return array;
}

+ (void)drop_table
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
    
    
	[db open];
    [db executeUpdate:SQL_DROPTABLE];
    [db close];
}



@end
