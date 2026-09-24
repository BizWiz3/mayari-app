local common = require("common")
local db = require("../../config/db")

local response = common.response
local exception = common.exception

local Home = {}

type ReqParam = { 
    params: { id: string }
}

type QueryResult = {
    id: number,
    username: string,
    email: string
}

function Home.Get(req: IRequest<ReqParam>)
    local id = req.params.id

    local res = db:query<<QueryResult>>("SELECT * FROM users WHERE username = ?;", { 
        id
    })

    if not res.success then
        for _, e in res.errors do
            error(`[{e.code}]: {e.message}`)
        end
    end

    if #res.results == 0 then
        error(exception.NotFound(`User name: {id} is not found in the database.`))
    end

    return response.json({
        msg = `Username: {id} is found!`,
        result = {
            id = res.results[1].id,
            username = res.results[1].username,
            email = res.results[1].email,
        }
    })
end

return Home
