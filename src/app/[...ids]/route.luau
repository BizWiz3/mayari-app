local types = require("types")
local common = require("common")

local response = common.response

local Home = {}

type ReqParams = { 
    params: { ids: { string } }
}

function Home.Get(req: types.IRequest<ReqParams>)
    local userIds = req.params.ids
    return response.json({ userIds = userIds, msg = 'Found user IDs' })
end

return Home
