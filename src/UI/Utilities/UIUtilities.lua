-- ========================================
-- UI UTILITIES.LUA - Helper Functions
-- ========================================

local Theme = require(game.ReplicatedStorage.Modules.Theme)
local UIUtilities = {}

-- ========== CREATE FRAME ==========
function UIUtilities:CreateFrame(parent, properties)
	properties = properties or {}
	
	local frame = Instance.new("Frame")
	frame.Name = properties.Name or "Frame"
	frame.Parent = parent
	frame.BackgroundColor3 = properties.BackgroundColor3 or Theme.Colors.Background
	frame.BackgroundTransparency = properties.BackgroundTransparency or 0
	frame.BorderSizePixel = 0
	frame.Size = properties.Size or UDim2.new(1, 0, 1, 0)
	frame.Position = properties.Position or UDim2.new(0, 0, 0, 0)
	frame.ZIndex = properties.ZIndex or 1
	
	if properties.CornerRadius then
		local corner = Instance.new("UICorner")
		corner.CornerRadius = properties.CornerRadius
		corner.Parent = frame
	end
	
	if properties.Stroke then
		local stroke = Instance.new("UIStroke")
		stroke.Color = properties.Stroke.Color or Theme.Colors.Primary
		stroke.Thickness = properties.Stroke.Thickness or 2
		stroke.Transparency = properties.Stroke.Transparency or 0
		stroke.Parent = frame
	end
	
	if properties.Padding then
		local padding = Instance.new("UIPadding")
		padding.PaddingTop = properties.Padding.Top or properties.Padding
		padding.PaddingBottom = properties.Padding.Bottom or properties.Padding
		padding.PaddingLeft = properties.Padding.Left or properties.Padding
		padding.PaddingRight = properties.Padding.Right or properties.Padding
		padding.Parent = frame
	end
	
	return frame
end

-- ========== CREATE BUTTON ==========
function UIUtilities:CreateButton(parent, properties)
	properties = properties or {}
	
	local button = Instance.new("TextButton")
	button.Name = properties.Name or "Button"
	button.Parent = parent
	button.BackgroundColor3 = properties.BackgroundColor3 or Theme.Colors.Primary
	button.BackgroundTransparency = properties.BackgroundTransparency or 0
	button.BorderSizePixel = 0
	button.Size = properties.Size or Theme.Sizes.ButtonMedium
	button.Position = properties.Position or UDim2.new(0, 0, 0, 0)
	button.Text = properties.Text or "Button"
	button.TextColor3 = properties.TextColor3 or Theme.Colors.Background
	button.TextScaled = true
	button.Font = properties.Font or Theme.Fonts.Button
	button.ZIndex = properties.ZIndex or 1
	
	-- Corner radius
	local corner = Instance.new("UICorner")
	corner.CornerRadius = properties.CornerRadius or Theme.Sizes.RadiusMedium
	corner.Parent = button
	
	-- Stroke
	if properties.Stroke ~= false then
		local stroke = Instance.new("UIStroke")
		stroke.Color = properties.StrokeColor or Theme.Colors.Primary
		stroke.Thickness = 2
		stroke.Transparency = 0
		stroke.Parent = button
	end
	
	return button
end

-- ========== CREATE LABEL ==========
function UIUtilities:CreateLabel(parent, properties)
	properties = properties or {}
	
	local label = Instance.new("TextLabel")
	label.Name = properties.Name or "Label"
	label.Parent = parent
	label.BackgroundTransparency = 1
	label.BorderSizePixel = 0
	label.Size = properties.Size or UDim2.new(1, 0, 0, 40)
	label.Position = properties.Position or UDim2.new(0, 0, 0, 0)
	label.Text = properties.Text or "Label"
	label.TextColor3 = properties.TextColor3 or Theme.Colors.TextPrimary
	label.TextSize = properties.TextSize or 16
	label.Font = properties.Font or Theme.Fonts.Body
	label.TextXAlignment = properties.TextXAlignment or Enum.TextXAlignment.Left
	label.TextYAlignment = properties.TextYAlignment or Enum.TextYAlignment.Center
	label.TextWrapped = properties.TextWrapped ~= false
	label.ZIndex = properties.ZIndex or 1
	
	return label
end

-- ========== CREATE IMAGE LABEL ==========
function UIUtilities:CreateImageLabel(parent, properties)
	properties = properties or {}
	
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = properties.Name or "ImageLabel"
	imageLabel.Parent = parent
	imageLabel.BackgroundTransparency = 1
	imageLabel.BorderSizePixel = 0
	imageLabel.Size = properties.Size or UDim2.new(0, 100, 0, 100)
	imageLabel.Position = properties.Position or UDim2.new(0, 0, 0, 0)
	imageLabel.Image = properties.Image or ""
	imageLabel.ImageColor3 = properties.ImageColor3 or Color3.new(1, 1, 1)
	imageLabel.ImageTransparency = properties.ImageTransparency or 0
	imageLabel.ScaleType = properties.ScaleType or Enum.ScaleType.Fit
	imageLabel.ZIndex = properties.ZIndex or 1
	
	if properties.CornerRadius then
		local corner = Instance.new("UICorner")
		corner.CornerRadius = properties.CornerRadius
		corner.Parent = imageLabel
	end
	
	return imageLabel
