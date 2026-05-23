-- ========================================
-- BID UI - Main Bid Arena Interface
-- ========================================

local BidUI = {}
local Theme = require(game.ReplicatedStorage.Modules.Theme)
local UIUtilities = require(game.ReplicatedStorage.Modules.UIUtilities)

-- ========== CREATE SCREEN ==========
function BidUI:Create(uiManager, data)
	local screenContainer = UIUtilities:CreateFrame(uiManager.Layers.Screen, {
		Name = "BidUI",
		BackgroundColor3 = Theme.Colors.Background,
		BackgroundTransparency = 0,
	})
	
	-- Top info bar
	local topBar = UIUtilities:CreateFrame(screenContainer, {
		Name = "TopBar",
		BackgroundColor3 = Theme.Colors.BackgroundSecondary,
		Size = UDim2.new(1, 0, 0, 60),
		Position = UDim2.new(0, 0, 0, 0),
	})
	
	-- Tier display
	local tierLabel = UIUtilities:CreateLabel(topBar, {
		Name = "TierLabel",
		Text = data.tier or "TIER",
		Size = UDim2.new(0, 200, 1, 0),
		Position = UDim2.new(0, 16, 0, 0),
		TextColor3 = Theme.Colors.Primary,
		TextSize = 20,
		Font = Theme.Fonts.Heading,
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	
	-- Timer
	local timerLabel = UIUtilities:CreateLabel(topBar, {
		Name = "Timer",
		Text = "2:45",
		Size = UDim2.new(0, 100, 1, 0),
		Position = UDim2.new(0.5, -50, 0, 0),
		TextColor3 = Theme.Colors.Primary,
		TextSize = 24,
		Font = Theme.Fonts.Button,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	
	-- Back button
	local backBtn = UIUtilities:CreateButton(topBar, {
		Name = "BackBtn",
		Text = "←",
		Size = UDim2.new(0, 50, 0, 50),
		Position = UDim2.new(1, -66, 0.5, -25),
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		CornerRadius = Theme.Sizes.RadiusMedium,
		Stroke = false,
	})
	
	backBtn.TextColor3 = Theme.Colors.Primary
	backBtn.TextSize = 20
	
	-- NPC Section (Left side)
	local npcSection = UIUtilities:CreateFrame(screenContainer, {
		Name = "NPCSection",
		BackgroundTransparency = 1,
		Size = UDim2.new(0.3, 0, 0.7, 0),
		Position = UDim2.new(0, 16, 0, 80),
	})
	
	local npcTitle = UIUtilities:CreateLabel(npcSection, {
		Name = "NPCTitle",
		Text = "COMPETITORS",
		Size = UDim2.new(1, 0, 0, 30),
		Position = UDim2.new(0, 0, 0, 0),
		TextColor3 = Theme.Colors.Secondary,
		TextSize = 16,
		Font = Theme.Fonts.Heading,
	})
	
	-- NPC list
	local npcList = UIUtilities:CreateScrollFrame(npcSection, {
		Name = "NPCList",
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		Size = UDim2.new(1, 0, 1, -40),
		Position = UDim2.new(0, 0, 0, 40),
		CornerRadius = Theme.Sizes.RadiusMedium,
		ListLayout = {
			Padding = UDim.new(0, 8),
			FillDirection = Enum.FillDirection.Vertical,
		},
	})
	
	-- Add NPC entries (dummy data)
	for i = 1, 5 do
		local npcEntry = UIUtilities:CreateFrame(npcList, {
			Name = "NPC" .. i,
			BackgroundColor3 = Theme.Colors.BackgroundSecondary,
			Size = UDim2.new(1, -16, 0, 50),
			Position = UDim2.new(0, 8, 0, 0),
			CornerRadius = Theme.Sizes.RadiusSmall,
		})
		
		local npcName = UIUtilities:CreateLabel(npcEntry, {
			Name = "Name",
			Text = "NPC #" .. i,
			Size = UDim2.new(0.6, -8, 1, 0),
			Position = UDim2.new(0, 8, 0, 0),
			TextColor3 = Theme.Colors.TextPrimary,
			TextSize = 14,
			Font = Theme.Fonts.Body,
		})
		
		local npcBid = UIUtilities:CreateLabel(npcEntry, {
			Name = "Bid",
			Text = "$" .. (i * 100),
			Size = UDim2.new(0.4, 0, 1, 0),
			Position = UDim2.new(0.6, 0, 0, 0),
			TextColor3 = Theme.Colors.Primary,
			TextSize = 14,
			Font = Theme.Fonts.Button,
			TextXAlignment = Enum.TextXAlignment.Right,
		})
	end
	
	npcList.CanvasSize = UDim2.new(0, 0, 0, 50 * 5 + 8 * 6)
	
	-- Car Display (Center)
	local carSection = UIUtilities:CreateFrame(screenContainer, {
		Name = "CarSection",
		BackgroundTransparency = 1,
		Size = UDim2.new(0.4, 0, 0.7, 0),
		Position = UDim2.new(0.3, 0, 0.08, 0),
	})
	
	local carFrame = UIUtilities:CreateFrame(carSection, {
		Name = "CarFrame",
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		Size = UDim2.new(1, 0, 1, 0),
		CornerRadius = Theme.Sizes.RadiusLarge,
		Stroke = { Color = Theme.Colors.Primary, Thickness = 2 },
	})
	
	local carLabel = UIUtilities:CreateLabel(carFrame, {
		Name = "CarLabel",
		Text = "3D CAR MODEL\n(Bid Battles Arena)",
		Size = UDim2.new(1, 0, 1, 0),
		TextColor3 = Theme.Colors.TextSecondary,
		TextSize = 16,
		Font = Theme.Fonts.Body,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
	})
	
	-- Info Section (Right side)
	local infoSection = UIUtilities:CreateFrame(screenContainer, {
		Name = "InfoSection",
		BackgroundTransparency = 1,
		Size = UDim2.new(0.3, 0, 0.7, 0),
		Position = UDim2.new(0.7, 0, 0, 80),
	})
	
	local infoTitle = UIUtilities:CreateLabel(infoSection, {
		Name = "InfoTitle",
		Text = "DECORATIONS",
		Size = UDim2.new(1, 0, 0, 30),
		Position = UDim2.new(0, 0, 0, 0),
		TextColor3 = Theme.Colors.Secondary,
		TextSize = 16,
		Font = Theme.Fonts.Heading,
	})
	
	-- Info list
	local infoList = UIUtilities:CreateScrollFrame(infoSection, {
		Name = "InfoList",
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		Size = UDim2.new(1, 0, 1, -40),
		Position = UDim2.new(0, 0, 0, 40),
		CornerRadius = Theme.Sizes.RadiusMedium,
		ListLayout = {
			Padding = UDim.new(0, 8),
			FillDirection = Enum.FillDirection.Vertical,
		},
	})
	
	-- Add decoration entries (dummy data)
	for i = 1, 4 do
		local decoEntry = UIUtilities:CreateFrame(infoList, {
			Name = "Deco" .. i,
			BackgroundColor3 = Theme.Colors.BackgroundSecondary,
			Size = UDim2.new(1, -16, 0, 50),
			Position = UDim2.new(0, 8, 0, 0),
			CornerRadius = Theme.Sizes.RadiusSmall,
		})
		
		local decoName = UIUtilities:CreateLabel(decoEntry, {
			Name = "Name",
			Text = "Item #" .. i,
			Size = UDim2.new(1, -16, 1, 0),
			Position = UDim2.new(0, 8, 0, 0),
			TextColor3 = Theme.Colors.TextPrimary,
			TextSize = 14,
			Font = Theme.Fonts.Body,
		})
	end
	
	infoList.CanvasSize = UDim2.new(0, 0, 0, 50 * 4 + 8 * 5)
	
	-- Bottom action bar
	local actionBar = UIUtilities:CreateFrame(screenContainer, {
		Name = "ActionBar",
		BackgroundColor3 = Theme.Colors.BackgroundSecondary,
		Size = UDim2.new(1, 0, 0, 100),
		Position = UDim2.new(0, 0, 1, -100),
	})
	
	-- Current bid display
	local currentBidDisplay = UIUtilities:CreateFrame(actionBar, {
		Name = "CurrentBidDisplay",
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		Size = UDim2.new(0, 200, 0, 60),
		Position = UDim2.new(0.5, -100, 0.5, -30),
		CornerRadius = Theme.Sizes.RadiusLarge,
		Stroke = { Color = Theme.Colors.Accent, Thickness = 2 },
	})
	
	local bidLabel = UIUtilities:CreateLabel(currentBidDisplay, {
		Name = "BidLabel",
		Text = "CURRENT BID",
		Size = UDim2.new(1, 0, 0.4, 0),
		Position = UDim2.new(0, 0, 0, 5),
		TextColor3 = Theme.Colors.TextSecondary,
		TextSize = 12,
		Font = Theme.Fonts.Caption,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	
	local bidAmount = UIUtilities:CreateLabel(currentBidDisplay, {
		Name = "BidAmount",
		Text = "$500",
		Size = UDim2.new(1, 0, 0.6, 0),
		Position = UDim2.new(0, 0, 0.4, 0),
		TextColor3 = Theme.Colors.Accent,
		TextSize = 28,
		Font = Theme.Fonts.Button,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	
	-- BID Button (main action)
	local bidBtn = UIUtilities:CreateButton(actionBar, {
		Name = "BidBtn",
		Text = "🖐️ RAISE HAND",
		Size = UDim2.new(0, 200, 0, 60),
		Position = UDim2.new(0.5, -100, 0.5, 35),
		BackgroundColor3 = Theme.Colors.Primary,
		CornerRadius = Theme.Sizes.RadiusLarge,
	})
	
	-- Fold Button
	local foldBtn = UIUtilities:CreateButton(actionBar, {
		Name = "FoldBtn",
		Text = "FOLD",
		Size = UDim2.new(0, 80, 0, 60),
		Position = UDim2.new(1, -96, 0.5, 35),
		BackgroundColor3 = Theme.Colors.Error,
		CornerRadius = Theme.Sizes.RadiusMedium,
	})
	
	-- Hover effects
	UIUtilities:AddHoverEffect(bidBtn, Theme.Colors.Primary, Theme.Colors.PrimaryLight)
	UIUtilities:AddHoverEffect(foldBtn, Theme.Colors.Error, Color3.fromHex("ff6b6b"))
	UIUtilities:AddHoverEffect(backBtn, Theme.Colors.BackgroundTertiary, Theme.Colors.BackgroundSecondary)
	
	-- Ripple effects
	UIUtilities:AddRippleEffect(bidBtn, Theme.Colors.PrimaryLight)
	UIUtilities:AddRippleEffect(foldBtn, Color3.fromHex("ff6b6b"))
	
	-- Button callbacks
	bidBtn.MouseButton1Click:Connect(function()
		print("[BidUI] Player raised hand!")
		uiManager.Signals.BidStarted:Fire()
	end)
	
	foldBtn.MouseButton1Click:Connect(function()
		print("[BidUI] Player folded")
		uiManager:HideScreen("BidUI")
	end)
	
	backBtn.MouseButton1Click:Connect(function()
		uiManager:HideScreen("BidUI")
	end)
	
	-- Fade in
	screenContainer.BackgroundTransparency = 1
	UIUtilities:FadeIn(screenContainer, Theme.Animations.Normal)
	
	return screenContainer
end

return BidUI