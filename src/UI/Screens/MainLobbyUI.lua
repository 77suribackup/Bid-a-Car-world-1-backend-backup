-- ========================================
-- MAIN LOBBY UI - Main Lobby Screen
-- ========================================

local MainLobbyUI = {}
local Theme = require(game.ReplicatedStorage.Modules.Theme)
local UIUtilities = require(game.ReplicatedStorage.Modules.UIUtilities)

-- ========== CREATE SCREEN ==========
function MainLobbyUI:Create(uiManager, data)
	local screenContainer = UIUtilities:CreateFrame(uiManager.Layers.Screen, {
		Name = "MainLobbyUI",
		BackgroundColor3 = Theme.Colors.Background,
		BackgroundTransparency = 0,
	})
	
	-- Header with logo/title
	local header = UIUtilities:CreateFrame(screenContainer, {
		Name = "Header",
		BackgroundColor3 = Theme.Colors.BackgroundSecondary,
		Size = UDim2.new(1, 0, 0, 80),
		Position = UDim2.new(0, 0, 0, 0),
	})
	
	local title = UIUtilities:CreateLabel(header, {
		Name = "Title",
		Text = "BID A CAR",
		Size = UDim2.new(1, 0, 1, 0),
		TextColor3 = Theme.Colors.Primary,
		TextSize = 32,
		Font = Theme.Fonts.Title,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
	})
	
	-- Bottom bar with money display
	local bottomBar = UIUtilities:CreateFrame(screenContainer, {
		Name = "BottomBar",
		BackgroundColor3 = Theme.Colors.BackgroundSecondary,
		Size = UDim2.new(1, 0, 0, 70),
		Position = UDim2.new(0, 0, 1, -70),
	})
	
	local moneyDisplay = UIUtilities:CreateFrame(bottomBar, {
		Name = "MoneyDisplay",
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		Size = UDim2.new(0, 180, 0, 50),
		Position = UDim2.new(1, -200, 0.5, -25),
		CornerRadius = Theme.Sizes.RadiusLarge,
		Stroke = { Color = Theme.Colors.Primary, Thickness = 2 },
	})
	
	local moneyLabel = UIUtilities:CreateLabel(moneyDisplay, {
		Name = "MoneyLabel",
		Text = "$700",
		Size = UDim2.new(1, 0, 1, 0),
		TextColor3 = Theme.Colors.Primary,
		TextSize = 28,
		Font = Theme.Fonts.Button,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	
	-- Center buttons
	local buttonContainer = UIUtilities:CreateFrame(screenContainer, {
		Name = "ButtonContainer",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 500, 0, 100),
		Position = UDim2.new(0.5, -250, 0.5, -50),
	})
	
	-- Buttons layout
	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.Padding = UDim.new(0, 16)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = buttonContainer
	
	-- Garage Button
	local garageBtn = UIUtilities:CreateButton(buttonContainer, {
		Name = "GarageBtn",
		Text = "🏠 GARAGE",
		Size = UDim2.new(0, 150, 0, 60),
		BackgroundColor3 = Theme.Colors.Primary,
		CornerRadius = Theme.Sizes.RadiusLarge,
	})
	
	-- Events Button
	local eventsBtn = UIUtilities:CreateButton(buttonContainer, {
		Name = "EventsBtn",
		Text = "⚡ EVENTS",
		Size = UDim2.new(0, 150, 0, 60),
		BackgroundColor3 = Theme.Colors.Secondary,
		CornerRadius = Theme.Sizes.RadiusLarge,
	})
	
	-- Shop Button
	local shopBtn = UIUtilities:CreateButton(buttonContainer, {
		Name = "ShopBtn",
		Text = "🛒 SHOP",
		Size = UDim2.new(0, 150, 0, 60),
		BackgroundColor3 = Theme.Colors.Accent,
		CornerRadius = Theme.Sizes.RadiusLarge,
	})
	
	-- Settings Button (top left)
	local settingsBtn = UIUtilities:CreateButton(screenContainer, {
		Name = "SettingsBtn",
		Text = "⚙️",
		Size = UDim2.new(0, 50, 0, 50),
		Position = UDim2.new(0, 16, 0, 16),
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		CornerRadius = Theme.Sizes.RadiusMedium,
	})
	
	-- Inventory Button (top right)
	local inventoryBtn = UIUtilities:CreateButton(screenContainer, {
		Name = "InventoryBtn",
		Text = "📦",
		Size = UDim2.new(0, 50, 0, 50),
		Position = UDim2.new(1, -66, 0, 16),
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		CornerRadius = Theme.Sizes.RadiusMedium,
	})
	
	-- Hover effects
	UIUtilities:AddHoverEffect(garageBtn, Theme.Colors.Primary, Theme.Colors.PrimaryLight)
	UIUtilities:AddHoverEffect(eventsBtn, Theme.Colors.Secondary, Theme.Colors.SecondaryLight)
	UIUtilities:AddHoverEffect(shopBtn, Theme.Colors.Accent, Theme.Colors.AccentLight)
	UIUtilities:AddHoverEffect(settingsBtn, Theme.Colors.BackgroundTertiary, Theme.Colors.BackgroundSecondary)
	UIUtilities:AddHoverEffect(inventoryBtn, Theme.Colors.BackgroundTertiary, Theme.Colors.BackgroundSecondary)
	
	-- Button callbacks
	garageBtn.MouseButton1Click:Connect(function()
		print("[MainLobby] Garage clicked")
		uiManager:ShowScreen("TierSelectionUI")
	end)
	
	shopBtn.MouseButton1Click:Connect(function()
		print("[MainLobby] Shop clicked")
		uiManager:ShowScreen("ShopUI")
	end)
	
	inventoryBtn.MouseButton1Click:Connect(function()
		print("[MainLobby] Inventory clicked")
		uiManager:ShowScreen("InventoryUI")
	end)
	
	settingsBtn.MouseButton1Click:Connect(function()
		print("[MainLobby] Settings clicked")
	end)
	
	-- Ripple effects
	UIUtilities:AddRippleEffect(garageBtn, Theme.Colors.PrimaryLight)
	UIUtilities:AddRippleEffect(eventsBtn, Theme.Colors.SecondaryLight)
	UIUtilities:AddRippleEffect(shopBtn, Theme.Colors.AccentLight)
	
	-- Fade in animation
	screenContainer.BackgroundTransparency = 1
	UIUtilities:FadeIn(screenContainer, Theme.Animations.Normal)
	
	return screenContainer
end

return MainLobbyUI