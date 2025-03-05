pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- let's write a program
-- that handles collision

--[x] create an obj and move it
--[x] collision detection func
--[] collision resolution
--[] sample stepping

--[]circ_col
function _init()
	debug=false
	
	p={
		x=60,
		y=60,
		s_id=1,
		spd=5
	}
	
	p.col=function(s)
		return {
			{s.x,s.y},
			{s.x+7,s.y+7}
		}
	end
	
	blocks={
		{
			{100,60},
			{107,67}
		},
		{
			{60,20},
			{67,27}
		},
		{
			{20,60},
			{27,67}
		}
	}
end
-->8
--update

function _update()
	if(btnp(🅾️))debug=not debug
	if(btn(➡️))move(p,➡️)
	if(btn(⬅️))move(p,⬅️)
	if(btn(⬇️))move(p,⬇️)
	if(btn(⬆️))move(p,⬆️)
	
	if(not(btn(⬅️) or btn(➡️)))then
		if(p.x>60)move(p,⬅️)
		if(p.x<60)move(p,➡️)
	end
	if(not(btn(⬆️) or btn(⬇️)))then
		if(p.y>60)move(p,⬆️)
		if(p.y<60)move(p,⬇️)
	end
end

function move(e,dir)
	local v={0,0}
	if(dir==➡️)v[1]=1
	if(dir==⬅️)v[1]=-1
	if(dir==⬇️)v[2]=1
	if(dir==⬆️)v[2]=-1
	
	move_step(e,v)
end

function move_step(e,v)
	for step=1, e.spd do
		
		if(step<=e.spd) then
			e.x+=v[1]
			e.y+=v[2]
			
			local c=e:col()
			if(col_with_tbl(c,blocks))then
				e.x-=v[1]
				e.y-=v[2]
			end
		end
	end
end
-->8
--draw

function _draw()
	cls()
	spr(3,60,60)
	draw_debug_notif()
	draw_p()
	draw_blocks()
end

function draw_p()
	palt(0,false)
	spr(p.s_id,p.x,p.y)
	palt()
	if(debug)then
		draw_p_col()
	end
end

function draw_p_col()
	local b_color=10
	local c
	
	c=col_with_tbl(p:col(),blocks)
	if(c)b_color=8
	
	draw_box(p:col(),b_color)
end

function draw_blocks()
	for b in all(blocks) do
		spr(2,b[1][1],b[1][2])
		if(debug)then
			local c=10
			if(aa_bb(b,p:col()))c=8
			draw_box(b,c)
		end
	end
end

function draw_debug_notif()
	local str="debug: "
	str=str..tostr(debug)
	print(str,40,100,7)
	print("toggle: z",44,108,7)
end


-->8
-- a box is a tuple consisting
-- of a start point and an end
-- point.

-- a point is a tuple consisting
-- of an x and a y value.

--box 1, box 2
function aa_bb(b1,b2)
	return b1[1][1] <= b2[2][1] 
			 and b1[2][1] >= b2[1][1] 
			 and	b1[1][2] <= b2[2][2] 
			 and	b1[2][2] >= b2[1][2]
end

--box, color
function draw_box(box,c)
	rect(
		box[1][1],
		box[1][2],
		box[2][1],
		box[2][2],
		c
	)
end

function col_with_tbl(col,t)
	for i in all(t) do
	 if (aa_bb(col,i)) return true
	end
	return false
end

__gfx__
0000000000777700dddddddd50000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000007000070dd0000dd05000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070007000070d0d00d0d00500500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700007000070d00dd00d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000777700d00dd00d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000077000d0d00d0d00500500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000077000dd0000dd05000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000700700dddddddd50000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
