local Package = script.Parent;

local Navigator = require(Package.Navigator);
local Locale = require(Package.Locale);
local Theme = require(Package.Theme);
local Device = require(Package.Device);
local BuildContext = require(Package.BuildContext);

local State = require(Package.Parent.Core.Value);
local Computed = require(Package.Parent.Core.Computed);

local New = require(Package.Parent.Instances.New);
local Children = require(Package.Parent.Instances.Children);
local OnEvent = require(Package.Parent.Instances.OnEvent);

local PlayerService = game:GetService("Players");
local StarterGuiService = game:GetService("StarterGui");

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

function class:destroy()
	self.ui:Destroy();
end

function class:updateState(state: string, value: any)
	assert(self.states[state], "The state to update must exist");
	self.states[state]:set(value);
end

local function new(initialRoute, routes, theme, states, coreEnabled, coreDisabled)
	local self = setmetatable({}, CLASS_METATABLE);
	
	self.navigator = Navigator(initialRoute, routes);
	self.theme = theme or Theme.fallback();
	self.states = states or {};
	self.locale = Locale();
	self.deviceInformation = Device();
	
	self.ui = New "ScreenGui" {
		Parent = PlayerService.LocalPlayer.PlayerGui;
		IgnoreGuiInset = true;
		
		[Children] = Computed(function()
			local page = self.navigator.routes[self.navigator.currentRoute.name:get()]
			
			if (page ~= nil) then
				return page:build(BuildContext(self.navigator, self.theme, self.locale, self.states, self.deviceInformation));
			end
			
			return nil;
		end)
	};
	
	local function removeMatching(a, b)
		local tbl = {};
		for aIndex, aItem in ipairs(a) do
			local match = false;
			for bIndex, bItem in ipairs(b) do
				if (aItem == bItem) then
					match = true;
					break;
				end
			end
			if (not match) then
				table.insert(tbl, aItem);
			end
		end
		return tbl;
	end

	local function toCoreItemList(items)
		local tbl = {};
		if (type(items) == "table") then
			for _, item in ipairs(items) do
				local result = toCoreItemList(item);
				for _, v in ipairs(result) do
					if (not table.find(tbl, v)) then
						table.insert(tbl, v);
					end
				end
			end
		elseif ((typeof(items) == "EnumItem") and (items.EnumType == Enum.CoreGuiType)) then
			if (items == Enum.CoreGuiType.All) then
				for _, v in ipairs({Enum.CoreGuiType.Chat, Enum.CoreGuiType.Health, Enum.CoreGuiType.Backpack, Enum.CoreGuiType.EmotesMenu, Enum.CoreGuiType.PlayerList}) do
					if (not table.find(tbl, v)) then
						table.insert(tbl, v);
					end
				end
			elseif (not table.find(tbl, items)) then
				table.insert(tbl, items);
			end
		end
		return tbl;
	end

	local function setCoreItems(items, value)
		local tbl = {};
		for _, item in ipairs(items) do
			if (not table.find(tbl, item)) then
				StarterGuiService:SetCoreGuiEnabled(item, value);
				table.insert(tbl, item);
			end
		end
		return tbl;
	end

	local enableList = toCoreItemList(coreEnabled);
	local disableList = toCoreItemList(coreDisabled);

	if ((#enableList > 0) or (#disableList > 0)) then
		if ((#enableList > 0) and (#disableList > 0)) then
			local enabled = removeMatching(enableList, disableList);
			local disabled = removeMatching(disableList, enableList);
			setCoreItems(enabled, true);
			setCoreItems(disabled, false);
		elseif (#enableList > 0) then
			local enabled = setCoreItems(enableList, true);
			local disabled = removeMatching(toCoreItemList(Enum.CoreGuiType.All), enabled);
			setCoreItems(disabled, false);
		else
			local disabled = setCoreItems(disableList, false);
			local enabled = removeMatching(toCoreItemList(Enum.CoreGuiType.All), disabled);
			setCoreItems(enabled, true);
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