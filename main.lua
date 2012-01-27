-- callback
function love.load()
  supported = love.graphics.checkMode (320, 480, false)
  r, g, b = love.graphics.getBackgroundColor()
  print (r .. g .. b)
  modes = love.graphics.getModes()
  love.graphics.setBackgroundColor(135,196,250)
  love.graphics.setColor(0,0,0)
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

end

-- callback function
function love.draw()

  love.graphics.print("Hello World", 240, 150)
  love.graphics.circle("line", 240, 150, 25, 6) -- cant draw circle from load

  --[[
  local x = love.mouse.getX()
  love.graphics.line(x,0,x,love.graphics.getHeight())
  ]]--

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