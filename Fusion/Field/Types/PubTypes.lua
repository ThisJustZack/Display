--!strict

local CoreTypes = require(script.Parent.Parent.Parent.Core.PubTypes)

export type Choice<T> = CoreTypes.Value<T>
export type Monetary = CoreTypes.Value<string>
export type Secret = CoreTypes.Value<string>

return nil