--!strict

local Package = script.Parent.Parent;
local CoreTypes = require(Package.Parent.Core.PubTypes);
local FieldTypes = require(Package.Parent.Field.Types.PubTypes);

type Value<T> = CoreTypes.Value<T>
type Computed<T> = CoreTypes.Computed<T>
type Choice<T> = FieldTypes.Choice<T>

type Map<K,V> = {[K]: V}

--[=[
    @interface IApplication
    @within Application

    destroy (Application) -> () -- Destructor of the Application.
    updateState (Application, state: string, value: any) -> () -- Update the given universal state with the given value.

    navigator Navigator -- The top-level Navigator configured by the Application to search for routes.
    theme Theme -- Default visual properties, like colors fonts and shapes, for this app's material widgets.
    states Value<Map<string, any>> -- The top-level Provider for universal states within the Application.
    locale Locale -- The top-level Provider for translating text for clients based on keys.
    deviceInformation Device -- The top-level Provider for information on the device being used.
    ui ScreenGui -- The holder of the pages generated from the Navigator's currentRoute.
]=]--
export type Application = {
    destroy: (Application) -> (),
    updateState: (Application, state: string, value: any) -> (),

    navigator: Navigator,
    theme: Theme,
    states: Value<Map<string, any>>,
    locale: Locale,
    deviceInformation: Device,
    ui: ScreenGui
}

--[=[
    @interface IBuildContext
    @within BuildContext

    navigator Navigator -- The Navigator of the Application.
    theme Theme -- The Theme of the Application.
    states Value<Map<string, any>> -- The State Provider of the Application.
    locale Locale -- The Locale Provider of the Application.
    deviceInformation Device -- The Device Provider of the Application.
]=]--
export type BuildContext = {
    navigator: Navigator,
    theme: Theme,
    states: Value<Map<string, any>>,
    locale: Locale,
    deviceInformation: Device
}

--[=[
    @type ColorSchemeColors
    @within ColorScheme

    primary Color3 -- The color displayed most frequently across your app’s screens and components.
    onPrimary Color3 -- A color that's clearly legible when drawn on primary.
    primaryContainer Color3 -- A color used for elements needing less emphasis than primary.
    onPrimaryContainer Color3 -- A color that's clearly legible when drawn on primaryContainer.
    secondary Color3 -- An accent color used for less prominent components in the UI, such as filter chips, while expanding the opportunity for color expression.
    onSecondary Color3 -- A color that's clearly legible when drawn on secondary.
    secondaryContainer Color3 -- A color used for elements needing less emphasis than secondary.
    onSecondaryContainer Color3 -- A color that's clearly legible when drawn on secondaryContainer.
    tertiary: Color3? -- A color used as a contrasting accent that can balance primary and secondary colors or bring heightened attention to an element, such as an input field.
    onTertiary: Color3? -- A color that's clearly legible when drawn on tertiary.
    tertiaryContainer: Color3? -- A color used for elements needing less emphasis than tertiary.
    onTertiaryContainer: Color3? -- A color that's clearly legible when drawn on tertiaryContainer.
    error Color3 -- The color to use for input validation errors, e.g. for InputDecoration.errorText.
    onError Color3 -- A color that's clearly legible when drawn on error.
    errorContainer Color3 -- A color used for error elements needing less emphasis than error.
    onErrorContainer Color3 -- A color that's clearly legible when drawn on errorContainer.
    neutral Color3 -- A color that typically appears behind scrollable content.
    onNeutral Color3 -- A color that's clearly legible when drawn on neutral.
    neutralContainer Color3 -- A color used for neutral elements needing less emphasis than neutral.
    onNeutralContainer Color3 -- A color that's clearly legible when drawn on neutralContainer.
]=]--
type ColorSchemeColors = {
    primary: Color3,
    onPrimary: Color3,
    primaryContainer: Color3,
    onPrimaryContainer: Color3,
    secondary: Color3,
    onSecondary: Color3,
    secondaryContainer: Color3,
    onSecondaryContainer: Color3,
    tertiary: Color3?,
    onTertiary: Color3?,
    tertiaryContainer: Color3?,
    onTertiaryContainer: Color3?,
    error: Color3,
    onError: Color3,
    errorContainer: Color3,
    onErrorContainer: Color3,
    neutral: Color3,
    onNeutral: Color3,
    neutralContainer: Color3,
    onNeutralContainer: Color3
}

