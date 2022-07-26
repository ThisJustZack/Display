local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Fusion = require(ReplicatedStorage.Packages.Fusion);

local New = Fusion.Instances.New;
local Children = Fusion.Instances.Children;
local OnEvent = Fusion.Instances.OnEvent;

local Navigator = Fusion.Display.Navigator;
local Page = Fusion.Display.Page;

local class = {};

function class:build(context)
    return New "Frame" {
        [Children] = {
            New "TextButton" {
                AnchorPoint = Vector2.new(0.5, 0.5);
                Size = UDim2.fromScale(0.5, 0.5);
                Position = UDim2.fromScale(0.5, 0.5);
                Text = "Go To Page 2";

                [Children] = {
                    New "UIAspectRatioConstraint" {
                        AspectRatio = 16/9,
                        DominantAxis = Enum.DominantAxis.Height,
                    }
                },

                [OnEvent "Activated"] = function()
                    Navigator.of(context).pushNamed("Alt", {});
                end,
            }
        }
    }
end

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

local function new()
	return setmetatable(Page(), CLASS_METATABLE);
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new();
	end,
});