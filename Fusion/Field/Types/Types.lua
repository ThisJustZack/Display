--!strict

local PubTypes = require(script.Parent.PubTypes)

export type Choice<T> = PubTypes.Choice<T> & {
	_value: T
}

export type Monetary = PubTypes.Monetary & {
    _value: number
}

export type Secret = PubTypes.Secret & {
    _value: string
}

return nil