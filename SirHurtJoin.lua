local Invite = {}
Invite["Vanity"] = "sirhurtv5"
local HTTPService = game:GetService("HttpService")
Invite["Join"] = function()
	coroutine.wrap(pcall)(function()
		setclipboard("https://discord.gg/" .. Invite)
		coroutine.wrap((http and http.request) or http_request)({
			Url = "http://127.0.0.1:6463/rpc?v=1",
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",
				Origin = "https://discord.com"
			},
			Body = HTTPService:JSONEncode({
				cmd = "INVITE_BROWSER",
				nonce = HTTPService:GenerateGUID(false),
				args = {
					code = Invite
				}
			})
		})
	end)
end
return Invite