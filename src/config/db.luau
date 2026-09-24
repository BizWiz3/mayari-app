local d1 = require("d1client")
local process = require("@std/process")

local accountId = process.env.ACCOUNT_ID
local databaseId = process.env.DATABASE_ID
local apiToken = process.env.API_TOKEN

local db = d1.new(accountId, databaseId, apiToken)
:andThen(function()
    print("D1 Database initialized")
end)
:catch(function(err)
    error(err)
end)

local res = db:query([[
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT UNIQUE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
]])

if not res.success then
    for _, e in res.errors do
        print(`[{e.code}]: {e.message}`)
    end
end

return db
