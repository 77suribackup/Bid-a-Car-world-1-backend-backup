-- ========================================
-- THEME.LUA - Design System & Constants
-- ========================================

local Theme = {}

-- ========== COLORS ==========
Theme.Colors = {
	-- Background
	Background = Color3.fromHex("0a0e27"), -- Deep dark navy
	BackgroundSecondary = Color3.fromHex("1a1f3a"), -- Slightly lighter
	BackgroundTertiary = Color3.fromHex("2d3561"), -- Card backgrounds
	
	-- Primary (Cyan Neon)
	Primary = Color3.fromHex("00d4ff"), -- Bright cyan
	PrimaryDark = Color3.fromHex("00a8cc"), -- Darker cyan
	PrimaryLight = Color3.fromHex("33e0ff"), -- Lighter cyan
	
	-- Secondary (Purple)
	Secondary = Color3.fromHex("9d4edd"), -- Purple neon
	SecondaryDark = Color3.fromHex("7b2cbf"), -- Darker purple
	SecondaryLight = Color3.fromHex("c77dff"), -- Lighter purple
	
	-- Accent (Hot Pink)
	Accent = Color3.fromHex("ff006e"), -- Hot pink
	AccentDark = Color3.fromHex("d00052"), -- Darker pink
	AccentLight = Color3.fromHex("ff4d94"), -- Lighter pink
	
	-- Text
	TextPrimary = Color3.fromHex("ffffff"), -- White
	TextSecondary = Color3.fromHex("b0b8d4"), -- Light gray
	TextTertiary = Color3.fromHex("6b7494"), -- Medium gray
	TextDisabled = Color3.fromHex("4a5568"), -- Disabled gray
	
	-- Status
	Success = Color3.fromHex("10b981"), -- Green
	Warning = Color3.fromHex("f59e0b"), -- Orange
	Error = Color3.fromHex("ef4444"), -- Red
	Info = Color3.fromHex("3b82f6"), -- Blue
	
	-- Rarity Colors
	Common = Color3.fromHex("8b8b8b"), -- Gray
	Uncommon = Color3.fromHex("2ecc71"), -- Green
	Rare = Color3.fromHex("3498db"), -- Blue
	Epic = Color3.fromHex("9b59b6"), -- Purple
	Legendary = Color3.fromHex("f39c12"), -- Gold
	SPEC = Color3.fromHex("ff006e"), -- Pink (hottest)
}

-- ========== FONTS ==========
Theme.Fonts = {
	Title = Font.new(Enum.Font.GothamBold, Enum.FontSize.Size32),
	Heading = Font.new(Enum.Font.GothamBold, Enum.FontSize.Size24),
	Subheading = Font.new(Enum.Font.GothamBold, Enum.FontSize.Size18),
	Body = Font.new(Enum.Font.Gotham, Enum.FontSize.Size16),
	BodySmall = Font.new(Enum.Font.Gotham, Enum.FontSize.Size14),
	Caption = Font.new(Enum.Font.Gotham, Enum.FontSize.Size12),
	Button = Font.new(Enum.Font.GothamBold, Enum.FontSize.Size16),
	ButtonSmall = Font.new(Enum.Font.GothamBold, Enum.FontSize.Size14),
}

-- ========== SIZES ==========
Theme.Sizes = {
	-- Spacing
	XS = 4,
	SM = 8,
	MD = 12,
	LG = 16,
	XL = 24,
	XXL = 32,
	
	-- Corner Radius
	RadiusSmall = UDim.new(0, 8),
	RadiusMedium = UDim.new(0, 12),
	RadiusLarge = UDim.new(0, 16),
	RadiusXL = UDim.new(0, 24),
	
	-- Button Sizes
	ButtonSmall = UDim2.new(0, 80, 0, 32),
	ButtonMedium = UDim2.new(0, 120, 0, 40),
	ButtonLarge = UDim2.new(0, 200, 0, 50),
	ButtonFullWidth = UDim2.new(1, -32, 0, 50),
	
	-- Icon Sizes
	IconSmall = 16,
	IconMedium = 24,
	IconLarge = 32,
	IconXL = 48,
}

-- ========== TRANSPARENCY & EFFECTS ==========
Theme.Effects = {
	-- Transparency levels
	Opaque = 0,
	SemiOpaque = 0.15,
	Translucent = 0.3,
	SemiTransparent = 0.5,
	Transparent = 0.7,
	
	-- Glassmorphism
	GlassBg = 0.85, -- Glass background transparency
	GlassBorder = 0.15, -- Border transparency
	
	-- Hover/Active states
	HoverOpacity = 0.85,
	ActiveOpacity = 0.7,
	DisabledOpacity = 0.5,
}

