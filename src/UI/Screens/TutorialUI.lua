-- ========================================
-- TUTORIAL UI - Tutorial Overlay
-- ========================================

local TutorialUI = {}
local Theme = require(game.ReplicatedStorage.Modules.Theme)
local UIUtilities = require(game.ReplicatedStorage.Modules.UIUtilities)

-- ========== CREATE SCREEN ==========
function TutorialUI:Create(uiManager, data)
	local screenContainer = UIUtilities:CreateFrame(uiManager.Layers.Modal, {
		Name = "TutorialUI",
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.6,
		ZIndex = 50,
	})
	
	-- Tutorial box
	local tutorialBox = UIUtilities:CreateFrame(screenContainer, {
		Name = "TutorialBox",
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		Size = UDim2.new(0, 400, 0, 200),
		Position = UDim2.new(0.5, -200, 0.5, -100),
		CornerRadius = Theme.Sizes.RadiusLarge,
		Stroke = { Color = Theme.Colors.Primary, Thickness = 3 },
		ZIndex = 51,
	})
	
	-- Arrow pointer
	local arrow = UIUtilities:CreateLabel(screenContainer, {
		Name = "Arrow",
		Text = "👆",
		Size = UDim2.new(0, 50, 0, 50),
		Position = UDim2.new(0.5, -25, 0.25, -50),
		TextSize = 40,
		ZIndex = 52,
	})
	
	-- Title
	local title = UIUtilities:CreateLabel(tutorialBox, {
		Name = "Title",
		Text = "WELCOME TO BID A CAR!",
		Size = UDim2.new(1, 0, 0, 50),
		Position = UDim2.new(0, 0, 0, 0),
		TextColor3 = Theme.Colors.Primary,
		TextSize = 18,
		Font = Theme.Fonts.Heading,
	})
	
	-- Description
	local description = UIUtilities:CreateLabel(tutorialBox, {
		Name = "Description",
		Text = "Tap GARAGE and enter a Bid Battle!\\nRaise your hand to bid against bots.",
		Size = UDim2.new(1, -20, 0, 80),
		Position = UDim2.new(0, 10, 0, 50),
		TextColor3 = Theme.Colors.TextSecondary,
		TextSize = 14,
		Font = Theme.Fonts.Body,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	
	-- Got it button
	local gotItBtn = UIUtilities:CreateButton(tutorialBox, {
		Name = "GotItBtn",
		Text = "GOT IT!",
		Size = UDim2.new(0, 120, 0, 40),
		Position = UDim2.new(0.5, -60, 1, -50),
		BackgroundColor3 = Theme.Colors.Primary,
		CornerRadius = Theme.Sizes.RadiusMedium,
	})
	
	-- Pulse animation on arrow
	local pulseConnection
	pulseConnection = game:GetService("RunService").Heartbeat:Connect(function()
		if arrow.Parent then
			UIUtilities:Pulse(arrow, 1.2, 0.8)
		else
			pulseConnection:Disconnect()
		end
	end)
	
	-- Button callback
	gotItBtn.MouseButton1Click:Connect(function()
		UIUtilities:FadeOut(screenContainer, Theme.Animations.Normal, function()
			screenContainer:Destroy()
		end)
	end)
	
	-- Hover effect
	UIUtilities:AddHoverEffect(gotItBtn, Theme.Colors.Primary, Theme.Colors.PrimaryLight)
	
	-- Fade in
	screenContainer.BackgroundTransparency = 1
	UIUtilities:FadeIn(screenContainer, Theme.Animations.Slow)
	
	return screenContainer
end

return TutorialUI