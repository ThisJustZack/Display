local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Fusion = require(ReplicatedStorage.Packages.Fusion);

local Display = Fusion.Display;

local Application = Display.Application;
local Theme = Display.Theme;

local Views = require(script.Views);

local app = Application(
    {"Main", {}},
    {
        ["Main"] = Views.Page1(),
        ["Alt"] = Views.Page2()
    },
    Theme.fallback(),
    {},
    {Enum.CoreGuiType.Chat},
    {Enum.CoreGuiType.All}
);