--[=[
    @interface IColorScheme
    @within ColorScheme

    update (ColorScheme, primary: Color3, secondary: Color3, error: Color3, neutral: Color3, tertiary: Color3?) -> () -- 

    primary Value<Color3> -- The color to use for key components across the UI, such as the FAB, prominent buttons, and active states.
    secondary Value<Color3> -- The color to use for less prominent components in the UI, such as filter chips, while expanding the opportunity for color expression.
    tertiary Value<Color3> -- The color to use for contrasting accents that can be used to balance primary and secondary colors or bring heightened attention to an element, such as an input field. The tertiary colors are left for makers to use at their discretion and are intended to support broader color expression in products.
    error Value<Color3> -- The color to use for input validation errors, e.g. for InputDecoration.errorText.
    neutral Value<Color3> -- The color to use for backgrounds and surfaces, as well as for dividers and shadows.
    isDark Computed<boolean> -- The overall brightness indicator of this color scheme.
    colors Computed<Map<string, Color3>> -- A set of 20 colors based on the Material spec that can be used to configure the color properties of most components.
]=]--
export type ColorScheme = {
    update: (ColorScheme, primary: Color3, secondary: Color3, error: Color3, neutral: Color3, tertiary: Color3?) -> (),

    primary: Value<Color3>,
    secondary: Value<Color3>,
    tertiary: Value<Color3>,
    error: Value<Color3>,
    neutral: Value<Color3>,
    isDark: Computed<boolean>,
    colors: Computed<Map<string, Color3>>
}

--[=[
    @type DeviceType "Phone" | "Tablet" | "Desktop"
    @within Device
]=]--
export type DeviceType = "Phone" | "Tablet" | "Desktop"

--[=[
    @type InputType "MouseKeyboard" | "Touch" | "Gamepad"
    @within Device
]=]--
export type InputType = "MouseKeyboard" | "Touch" | "Gamepad"

--[=[
    @interface IDevice
    @within Device

    deviceType Choice<DeviceType> -- The client's detected InputType.
    inputType Choice<InputType> -- The client's detected InputType.
    orientationType Value<Enum.ScreenOrientation> -- The orientation of the client's screen.
    resolution Value<Vector2> -- The resolution of the client's Viewport.
]=]--
export type Device = {
    deviceType: Choice<DeviceType>,
    inputType: Choice<InputType>,
    orientationType: Value<Enum.ScreenOrientation>,
    resolution: Value<Vector2>,
}

--[=[
    @interface ILocale
    @within Locale

    translate (Locale, key: string, arguments: Map<string, any>?) -> string? -- Translate a given key to the localization with the given arguments.

    languageCode string -- 
    countryCode string -- 
]=]--
export type Locale = {
    translate: (Locale, key: string, arguments: Map<string, any>?) -> string?,

    languageCode: string,
    countryCode: string
}

--[=[
    @interface INavigator
    @within Navigator

    pushNamed (Navigator, name: string, arguments: Map<string, any>?) -> () -- Push a named route onto the navigator that most tightly encloses the given context.
    pop (Navigator) -> () -- Pop the top-most route off the navigator that most tightly encloses the given context.

    initialRoute any -- The name of the first route to show.
    routes Map<string, Page> -- The map of strings to Pages with which to render when the currentRoute's name changes.
    currentRoute Route -- The route to show.
    history {Route} -- The list of routes with which to populate the history.
]=]--
export type Navigator = {
    pushNamed: (Navigator, name: string, arguments: Map<string, any>?) -> (),
    pop: (Navigator) -> (),

    initialRoute: any,
    routes: Map<string, Page>,
    currentRoute: Route,
    history: {Route},
}

--[=[
    @interface IPage
    @within Page

    build (context: BuildContext) -> () -- Describes the part of the user interface represented by this widget.
]=]--
export type Page = {
    build: (context: BuildContext) -> ()
}

--[=[
    @interface IRoute
    @within Route

    arguments Map<string, any> -- The arguments passed to this route.
    name Value<string> -- The name of the route (e.g., "/settings").
]=]--
export type Route = {
    name: Value<string>,
    arguments: Map<string, any>
}

--[=[
    @interface ITextStyle
    @within TextStyle

    font Enum.Font -- The name of the font to use when painting the text (e.g., Roboto).
    lineHeight number -- The height of this text span, as a multiple of the font size.
    size Enum.FontSize -- The size of glyphs (in logical pixels) to use when painting the text.
]=]--
export type TextStyle = {
    font: Enum.Font,
    lineHeight: number,
    size: Enum.FontSize
}

