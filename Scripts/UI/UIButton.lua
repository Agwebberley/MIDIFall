class "UIButton" {
	extends "UIObject",
	
	new = function (self, x,y,width,height, text,icon, clicked)
		-- self:super(x,y, width,height)
		UIObject.instanceMethods.new(self, x,y, width,height) -- self.super not working for two level inhertance
		
		self.icon = icon
		self.iconSpace = 0.05
		self.padding = 0.15
		
		self.clicked = clicked
		
		if self.icon then
			self.text = UIText(x+0.26,y, width-0.26,height, text,0.8,false,true)
		else
			self.text = UIText(x,y, width,height, text,0.8,true,true)
		end
	end,
	
	update = function (self, dt, transform)
		self.transform = transform
		
		self.text:update(dt, transform)
	end,
	
	draw = function (self)
		local font = love.graphics.getFont()
	
		-- Draw the box
		local boxX, boxY = self.transform:transformPoint(self.x, self.y)
		local boxX2, boxY2 = self.transform:transformPoint(self.x+self.width, self.y+self.height)
		local boxWidth = boxX2 - boxX
		local boxHeight = boxY2 - boxY
		
		if self.isInside then
			love.graphics.setColor(1,1,1,0.8)
			-- love.graphics.rectangle("fill", boxX,boxY, boxWidth,boxHeight, boxHeight/8,boxHeight/8)
			
			love.graphics.setColor(0,0.5,1,1)
			love.graphics.setLineWidth((boxWidth+boxHeight) / 128)
			love.graphics.rectangle("line", boxX,boxY, boxWidth,boxHeight, boxHeight/8,boxHeight/8)
		else
			love.graphics.setColor(0,0.5,1,0.8)
			love.graphics.rectangle("fill", boxX,boxY, boxWidth,boxHeight, boxHeight/8,boxHeight/8)
		end
		
		-- Draw icon and text
		if self.isInside then
			love.graphics.setColor(0,0.5,1,1)
		else
			love.graphics.setColor(1,1,1,0.8)
		end
		
		if self.icon then
			local iconScale = (boxHeight / self.icon:getHeight()) * 0.8
			local iconX, iconY = self.transform:transformPoint(self.x+self.padding,self.y)
			iconY = iconY + (boxHeight - iconScale*self.icon:getHeight()) / 2
			
			love.graphics.draw(self.icon, iconX,iconY, 0, iconScale)
		end
		
		self.text:draw()
	end,
	
	mousePressed = function (self, mouseX, mouseY, button, istouch, presses)
		if self.isInside and self.clicked and button == 1 then
			self:clicked()
		end
	end,
	
	mouseMoved = function (self, x, y, dx, dy, istouch )
		if self:findIsInside(x,y) then
			self:mouseEntered()
		else
			self:mouseExited()
		end
	end,
}