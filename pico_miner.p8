pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- pico miner
-- by divoolej

-- colors
local black  = 0
local navy   = 1
local purple = 2
local slate  = 3
local brown  = 4
local gray   = 5
local silver = 6
local white  = 7
local red    = 8
local orange = 9
local yellow = 10
local green  = 11
local blue   = 12
local indigo = 13
local pink   = 14
local beige  = 15

-- core functions
function _init()
 menu:init()
end

function _update()
	if game.state == "menu" then
	 menu:update()
	elseif game.state == "game" then
		game:update()
	end
end

function _draw()
	if game.state == "menu" then
	 menu:draw()
	elseif game.state == "game" then
  game:draw()
 end
end
-->8
-- main menu

local options = {
 {
 	is_selected = true,
  text = "new run",
  callback = function()
   game:init()
  end,
 },
 {
  is_selected = false,
  text = "exit",
  callback = function()
   cls()
   stop()
  end,
 },
}

function init_menu(self)
 game.state = "menu"
end

function draw_menu(self)
 cls()
 -- draw background
 map(16, 0, 0, 0, 16, 16)
 -- draw logo
 rectfill(38, 22, 80, 30, black)
 print("pico miner", 40, 24, blue)
 -- draw options
 rectfill(38, 48, 80, 50 + #options * 8, black)
 local index, option
 for index, option in pairs(self.options) do
  if option.is_selected then
   print("➡️ "..option.text, 40, 43 + index * 8, green)
  else
   print(option.text, 52, 43 + index * 8, blue)
  end
 end
end

function update_menu(self)
 if btnp(4) then
  local option
  for option in all(self.options) do
   if option.is_selected then
    option.callback()
   end
  end
 end
 if btnp(3) then
  local index, option
  for index, option in pairs(self.options) do
   if option.is_selected then
    option.is_selected = false
    if self.options[index + 1] then
     self.options[index + 1].is_selected = true
    else
     self.options[1].is_selected = true
    end
    break
   end
  end
 elseif btnp(2) then
  local index, option
  for index, option in pairs(self.options) do
   if option.is_selected then
    option.is_selected = false
    if self.options[index - 1] then
     self.options[index - 1].is_selected = true
    else
     self.options[#self.options].is_selected = true
    end
    break
   end
  end
 end
end

menu = {
 options = options,
 init = init_menu,
 draw = draw_menu,
 update = update_menu,
}
-->8
-- game

function init_game(self)
 self.state = "game"
end

function update_game(self)
 player:update()
end

function draw_game(self)
 cls()
 -- draw background
 map(0, 0, 0, 0, 16, 9)
 -- draw player
 player:draw()
end

game = {
 init = init_game,
 update = update_game,
 draw = draw_game,
}
-->8
-- player

function update_player(self)
 if btn(0) then 
  self.x -= 1
  self.is_facing_left = true
 end
 if btn(1) then 
  self.x += 1
  self.is_facing_left = false
 end
end

function draw_player(self)
 spr(1, self.x, self.y, 1, 1, self.is_facing_left)
end

player = {
 x = 64,
 y = 56,
 is_facing_left = true,
 update = update_player,
 draw = draw_player,
}
__gfx__
000000000033000000330000003300000330010033333333cccccccc444444444444444f4444444444444444445444594404440144544456445444574494449a
0000000003aa000003aa066003aa00003aa0000144444444cccccccc44444444444444444444444444444444455945954001400046264562476745764afa49af
0000000000aa0660a0aa004600aa06600aa0000054444444cccccccc444444444d44444446444444444444444595445440104404456544244575446449a944f4
000000000d55d0460d55da060d55d046055d001044444d44cccccccc444744444444444444444444444444444455444444004444445444444454444444944444
00000000a0550a0600554000a0550a060550a00044444444cccccccc4444444444444444444444d444444444444459444444014444442644444467444444fa44
000000000055400000550000005540000550040644444444ccecc3cc4444444444444464444444444444444445459544404010444542654445467544494fa944
000000000a00a0000a00a00000a0a000a00a00464d444444cc3ccc3c4444441445444444444d44444444444495495444014004446246544476475444af4a9444
000000000200200002002000020020002002066044444444c3ccc3cc44444444444444444444444444444444495444444004444446244444476444444af44444
44d444dc0000000000000000cccccccccccccccc4454444444544544540550540000000000000000000000000000000000000000000000000000000000000000
4c7c4dc60200004000005000c7cccccccccccccc451515d4401505d0505555550000000000000000000000000000000000000000000000000000000000000000
4dcd44640000050004000000cccc7ccccccccccc44551d5605001d06055055550445544000000000000000000000000000000000000000000000000000000000
44d444440050000000500040cc7777cccccccccc4551555540510555550550550f4554f000000000000000000000000000000000000000000000000000000000
44447c440000100000000000c7777ccccccccccc55d0545555d050050555555004ff4ff000000000000000000000000000000000000000000000000000000000
4d47cd440000000000005000cc7ccc7ccccccccc5115555450150550550550550ff4ff4000000000000000000000000000000000000000000000000000000000
c74cd4440d04004004000000ccccc777cccccccc4651555446015004555555500f4ff4f000000000000000000000000000000000000000000000000000000000
4c7444440000000000000000cccccccccccccccc4444454444055444450550451111111100000000000000000000000000000000000000000000000000000000
__gff__
0000000000010103030300030303030303030303030303030000000000000000000000000303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
141414141414141414141414141413140b0b0b0b0b0d0d0b0b0b0b0b0b0b0b0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
141314141413141413141414141314140b0c0d0c0c0d0d0d0e0e0d0d0f0d0f0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
141414141414131414141414141414140b0b0c0c0f0f0f0c0d0f0f0c0f0d0d0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
141414141414141414141314141414140b0c0b0d0d0b0b0b0b0b0d0c0f0d0e0e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
141414141413141414141414141314140b0d0d0d0b0b0c0f0c0e0d0d0f0f0e0e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
141413141414141414141414141414140b0d0d0b0b0d0f0f0e0e0e0d0d0f0c0e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
141414141414141414141414141414140b0c0b0b0e0b0e0b0b0e0e0f0e0f0f0e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060606060606060606060606060606060b0c0d0b0e0e0b0f0e0e0e0f0e0b0f0f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050505050505050505050505050505050b0e0b0f0d0b0c0e0f0e0e0e0b0d0c0e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000b0e0b0f0d0d0f0e0e0e0e0e0f0d0d0e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000b0e0b0e0f0c0e0e0e0e0e0b0e0b0e0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000b0e0e0f0c0f0d0e0d0e0e0e0e0b0e0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000b0c0e0e0d0c0c0b0e0e0e0b0b0f0e0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000b0c0b0e0e0d0d0b0f0d0d0b0f0e0e0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000b0c0e0c0d0e0e0e0f0f0d0f0d0d0e0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000b0b0b0e0e0e0b0b0d0e0e0e0e0e0e0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000d6500f6500d650000000d6500f650126502465012650146500d6500d6500f65012650016502925001650016500265003650046500465005650056500565005650056502465005650162501425025050
