local Package = script.Parent;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlayersService = game:GetService("Players")

local State = require(Package.Parent.Core.Value);
local Computed = require(Package.Parent.Core.Computed);
local Enumeration = require(Package.Parent.Field.Choice);

local Camera = workspace.CurrentCamera;
local PlayerGui = PlayersService.LocalPlayer.PlayerGui;

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

function CLASS_CONSTRUCTORS.of(context)
	return context.deviceInformation;
end

local function new()
	local self = setmetatable({}, CLASS_METATABLE);
	
	self.deviceType = Enumeration({"Desktop", "Mobile", "Tablet"});
	self.inputType = Enumeration({"MouseKeyboard", "Touch", "Gamepad"});
	self.orientationType = State(PlayerGui.CurrentScreenOrientation);
	self.resolution = State(Camera.ViewportSize);
	
	PlayerGui:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function()
		self.orientationType:set(PlayerGui.CurrentScreenOrientation);
	end);
	
	Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		self.resolution:set(Camera.ViewportSize);
	end);
	
	return self;
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new(...);
	end,
});