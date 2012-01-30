-- callback
function love.load()
 
  love.graphics.setBackgroundColor(135,196,250)
	love.graphics.setMode(960,960,0)
	-- our tiles
	tile = {}
	for i=0,4 do 
		tile[i] = love.graphics.newImage( "tile"..i..".png" )
	end

	love.graphics.setFont(12)
	
	-- map variables
	map_w = 30
	map_h = 30
	map_x = 0
	map_y = 0
	map_offset_x = 30
	map_offset_y = 30
	map_display_w = 7
	map_display_h = 7
	tile_w = 101
	tile_h = 79
	
	map = {
		{ 1, 1, 1, 2, 1, 1, 1 },
		{ 1, 4, 4, 2, 4, 4, 1 },
		{ 1, 4, 3, 2, 3, 4, 1 },
		{ 2, 2, 2, 0, 2, 2, 2 },
		{ 1, 4, 3, 2, 3, 4, 1 },
		{ 1, 4, 4, 2, 4, 4, 1 },
		{ 1, 1, 1, 2, 1, 1, 1 },
	}

	-- our player
	hero = love.graphics.newImage("catgirl.png")
  player = {
  	x = 130,
  	y = 90
  }

end

function draw_map()
	for y=1, map_display_h do
		for x=1, map_display_w do
			love.graphics.draw(
				tile[map[y+map_y][x+map_x]],
				(x*tile_w)+map_offset_x,
				(y*tile_h)+map_offset_y )
		end
	end
end

-- callback
function love.update()
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
		player.y = player.y - tile_h
	elseif key == "s" then
		player.y = player.y + tile_h
	elseif key == "a" then
		player.x = player.x - hero:getWidth()
	elseif key == "d" then
		player.x = player.x + hero:getWidth()
	end
	

end

-- callback function
function love.draw()

 draw_map()
 love.graphics.draw(hero, player.x, player.y)
end

-- default function - https://love2d.org/wiki/love.run
function love.run()

  if love.load then love.load(arg) end

  local dt = 0

  -- Main loop time.
  while true do
    if love.timer then
      love.timer.step()
      dt = love.timer.getDelta()
    end
    if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
    if love.graphics then
      love.graphics.clear()
      if love.draw then love.draw() end
    end

    -- Process events.
    if love.event then
      for e,a,b,c in love.event.poll() do
        if e == "q" then
          if not love.quit or not love.quit() then
            if love.audio then
              love.audio.stop()
            end
            return
          end
        end
        love.handlers[e](a,b,c)
      end
    end

    if love.timer then love.timer.sleep(1) end
    if love.graphics then love.graphics.present() end

  end

end