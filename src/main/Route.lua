local Package = script.Parent;

local State = require(Package.Parent.Core.Value);

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

local function new(name, arguments)
	local self = setmetatable({}, CLASS_METATABLE);
	
	self.name = State(name);
	self.arguments = {};
	
	if (arguments ~= nil) then
		for key, value in ipairs(arguments) do
			arguments[key] = State(value);
		end
	end
	
	return self;
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new(...);
	end,
});