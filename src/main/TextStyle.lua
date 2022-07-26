local Package = script.Parent;

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

local function new(font, size, lineHeight)
	local self = setmetatable({}, CLASS_METATABLE);

	self.font = font;
	self.lineHeight = lineHeight;
	self.size = size;

	return self;
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new(...);
	end,
})