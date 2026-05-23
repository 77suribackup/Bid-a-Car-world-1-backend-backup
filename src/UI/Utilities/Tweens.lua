-- ========================================
-- TWEENS.LUA - Tween Helpers & Presets
-- ========================================

local Theme = require(game.ReplicatedStorage.Modules.Theme)
local Tweens = {}

-- ========== QUICK FADE ==========
function Tweens.QuickFade(instance, inOrOut, callback)
	local tweenService = game:GetService("TweenService")
	local target = inOrOut == "in" and 0 or 1
	local tweenInfo = TweenInfo.new(Theme.Animations.Fast)
	
	local tween = tweenService:Create(instance, tweenInfo, {
		BackgroundTransparency = target
	})
	
	if callback then
		tween.Completed:Connect(callback)
	end
	
	tween:Play()
	return tween
end

-- ========== SMOOTH MOVE ==========
function Tweens.SmoothMove(instance, targetPosition, duration, easing, callback)
	local tweenService = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(
		duration or Theme.Animations.Normal,
		easing or Theme.Animations.EaseInOutQuad
	)
	
	local tween = tweenService:Create(instance, tweenInfo, {
		Position = targetPosition
	})
	
	if callback then
		tween.Completed:Connect(callback)
	end
	
	tween:Play()
	return tween
end

-- ========== SMOOTH SCALE ==========
function Tweens.SmoothScale(instance, targetSize, duration, easing, callback)
	local tweenService = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(
		duration or Theme.Animations.Normal,
		easing or Theme.Animations.EaseInOutQuad
	)
	
	local tween = tweenService:Create(instance, tweenInfo, {
		Size = targetSize
	})
	
	if callback then
		tween.Completed:Connect(callback)
	end
	
	tween:Play()
	return tween
end

-- ========== COLOR TRANSITION ==========
function Tweens.ColorTransition(instance, targetColor, duration, callback)
	local tweenService = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(duration or Theme.Animations.Normal)
	
	local tween = tweenService:Create(instance, tweenInfo, {
		BackgroundColor3 = targetColor
	})
	
	if callback then
		tween.Completed:Connect(callback)
	end
	
	tween:Play()
	return tween
end

-- ========== BOUNCE EFFECT ==========
function Tweens.BounceEffect(instance, intensity, callback)
	local tweenService = game:GetService("TweenService")
	local originalSize = instance.Size
	local tweenInfo1 = TweenInfo.new(
		Theme.Animations.Fast,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out
	)
	
	local tween1 = tweenService:Create(instance, tweenInfo1, {
		Size = originalSize * intensity
	})
	
	tween1.Completed:Connect(function()
		local tweenInfo2 = TweenInfo.new(Theme.Animations.Fast)
		local tween2 = tweenService:Create(instance, tweenInfo2, {
			Size = originalSize
		})
		
		if callback then
			tween2.Completed:Connect(callback)
		end
		
		tween2:Play()
	end)
	
	tween1:Play()
	return tween1
end

-- ========== GLOW EFFECT ==========
function Tweens.GlowEffect(instance, glowColor, duration, callback)
	local tweenService = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(
		duration or Theme.Animations.Slow,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.InOut
	)
	
	local stroke = instance:FindFirstChildOfClass("UIStroke")
	if stroke then
		local tween = tweenService:Create(stroke, tweenInfo, {
			Transparency = 0.3
		})
		
		if callback then
			tween.Completed:Connect(callback)
		end
		
		tween:Play()
		return tween
	end
end

return Tweens