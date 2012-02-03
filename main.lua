-- alt bands: silversun pickups, kasabian "underdog", young the giant "my body"

-- callback
function love.load()

	-- our player
	hero = love.graphics.newImage("gengar.png")

	-- Set world for physics bodies to exist in 'https://love2d.org/wiki/Tutorial:Physics
	world = love.physics.newWorld(0, 0, 800, 600)
	world:setGravity(0, 400) -- not sure what x,y components of gravity do
	world:setMeter(30) -- default 30 pixels per meter
	
	-- table to hold all our physical objects
	objects = {}
	
	-- create the ground
	objects.ground = {}	
	-- in box 2d, the body is anchored at the center of its mass, which the x position of the body helps decide
	objects.ground.body = love.physics.newBody(world, 800/2, 575, 0, 0) -- world, x, y, m, i
	-- x,y here represent the starting area to draw for a 800x50 rectangle (offsets I guess)
	objects.ground.shape = love.physics.newRectangleShape(objects.ground.body, 0, 0, 800, 50, 0) -- body, x, y, width, height, angle
	
	-- create the player
	objects.player = {}
	objects.player.body = love.physics.newBody(world, 800/2, 100, 10, 0)
	objects.player.shape = love.physics.newRectangleShape(objects.player.body, 0, 0, 71, 53, 0)
	
	-- initial graphics setup
  love.graphics.setBackgroundColor(135,196,250)	
	
end

-- callback
function love.update(dt)

	world:update(dt) -- this puts the world into motion

	-- clamping, x curr val, l is min, u is max, if x > u, math.min returns u
	local p = objects.player.body
	local speed = 10
	
	if love.keyboard.isDown("w") then
		p:setY(p:getY() - speed) --hero:getHeight())
	elseif love.keyboard.isDown("s") then
		p:setY(p:getY() + speed)
	elseif love.keyboard.isDown("a") then
		p:setX(p:getX() - speed)
	elseif love.keyboard.isDown("d") then
		p:setX(p:getX() + speed)
	end
	
	p:setX( math.min( math.max( p:getX(), hero:getWidth()/2 ), 800 - hero:getWidth()/2 ) )
	-- far left, min(max(0,71), 721) = 71; far right, min(max(721 +10,71), 721) = 721 
	
	p:setY( math.min( math.max( p:getY(), hero:getHeight()/2 ), 550 - hero:getHeight()/2 ) )
	-- top, min(max(53, 0), 547) = 0; bottom, min(max(573.5, 25.x), 573)
	-- min(max(
end

function love.keypressed(key)

  if key == 'escape' then
	love.event.push('q') -- quit the game
  end

  -- Tab toggles whether or not mouse is allowed to leave window
  if key == 'tab' then
    local state = not love.mouse.isGrabbed() -- the opposite of whatever it currently is
    love.mouse.setGrab(state)
  end

end

-- callback function
function love.draw()
	
	-- draw ground
	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", objects.ground.shape:getPoints())
	
	-- draw player
	love.graphics.setColor(100,100,100)
	local p = objects.player.body
	love.graphics.draw(hero, p:getX(), p:getY(), p:getAngle(), 1, 1, hero:getWidth()/2, hero:getHeight()/2) -- origin at center of image

	-- print out debug info
	love.graphics.print("hero-width:" .. hero:getWidth() .. ", hero-height:" .. hero:getHeight(), 10, 10)
	love.graphics.print("x:" .. p:getX() .. ", y:" .. p:getY(), 10, 40)
	love.graphics.print("angle:" .. p:getAngle(), 10,70)
end

