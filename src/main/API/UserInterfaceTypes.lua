type Set<T> = {[number]: T};

type Map<K,V> = {[K]: V};

export type Application = {		
	ui : ScreenGui,
	navigator: Navigator,
	theme: Theme,
	locale: Locale,
	states: Map<string, State<any>>,
	
	destroy: () -> ();
	updateState: (state: string, value: any) -> ();
};

export type Route = {
	name: State<string>,
	arguments: Map<string, any>?
}

export type Navigator = {
	of: (context: BuildContext) -> Navigator,
	
	initialRoute: string,
	routes: Map<string, Page>,
	currentRoute: State<Route>,
	history: Set<Route>,
	
	pushNamed: (name: string) -> (),
	pop: () -> ()
};

export type ThemeData = {
	colorScheme: ColorScheme,
	textTheme: Map<string, Font>
}

export type ColorScheme = {
	update: (primary: Color3, secondary: Color3, tertiary: Color3, neutral: Color3, isDark: boolean) -> (),
	
	primary: State<Color3>,
	secondary: State<Color3>,
	tertiary: State<Color3>,
	neutral: State<Color3>,
	isDark: State<boolean>,
	
	colors: State<Map<string, Color3>>
}

export type TextStyle = {
	font: Enum.Font,
	size: Enum.FontSize,
	height: number
}

export type Theme = {
	of: (context: BuildContext) -> ThemeData,
	dark: () -> Theme,
	fallback: () -> Theme,
	light: () -> Theme,
	from: (colorScheme: ColorScheme, textTheme: Map<string, Font>?) -> Theme,
	
	data: ThemeData,
}

export type Locale = {
	of: (context: BuildContext) -> Locale,
	
	languageCode: string,
	countryCode: string,
	
	translate: (key: string, arguments: Map<string, any>) -> string,
};

export type DeviceType = "Desktop" | "Mobile" | "Tablet";

export type InputType = "MouseKeyboard" | "Touch" | "Gamepad";

export type Device = {
	deviceType: State<DeviceType>,
	inputType: State<InputType>,
	orientationType: State<Enum.ScreenOrientation>,
	resolution: State<Vector2>,
};

export type BuildContext = {
	theme: Theme,
	navigator: Navigator,
	locale: Locale,
	states: Map<string, State<any>>,
	deviceInformation: Device,
}

export type Widget = GuiObject;

export type Page = {
	build: () -> Widget,
}

return nil;