end

-- ========== CREATE SCROLL FRAME ==========
function UIUtilities:CreateScrollFrame(parent, properties)
	properties = properties or {}
	
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = properties.Name or "ScrollFrame"
	scrollFrame.Parent = parent
	scrollFrame.BackgroundColor3 = properties.BackgroundColor3 or Theme.Colors.BackgroundSecondary
	scrollFrame.BackgroundTransparency = properties.BackgroundTransparency or 0
	scrollFrame.BorderSizePixel = 0
	scrollFrame.Size = properties.Size or UDim2.new(1, 0, 1, 0)
	scrollFrame.Position = properties.Position or UDim2.new(0, 0, 0, 0)
	scrollFrame.ScrollBarThickness = properties.ScrollBarThickness or 8
	scrollFrame.ScrollingDirection = properties.ScrollingDirection or Enum.ScrollingDirection.Y
	scrollFrame.CanvasSize = properties.CanvasSize or UDim2.new(1, 0, 0, 0)
	scrollFrame.ZIndex = properties.ZIndex or 1
	
	-- Scroll bar styling
	scrollFrame.TopImage = "rbxasset://textures/Scrollbar/Top.png"
	scrollFrame.BottomImage = "rbxasset://textures/Scrollbar/Bottom.png"
	scrollFrame.MidImage = "rbxasset://textures/Scrollbar/Middle.png"
	scrollFrame.ScrollBarImageColor3 = properties.ScrollBarColor or Theme.Colors.Primary
	scrollFrame.ScrollBarImageTransparency = 0.3
	
	if properties.CornerRadius then
		local corner = Instance.new("UICorner")
		corner.CornerRadius = properties.CornerRadius
		corner.Parent = scrollFrame
	end
	
	-- UIListLayout
	if properties.ListLayout then
		local listLayout = Instance.new("UIListLayout")
		listLayout.Padding = properties.ListLayout.Padding or UDim.new(0, 8)
		listLayout.FillDirection = properties.ListLayout.FillDirection or Enum.FillDirection.Vertical
		listLayout.HorizontalAlignment = properties.ListLayout.HorizontalAlignment or Enum.HorizontalAlignment.Center
		listLayout.VerticalAlignment = properties.ListLayout.VerticalAlignment or Enum.VerticalAlignment.Top
		listLayout.SortOrder = properties.ListLayout.SortOrder or Enum.SortOrder.LayoutOrder
		listLayout.Parent = scrollFrame
	end
	
	return scrollFrame
end

-- ========== TWEEN UI ELEMENT ==========
function UIUtilities:Tween(instance, properties, duration, easingStyle, easingDirection, callback)
	duration = duration or Theme.Animations.Normal
	easingStyle = easingStyle or Theme.Animations.EaseInOutQuad
	easingDirection = easingDirection or Theme.Animations.EaseInOut
	
	local tweenInfo = TweenInfo.new(
		duration,
		easingStyle,
		easingDirection
	)
	
	local tween = game:GetService("TweenService"):Create(instance, tweenInfo, properties)
	
	if callback then
		tween.Completed:Connect(function()
			callback()
		end)
	end
	
	tween:Play()
	return tween
end

-- ========== FADE IN ==========
function UIUtilities:FadeIn(instance, duration, callback)
	instance.BackgroundTransparency = 1
	return self:Tween(instance, {
		BackgroundTransparency = 0,
	}, duration or Theme.Animations.Normal, nil, nil, callback)
end

-- ========== FADE OUT ==========
function UIUtilities:FadeOut(instance, duration, callback)
	instance.BackgroundTransparency = 0
	return self:Tween(instance, {
		BackgroundTransparency = 1,
	}, duration or Theme.Animations.Normal, nil, nil, callback)
end

-- ========== SLIDE IN ==========
function UIUtilities:SlideIn(instance, direction, distance, duration, callback)
	distance = distance or 100
	duration = duration or Theme.Animations.Normal
	
	local startPos = instance.Position
	
	if direction == "left" then
		instance.Position = startPos - UDim2.new(0, distance, 0, 0)
	elseif direction == "right" then
		instance.Position = startPos + UDim2.new(0, distance, 0, 0)
	elseif direction == "up" then
		instance.Position = startPos - UDim2.new(0, 0, 0, distance)
	elseif direction == "down" then
		instance.Position = startPos + UDim2.new(0, 0, 0, distance)
	end
	
	return self:Tween(instance, {
		Position = startPos,
	}, duration, nil, nil, callback)
