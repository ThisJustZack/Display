--[[
	@class TextStyle
	@client

	An immutable style describing how to format and paint text.
]]--
local CLASS_METHODS = {};
local CLASS_METATABLE = {__index = CLASS_METHODS};
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