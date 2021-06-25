//
//  SqlTool.swift
//  UUAccount
//
//  Created by Galaxy on 2021/4/15.
//

import UIKit
import GRDB

class SqlTool: NSObject {
    let databasePath = FileTool.init().getDocumentPath()+"/database.db"
    //TODO:创建数据库
    func createTable() {
        let result = FileTool.init().createFile(document: "/database.db", fileData: Data.init())
        if result {
            let dbQueue = try? DatabaseQueue.init(path: databasePath)
            try? dbQueue?.write({ db in
                // 账单记录表
                try db.execute(sql: """
                    create table if not exists history(history_id integer primary key autoincrement,
                    type integer default(1),
                    category_id integer not null,
                    add_time integer not null,
                    remarks text default(''),
                    account_id integer default(1),
                    money decimal(0,2)
                )
                """)
                // 分类表
                try db.execute(sql: """
                    create table if not exists category(
                    category_id integer PRIMARY KEY AUTOINCREMENT,
                    name varchar(100) not null,
                    is_delete integer DEFAULT(1),
                    ico varchar(100) not null,
                    type integer DEFAULT(1),
                    father_id integer
                    )
                """)
                // 账本表
                try db.execute(sql: """
                    create table if not exists account(
                    account_id integer PRIMARY KEY AUTOINCREMENT,
                    name varchar(100) not null,
                    remark text,
                    is_delete integer default(1),
                    add_time integer not null
                    )
                """)
            })
        }
    }
}
