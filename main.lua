-- callback
function love.load()

	-- our player
	hero = love.graphics.newImage("catgirl.png")
  player = {
  	x = 130,
  	y = 90
  }

	-- Set world for physics bodies to exist in 'https://love2d.org/wiki/Tutorial:Physics
	world = love.physics.newWorld(0, 0, 800, 600)
	world:setGravity(0, 100) -- not sure what x,y components of gravity do
	world:setMeter(30) -- default 30 pixels per meter
	
	-- table to hold all our physical objects
	objects = {}
	
	-- create the ground
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, 800/2, 575, 0, 0)
	objects.ground.shape = love.physics.newRectangleShape(objects.ground.body, 0, 0, 400, 50, 0)
	
	-- initial graphics setup
  love.graphics.setBackgroundColor(135,196,250)	
	
end


-- callback
function love.update(dt)

	world:update(dt) -- this puts the world into motion

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

	if key == "w" then
		player.y = player.y - hero:getHeight()
	elseif key == "s" then
		player.y = player.y + hero:getHeight()
	elseif key == "a" then
		player.x = player.x - hero:getWidth()
	elseif key == "d" then
		player.x = player.x + hero:getWidth()
	end
	

end

-- callback function
function love.draw()

	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", objects.ground.shape:getPoints())

 love.graphics.draw(hero, player.x, player.y)
end

