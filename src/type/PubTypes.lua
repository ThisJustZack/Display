--!strict

local Package = script.Parent.Parent;
local Types = require(Package.Type.Types);
local CoreTypes = require(Package.Parent.Core.PubTypes);

type Value<T> = CoreTypes.Value<T>
type Computed<T> = CoreTypes.Computed<T>

type Map<K,V> = {[K]: V}

type Application = Types.Application
type BuildContext = Types.BuildContext
type ColorScheme = Types.ColorScheme
type Device = Types.Device
type Locale = Types.Locale
type Navigator = Types.Navigator
type Page = Types.Page
type Route = Types.Route
type TextStyle = Types.TextStyle
type TextTheme = Types.TextTheme
type Theme = Types.Theme
type ThemeData = Types.ThemeData

--[=[
    @interface ApplicationConstructor
    @within Application

    @param initialRoute any -- The initial route of the Application upon start.
    @param routes Map<string, Page> -- A map of the routes and their respective pages for the Application.
    @param theme Theme -- The theme to use for the Application.
    @param states Map<string, any> -- A map of the default values for universal states.
    @param coreEnabled Enum.CoreGuiType | {Enum.CoreGuiType} -- The CoreGui element(s) to be enabled for users.
    @param coreDisabled Enum.CoreGuiType | {Enum.CoreGuiType} -- The CoreGui element(s) to be disabled for users.
    ```lua
        local ReplicatedStorage = game:GetService("ReplicatedStorage");
        local Fusion = require(ReplicatedStorage.Packages.Fusion);

        local Display = Fusion.Display;

        local Application = Display.Application;
        local Theme = Display.Theme;

        local Views = require(ReplicatedStorage.Views);

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
    ```
]=]--
export type ApplicationConstructor = (initialRoute: any, routes: Map<string, Page>, theme: Theme, states: Map<string, any>, coreEnabled: Enum.CoreGuiType | {Enum.CoreGuiType}, coreDisabled: Enum.CoreGuiType | {Enum.CoreGuiType}) -> Application

export type BuildContextConstructor = (navigator: Navigator, theme: Theme, locale: Locale, states: Value<Map<string, any>>, deviceInformation: Device) -> BuildContext

export type ColorSchemeConstructor = (primary: Color3, secondary: Color3, error: Color3, neutral: Color3, tertiary: Color3?) -> ColorScheme

export type DeviceConstructor = {
    of: (context: BuildContext) -> Device
} & () -> Device

export type LocaleConstructor = {
    of: (context: BuildContext) -> Locale
} & () -> Locale

export type NavigatorConstructor = {
    of: (context: BuildContext) -> Navigator,
    new: (initialRoute: any, routes: Map<string, Page>) -> Navigator
} & (initialRoute: any, routes: Map<string, Page>) -> Navigator

export type PageConstructor = () -> Page

export type RouteConstructor = () ->  Route

export type TextStyleConstructor = () -> TextStyle

export type TextThemeConstructor = () -> TextTheme

export type ThemeConstructor = {
    of: (context: BuildContext) -> Theme,
    dark: () -> Theme,
    fallback: () -> Theme,
    light: () -> Theme,
    
    from: (colorScheme: ColorScheme, textTheme: TextTheme) -> Theme
} & (colorScheme: ColorScheme, textTheme: TextTheme) -> Theme

export type ThemeDataConstructor = (colorScheme: ColorScheme, textTheme: TextTheme) -> ThemeData

return nil