-- ========== ANIMATIONS ==========
Theme.Animations = {
	-- Tween durations (seconds)
	Instant = 0,
	VeryFast = 0.1,
	Fast = 0.2,
	Normal = 0.3,
	Slow = 0.5,
	VerySlow = 0.8,
	
	-- Easing styles
	EaseInOutQuad = Enum.EasingStyle.Quad,
	EaseInOutCubic = Enum.EasingStyle.Cubic,
	EaseOutElastic = Enum.EasingStyle.Elastic,
	EaseOutBounce = Enum.EasingStyle.Bounce,
	EaseInOutBack = Enum.EasingStyle.Back,
	
	-- Direction
	EaseInOut = Enum.EasingDirection.InOut,
	EaseIn = Enum.EasingDirection.In,
	EaseOut = Enum.EasingDirection.Out,
}

-- ========== GRADIENTS ==========
Theme.Gradients = {
	CyanToPurple = {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Theme.Colors.Primary),
			ColorSequenceKeypoint.new(1, Theme.Colors.Secondary),
		}),
		Rotation = 45,
	},
	
	PurpleToAccent = {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Theme.Colors.Secondary),
			ColorSequenceKeypoint.new(1, Theme.Colors.Accent),
		}),
		Rotation = 45,
	},
	
	DarkToCyan = {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Theme.Colors.BackgroundTertiary),
			ColorSequenceKeypoint.new(1, Theme.Colors.Primary),
		}),
		Rotation = 45,
	},
}

-- ========== SHADOWS ==========
Theme.Shadows = {
	None = {
		Color = Color3.new(0, 0, 0),
		Transparency = 1,
	},
	
	Subtle = {
		Color = Color3.new(0, 0, 0),
		Transparency = 0.8,
	},
	
	Medium = {
		Color = Color3.new(0, 0, 0),
		Transparency = 0.7,
	},
	
	Strong = {
		Color = Color3.new(0, 0, 0),
		Transparency = 0.5,
	},
	
	CyanGlow = {
		Color = Theme.Colors.Primary,
		Transparency = 0.6,
	},
	
	PurpleGlow = {
		Color = Theme.Colors.Secondary,
		Transparency = 0.6,
	},
}

-- ========== PADDING STYLES ==========
Theme.Padding = {
	None = UDim.new(0, 0),
	Small = UDim.new(0, 8),
	Medium = UDim.new(0, 12),
	Large = UDim.new(0, 16),
	XLarge = UDim.new(0, 24),
}

-- ========== STROKE STYLES ==========
Theme.Strokes = {
	None = {
		Thickness = 0,
		Transparency = 1,
	},
	
	Thin = {
		Thickness = 1,
		Transparency = 0,
	},
	
	Medium = {
		Thickness = 2,
		Transparency = 0,
	},
	
	Thick = {
		Thickness = 3,
		Transparency = 0,
	},
}

-- ========== PRESET STYLES ==========
Theme.Styles = {
	-- Button styles
	ButtonPrimary = {
		BackgroundColor3 = Theme.Colors.Primary,
		TextColor3 = Theme.Colors.Background,
		BorderColor3 = Theme.Colors.Primary,
		Transparency = Theme.Effects.Opaque,
	},
	
	ButtonSecondary = {
		BackgroundColor3 = Theme.Colors.Secondary,
		TextColor3 = Theme.Colors.TextPrimary,
		BorderColor3 = Theme.Colors.Secondary,
		Transparency = Theme.Effects.Opaque,
	},
	
	ButtonOutline = {
		BackgroundColor3 = Theme.Colors.Background,
		TextColor3 = Theme.Colors.Primary,
		BorderColor3 = Theme.Colors.Primary,
		Transparency = Theme.Effects.Translucent,
	},
	
	ButtonGhost = {
		BackgroundColor3 = Theme.Colors.Background,
		TextColor3 = Theme.Colors.TextSecondary,
		BorderColor3 = Color3.new(1, 1, 1),
		Transparency = Theme.Effects.Transparent,
	},
	
	-- Card styles
	CardDark = {
		BackgroundColor3 = Theme.Colors.BackgroundTertiary,
		Transparency = Theme.Effects.SemiOpaque,
	},
	
	CardGlass = {
		BackgroundColor3 = Theme.Colors.Background,
		Transparency = Theme.Effects.GlassBg,
	},
}

return Theme