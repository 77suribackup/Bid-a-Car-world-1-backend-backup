-- ========================================
-- TIER SELECTION UI - Bid Tier Selection
-- ========================================

local TierSelectionUI = {}
local Theme = require(game.ReplicatedStorage.Modules.Theme)
local Config = require(game.ReplicatedStorage.Modules.Config)
local UIUtilities = require(game.ReplicatedStorage.Modules.UIUtilities)

-- ========== CREATE SCREEN ==========
function TierSelectionUI:Create(uiManager, data)
	local screenContainer = UIUtilities:CreateFrame(uiManager.Layers.Screen, {
		Name = "TierSelectionUI",
		BackgroundColor3 = Theme.Colors.Background,
		BackgroundTransparency = 0,
	})
	
	-- Header
	local header = UIUtilities:CreateFrame(screenContainer, {
		Name = "Header",
		BackgroundColor3 = Theme.Colors.BackgroundSecondary,
		Size = UDim2.new(1, 0, 0, 80),
		Position = UDim2.new(0, 0, 0, 0),
	})
	
	local title = UIUtilities:CreateLabel(header, {
		Name = "Title",
		Text = "← SELECT BID TIER",
		Size = UDim2.new(1, 0, 1, 0),
		TextColor3 = Theme.Colors.Primary,
		TextSize = 28,
		Font = Theme.Fonts.Heading,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	
	-- Back button
	local backBtn = UIUtilities:CreateButton(screenContainer, {
		Name = "BackBtn",
		Text = "←",
		Size = UDim2.new(0, 50, 0, 50),
		Position = UDim2.new(0, 16, 0, 16),
		BackgroundColor3 = Theme.Colors.BackgroundSecondary,
		CornerRadius = Theme.Sizes.RadiusMedium,
		Stroke = false,
	})
	
	backBtn.TextColor3 = Theme.Colors.Primary
	backBtn.TextSize = 24
	
	-- Scroll container
	local scrollContainer = UIUtilities:CreateScrollFrame(screenContainer, {
		Name = "ScrollContainer",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -150),
		Position = UDim2.new(0, 0, 0, 80),
		ScrollingDirection = Enum.ScrollingDirection.Horizontal,
	})
	
	-- Tiers layout
	local tiersLayout = Instance.new("UIListLayout")
	tiersLayout.FillDirection = Enum.FillDirection.Horizontal
	tiersLayout.Padding = UDim.new(0, 20)
	tiersLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	tiersLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	tiersLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tiersLayout.Parent = scrollContainer
	
	-- Create tier cards
	local tierNames = {"BEGINNER", "ADVANCED", "EXPERT", "CHOSEN"}
	local tierColors = {
		Theme.Colors.Primary,
		Theme.Colors.Secondary,
		Theme.Colors.Rare,
		Theme.Colors.SPEC,
	}
	
	for i, tierName in ipairs(tierNames) do
		local tierConfig = Config.BidTiers[tierName]
		local tierCard = UIUtilities:CreateFrame(scrollContainer, {
			Name = tierName .. "Card",
			BackgroundColor3 = Theme.Colors.BackgroundTertiary,
			Size = UDim2.new(0, 200, 0, 280),
			CornerRadius = Theme.Sizes.RadiusLarge,
			Stroke = { Color = tierColors[i], Thickness = 2 },
		})
		
		-- Tier name
		local tierTitle = UIUtilities:CreateLabel(tierCard, {
			Name = "TierName",
			Text = tierName,
			Size = UDim2.new(1, 0, 0, 50),
			Position = UDim2.new(0, 0, 0, 10),
			TextColor3 = tierColors[i],
			TextSize = 20,
			Font = Theme.Fonts.Heading,
		})
		
		-- Price
		local priceLabel = UIUtilities:CreateLabel(tierCard, {
			Name = "Price",
			Text = "$" .. tierConfig.Price,
			Size = UDim2.new(1, 0, 0, 40),
			Position = UDim2.new(0, 0, 0, 60),
			TextColor3 = Theme.Colors.Primary,
			TextSize = 24,
			Font = Theme.Fonts.Button,
		})
		
		-- Info text
		local infoText = UIUtilities:CreateLabel(tierCard, {
			Name = "Info",
			Text = tierConfig.DecoMin .. "-" .. tierConfig.DecoMax .. " Decorations\n" .. (tierConfig.LockerChance > 0 and "Locker: " .. math.floor(tierConfig.LockerChance * 100) .. "%" or "No Locker"),
			Size = UDim2.new(1, -20, 0, 80),
			Position = UDim2.new(0, 10, 0, 110),
			TextColor3 = Theme.Colors.TextSecondary,
			TextSize = 12,
			Font = Theme.Fonts.Caption,
			TextXAlignment = Enum.TextXAlignment.Center,
		})
		
		-- Play button
		local playBtn = UIUtilities:CreateButton(tierCard, {
			Name = "PlayBtn",
			Text = "PLAY",
			Size = UDim2.new(1, -20, 0, 40),
			Position = UDim2.new(0, 10, 1, -50),
			BackgroundColor3 = tierColors[i],
			CornerRadius = Theme.Sizes.RadiusMedium,
		})
		
		-- Play button callback
		playBtn.MouseButton1Click:Connect(function()
			print("[TierSelection] Starting " .. tierName .. " bid")
			uiManager:ShowScreen("BidUI", { tier = tierName })
		end)
		
		-- Hover effects
		UIUtilities:AddHoverEffect(playBtn, tierColors[i], Color3.new(
			math.min(tierColors[i].R * 1.2, 1),
			math.min(tierColors[i].G * 1.2, 1),
			math.min(tierColors[i].B * 1.2, 1)
		))
		
		UIUtilities:AddRippleEffect(playBtn, tierColors[i])
	end
	
	-- Update scroll canvas
	scrollContainer.CanvasSize = UDim2.new(0, 240 * #tierNames, 0, 0)
	
	-- Back button callback
	backBtn.MouseButton1Click:Connect(function()
		uiManager:HideScreen("TierSelectionUI")
	end)
	
	UIUtilities:AddHoverEffect(backBtn, Theme.Colors.BackgroundSecondary, Theme.Colors.BackgroundTertiary)
	
	-- Fade in
	screenContainer.BackgroundTransparency = 1
	UIUtilities:FadeIn(screenContainer, Theme.Animations.Normal)
	
	return screenContainer
end

return TierSelectionUI