--[=[
    @interface ITextTheme
    @within TextTheme

    bodySmall TextStyle -- Smallest of the body styles.
    bodyMedium TextStyle -- Middle size of the body styles.
    bodyLarge TextStyle -- Largest of the body styles.
    labelSmall TextStyle -- Middle size of the label styles.
    labelMedium TextStyle -- Smallest of the label styles.
    labelLarge TextStyle -- Largest of the label styles.
    titleSmall TextStyle -- Smallest of the title styles.
    titleMedium TextStyle -- Middle size of the title styles.
    titleLarge TextStyle -- Largest of the title styles.
    headlineSmall TextStyle -- Smallest of the headline styles.
    headlineMedium TextStyle -- Middle size of the headline styles.
    headlineLarge TextStyle -- Largest of the headline styles.
    displaySmall TextStyle -- Smallest of the display styles.
    displayMedium TextStyle -- Middle size of the display styles.
    displayLarge TextStyle -- Largest of the display styles.
]=]--
export type TextTheme = {
    bodySmall: TextStyle,
    bodyMedium: TextStyle,
    bodyLarge: TextStyle,
    labelSmall: TextStyle,
    labelMedium: TextStyle,
    labelLarge: TextStyle,
    titleSmall: TextStyle,
    titleMedium: TextStyle,
    titleLarge: TextStyle,
    headlineSmall: TextStyle,
    headlineMedium: TextStyle,
    headlineLarge: TextStyle,
    displaySmall: TextStyle,
    displayMedium: TextStyle,
    displayLarge: TextStyle
}

--[=[
    @interface ITheme
    @within Theme

    data ThemeData -- Specifies the color and typography values for descendant widgets.
]=]--
export type Theme = {
    data: ThemeData
}

--[=[
    @type ThemeDataColors
    @within ThemeData
    
    appBarColor Color3 -- The default color of AppBar elements.
    backgroundColor Color3 -- A color that contrasts with the primaryColor, e.g. used as the remaining part of a progress bar.
    canvasColor Color3 -- The default color of MaterialType.canvas Material.
    cardColor Color3 -- The color of Material when it is used as a Card.
    dialogBackgroundColor Color3 -- The background color of Dialog elements.
    disabledColor Color3 -- The color used for widgets that are inoperative, regardless of their state. For example, a disabled checkbox (which may be checked or unchecked).
    dividerColor Color3 -- The color of Dividers and PopupMenuDividers, also used between ListTiles, between rows in DataTables, and so forth.
    errorColor Color3 -- The color to use for input validation errors, e.g. in TextField fields.
    focusColor Color3 -- The focus color used indicate that a component has the input focus.
    highlightColor Color3 -- The highlight color used during ink splash animations or to indicate an item in a menu is selected.
    hintColor Color3 -- The color to use for hint text or placeholder text, e.g. in TextField fields.
    hoverColor Color3 -- The hover color used to indicate when a pointer is hovering over a component.
    indicatorColor Color3 -- The color of the selected tab indicator in a tab bar.
    primaryColor Color3 -- The background color for major parts of the app (toolbars, tab bars, etc).
    scaffoldBackgroundColor Color3 -- The default color of the Material that underlies the Scaffold. The background color for a typical material app or a page within the app.
    secondaryHeaderColor Color3 -- The color of the header of a PaginatedDataTable when there are selected rows.
    selectedRowColor Color3 -- The color used to highlight selected rows.
    shadowColor Color3 -- The color that the Material widget uses to draw elevation shadows.
    splashColor Color3 -- The color of ink splashes.
    toggleableActiveColor Color3 -- The color used to highlight the active states of toggleable widgets like Switch, Radio, and Checkbox.
    unselectedWidgetColor Color3 -- The color used for widgets in their inactive (but enabled) state. For example, an unchecked checkbox. See also disabledColor.
]=]--
type ThemeDataColors = {
    appBarColor: Color3,
    backgroundColor: Color3,
    canvasColor: Color3,
    cardColor: Color3,
    dialogBackgroundColor: Color3,
    disabledColor: Color3,
    dividerColor: Color3,
    errorColor: Color3,
    focusColor: Color3,
    highlightColor: Color3,
    hintColor: Color3,
    hoverColor: Color3,
    indicatorColor: Color3,
    primaryColor: Color3,
    scaffoldBackgroundColor: Color3,
    secondaryHeaderColor: Color3,
    selectedRowColor: Color3,
    shadowColor: Color3,
    splashColor: Color3,
    toggleableActiveColor: Color3,
    unselectedWidgetColor: Color3
}

--[=[
    @interface IThemeData
    @within ThemeData

    colorScheme ColorScheme -- A set of twelve colors that can be used to configure the color properties of most components.
    textTheme TextTheme -- Text with a color that contrasts with the card and canvas colors.
    colors Computed<ThemeDataColors> -- The colors used for most components. Derived from ColorScheme.
]=]--
export type ThemeData = {
    colorScheme: ColorScheme,
    textTheme: TextTheme,

    colors: Computed<ThemeDataColors>
}

return nil