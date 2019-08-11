class "StatisticComponent" {
	extends "DisplayComponent",
	
	-- Override
	new = function (self)
		DisplayComponent.instanceMethods.new(self)
		
		self.colorHSVA = {1,1,1,1}
		
		self.textScale = 0.03
		self.textOffsets = {0.005,0.01}
		
		self.fontSize = 0
		self.font = love.graphics.getFont()
		self:loadFontIfNecessary(love.graphics.getHeight())
	end,
	
	-- Implement
	update = function (self, dt)
	end,
	
	-- Implement
	draw = function (self, screenWidth,screenHeight)
		local previousFont = love.graphics.getFont()
		
		local text =
			"FPS: " .. love.timer.getFPS() .. "\n" ..
			"Time: " .. player:getTimeManager():getTime() .. "\n" ..
			"Tempo: " .. player:getSong():getTempoChanges()[player:getTimeManager().currentTempoChangeID]:getTempo()
		
		love.graphics.setColor(self.colorHSVA)
		love.graphics.setFont(self.font)
		
		love.graphics.print(text, screenWidth*self.textOffsets[1], screenHeight*self.textOffsets[2])
		
		love.graphics.setFont(previousFont)
		
		self:loadFontIfNecessary(screenHeight)
	end,
	
	setFont = function (self, font)
		self.font = font
	end,
	
	loadFontIfNecessary = function (self, screenHeight)
		local newFontSize = self.textScale * screenHeight
		if self.fontSize ~= newFontSize then
			self.fontSize = newFontSize
			self.font = love.graphics.newFont("Assets/MODERNE SANS.ttf", self.fontSize)
		end
	end,
}