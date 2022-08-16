local Package = script.Parent;

local Route = require(Package.Route);

--[[
	@class Navigator
	@client

	A widget that manages a set of child widgets with a stack discipline.
]]--
local CLASS_METHODS = {};
local CLASS_METATABLE = {__index = CLASS_METHODS};
local CLASS_CONSTRUCTORS = {};

function CLASS_METHODS:pushNamed(name, arguments)
	local route = Route(name, arguments);
	self.currentRoute.name:set(name);
	self.currentRoute.arguments = arguments;
	table.insert(self.history, route);
end

function CLASS_METHODS:pop()
	if (#self.history > 1) then
		local route = self.history[#self.history-1];
		self.currentRoute.name:set(route.name:get());
		self.currentRoute.arguments = route.arguments;
		table.remove(self.history);
	end
end

function CLASS_CONSTRUCTORS.of(context)
	return context.navigator;
end

function CLASS_CONSTRUCTORS.new(initialRoute, routes)
	local self = setmetatable({}, CLASS_METATABLE);
	
	self.initialRoute = initialRoute or {"", {}};
	self.routes = routes or {[""] = {}};
	self.currentRoute = Route(table.unpack(initialRoute));
	self.history = {Route(table.unpack(initialRoute))};
	
	return self;
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return cls.new(...);
	end,
});