end

-- ========== SCALE ANIMATION ==========
function UIUtilities:Scale(instance, targetScale, duration, callback)
	duration = duration or Theme.Animations.Normal
	
	local startScale = instance.Size
	instance.Size = startScale * targetScale
	
	return self:Tween(instance, {
		Size = startScale,
	}, duration, nil, nil, callback)
end

-- ========== PULSE EFFECT ==========
function UIUtilities:Pulse(instance, intensity, duration, callback)
	intensity = intensity or 1.1
	duration = duration or Theme.Animations.Normal
	
	local startSize = instance.Size
	
	self:Tween(instance, {
		Size = startSize * intensity,
	}, duration / 2, nil, nil, function()
		self:Tween(instance, {
			Size = startSize,
		}, duration / 2, nil, nil, callback)
	end)
end

-- ========== ROTATE ANIMATION ==========
function UIUtilities:Rotate(instance, targetRotation, duration, callback)
	duration = duration or Theme.Animations.Normal
	
	return self:Tween(instance, {
		Rotation = targetRotation,
	}, duration, nil, nil, callback)
end

-- ========== ADD HOVER EFFECT ==========
function UIUtilities:AddHoverEffect(button, originalColor, hoverColor, duration)
	duration = duration or Theme.Animations.Fast
	
	local connection
	
	button.MouseEnter:Connect(function()
		self:Tween(button, {
			BackgroundColor3 = hoverColor,
		}, duration)
	end)
	
	button.MouseLeave:Connect(function()
		self:Tween(button, {
			BackgroundColor3 = originalColor,
		}, duration)
	end)
end

-- ========== ADD RIPPLE EFFECT ==========
function UIUtilities:AddRippleEffect(button, color)
	button.MouseButton1Click:Connect(function()
		local ripple = Instance.new("Frame")
		ripple.Name = "Ripple"
		ripple.Parent = button
		ripple.BackgroundColor3 = color
		ripple.BackgroundTransparency = 0.7
		ripple.BorderSizePixel = 0
		ripple.Size = UDim2.new(0, 10, 0, 10)
		ripple.Position = UDim2.new(0.5, -5, 0.5, -5)
		
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = ripple
		
		self:Tween(ripple, {
			Size = UDim2.new(5, 0, 5, 0),
			Position = UDim2.new(0.5, -button.Size.X.Offset * 2.5, 0.5, -button.Size.Y.Offset * 2.5),
			BackgroundTransparency = 1,
		}, Theme.Animations.Normal, nil, nil, function()
			ripple:Destroy()
		end)
	end)
end

-- ========== ADD SHADOW ==========
function UIUtilities:AddShadow(instance, shadowColor, shadowSize, shadowTransparency)
	shadowColor = shadowColor or Color3.new(0, 0, 0)
	shadowSize = shadowSize or 10
	shadowTransparency = shadowTransparency or 0.7
	
	local shadow = Instance.new("Frame")
	shadow.Name = "Shadow"
	shadow.Parent = instance
	shadow.BackgroundColor3 = shadowColor
	shadow.BackgroundTransparency = shadowTransparency
	shadow.BorderSizePixel = 0
	shadow.Size = UDim2.new(1, shadowSize * 2, 1, shadowSize * 2)
	shadow.Position = UDim2.new(0, -shadowSize, 0, -shadowSize)
	shadow.ZIndex = instance.ZIndex - 1
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = instance:FindFirstChild("UICorner") and instance.UICorner.CornerRadius or Theme.Sizes.RadiusMedium
	corner.Parent = shadow
	
	instance.ZIndex = shadow.ZIndex + 1
	
	return shadow
end

-- ========== FORMAT MONEY ==========
function UIUtilities:FormatMoney(amount)
	if amount >= 1000000 then
		return string.format("$%.1fM", amount / 1000000)
	elseif amount >= 1000 then
		return string.format("$%.1fK", amount / 1000)
	else
		return string.format("$%d", amount)
	end
end

-- ========== FORMAT TIME ==========
function UIUtilities:FormatTime(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60
	
	if hours > 0 then
		return string.format("%dh %dm %ds", hours, minutes, secs)
	elseif minutes > 0 then
		return string.format("%dm %ds", minutes, secs)
	else
		return string.format("%ds", secs)
	end
end

-- ========== GET RARITY COLOR ==========
function UIUtilities:GetRarityColor(rarity)
	local rarityMap = {
		common = Theme.Colors.Common,
		uncommon = Theme.Colors.Uncommon,
		rare = Theme.Colors.Rare,
		epic = Theme.Colors.Epic,
		legendary = Theme.Colors.Legendary,
		spec = Theme.Colors.SPEC,
	}
	
	return rarityMap[rarity:lower()] or Theme.Colors.TextSecondary
end

return UIUtilities