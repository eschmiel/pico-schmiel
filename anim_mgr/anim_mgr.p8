pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
	local opt={
		st='idle',
		anims={
			idle={
				{1,10},
				{2,5}
			},
			walk={
				{3,3},
				{4,1},
				{5,1}, 
				{6,1},
				{7,3}
			}
		},
	}

	mgr=mk_anim_mgr(opt)
	menu=mk_menu()
end

function _update()
	mgr:update()
	menu:update()
end

function _draw()
	cls()
	spr(mgr:cur_spr(),60,40)
	draw_anim_st_str()
	menu:draw(40,80)
end

function draw_anim_st_str()
	local str="animation state: "
	str=str..mgr.st
	print(str,20,70,6)
end
-->8
function mk_anim_mgr(opt)
	local mgr={
		st=opt.st,
		anims=opt.anims,
		cf=1,
		t=0,
	}
	
	mgr.cur_anim=function(s)
	 return	s.anims[s.st]
	end
	
	mgr.cur_spr=function(s)
		return s:cur_anim()[s.cf][1]
	end
	
	mgr.update=function(s)
		s.t+=1
		local anim=s:cur_anim()
		if(s.t>anim[s.cf][2])then
			s.t=0
			s.cf+=1
		end
		if(s.cf>#anim)s.cf=1
	end
	
	return mgr
end
-->8
function mk_menu()
	local menu={
	 opt={'idle','walk'},
	 sel=1
	}
	
	menu.update=function(s)
		if(btnp(⬇️))then
			s.sel+=1
			if(s.sel>#s.opt)s.sel=1
		end
		if(btnp(⬆️))then
			s.sel-=1
			if(s.sel<1)s.sel=#s.opt
		end
		if(btnp(🅾️))then
			mgr.st=s.opt[s.sel]
			mgr.cf=1
			mgr.t=1
		end
	end
	
	menu.draw=function(s,x,y)
		rect(x,y,x+50,y+34,13)
		for i,o in ipairs(s.opt) do
			local c=5
			if(i==s.sel)c=7
			print(o,x+10,y+(10*i),c)
		end
	end
	
	return menu
end
__gfx__
00000000007777000000000000777700007777000077770000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070000700077770007000070070000700700007000777700000000000000000000000000000000000000000000000000000000000000000000000000
00700700070000700700007007000070070000700700007007000070000000000000000000000000000000000000000000000000000000000000000000000000
00077000070000700700007007000070077777700700007007000070007777000000000000000000000000000000000000000000000000000000000000000000
00077000007777000700007000777700000770000700007007000070070000700000000000000000000000000000000000000000000000000000000000000000
00700700000770000077770000077000000777000077770000777700070000700000000000000000000000000000000000000000000000000000000000000000
00000000000770000007700000077700000700000007070000077000007777000000000000000000000000000000000000000000000000000000000000000000
00000000007007000070070000700000000000000000000000007000000070000000000000000000000000000000000000000000000000000000000000000000
