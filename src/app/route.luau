local common = require("common")
local db = require("../config/db")

local response = common.response

local Home = {}

type QueryReq = {
    query: {
        username: string,
        email: string
    }
}

function Home.Get(req: IRequest<QueryReq>)
    local query = req.query

    if not next(query :: { [string]: string }) then
        return response.json({ msg = 'Hello, Mayari' })
    end

    local res = db:query("INSERT INTO users (username, email) VALUES (?, ?);", { 
        query.username,
        query.email
    })

    if not res.success then
        for _, e in res.errors do
            error(`[{e.code}]: {e.message}`)
        end
    end

    return response.json({ 
        msg = "Data from query has been inserted to the D1 Database",
        data = {
            username = query.username,
            email = query.email
        }
    })
end

return Home
