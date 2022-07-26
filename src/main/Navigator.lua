local Package = script.Parent;

local Route = require(Package.Route);

local State = require(Package.Parent.Core.Value);

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

function class:pushNamed(name, arguments)
	local route = Route(name, arguments);
	self.currentRoute.name:set(name);
	self.currentRoute.arguments = arguments;
	table.insert(self.history, route);
end

function class:pop()
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