-- ========================================
-- SIGNAL.LUA - Custom Event System
-- ========================================

local Signal = {}
Signal.__index = Signal

-- ========== CREATE NEW SIGNAL ==========
function Signal.new()
	local self = setmetatable({}, Signal)
	self._bindable = Instance.new("BindableEvent")
	return self
end

-- ========== CONNECT TO SIGNAL ==========
function Signal:Connect(callback)
	return self._bindable.Event:Connect(callback)
end

-- ========== FIRE SIGNAL ==========
function Signal:Fire(...)
	self._bindable:Fire(...)
end

-- ========== WAIT FOR SIGNAL ==========
function Signal:Wait()
	return self._bindable.Event:Wait()
end

-- ========== DISCONNECT ALL ==========
function Signal:DisconnectAll()
	if self._bindable then
		self._bindable:Destroy()
		self._bindable = Instance.new("BindableEvent")
	end
end

-- ========== DESTROY SIGNAL ==========
function Signal:Destroy()
	if self._bindable then
		self._bindable:Destroy()
		self._bindable = nil
	end
	setmetatable(self, nil)
end

return Signal