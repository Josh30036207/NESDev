;
; File generated by cc65 v 2.19 - Git bb1b5c3
;
	.fopt		compiler,"cc65 v 2.19 - Git bb1b5c3"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	on
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.dbg		file, "game.c", 6106, 1707354281
	.dbg		file, "LIB/neslib.h", 9196, 1701627949
	.dbg		file, "LIB/nesdoug.h", 6756, 1701627949
	.dbg		file, "sprites.h", 819, 1707063665
	.dbg		file, "game.h", 1773, 1707354144
	.dbg		file, "BG/maps.c", 5565, 1707353678
	.forceimport	__STARTUP__
	.dbg		sym, "pal_bg", "00", extern, "_pal_bg"
	.dbg		sym, "pal_spr", "00", extern, "_pal_spr"
	.dbg		sym, "ppu_wait_nmi", "00", extern, "_ppu_wait_nmi"
	.dbg		sym, "ppu_off", "00", extern, "_ppu_off"
	.dbg		sym, "ppu_on_all", "00", extern, "_ppu_on_all"
	.dbg		sym, "oam_clear", "00", extern, "_oam_clear"
	.dbg		sym, "oam_spr", "00", extern, "_oam_spr"
	.dbg		sym, "oam_meta_spr", "00", extern, "_oam_meta_spr"
	.dbg		sym, "pad_poll", "00", extern, "_pad_poll"
	.dbg		sym, "bank_spr", "00", extern, "_bank_spr"
	.dbg		sym, "vram_adr", "00", extern, "_vram_adr"
	.dbg		sym, "vram_put", "00", extern, "_vram_put"
	.dbg		sym, "memcpy", "00", extern, "_memcpy"
	.dbg		sym, "get_pad_new", "00", extern, "_get_pad_new"
	.dbg		sym, "check_collision", "00", extern, "_check_collision"
	.dbg		sym, "set_scroll_y", "00", extern, "_set_scroll_y"
	.import		_pal_bg
	.import		_pal_spr
	.import		_ppu_wait_nmi
	.import		_ppu_off
	.import		_ppu_on_all
	.import		_oam_clear
	.import		_oam_spr
	.import		_oam_meta_spr
	.import		_pad_poll
	.import		_bank_spr
	.import		_vram_adr
	.import		_vram_put
	.import		_memcpy
	.import		_get_pad_new
	.import		_check_collision
	.import		_set_scroll_y
	.export		_metasprite
	.export		_metasprite2
	.export		_metasprite3
	.export		_paletteBg
	.export		_paletteSp
	.export		_map0
	.export		_map1
	.export		_map2
	.export		_map3
	.export		_map4
	.export		_worldMap
	.export		_mapWidth
	.export		_pad1
	.export		_pad1_new
	.export		_collision
	.export		_text
	.export		_collision_L
	.export		_collision_R
	.export		_collision_U
	.export		_collision_D
	.export		_which_bg
	.export		_p_maps
	.export		_coordinates
	.export		_temp1
	.export		_temp2
	.export		_temp3
	.export		_temp4
	.export		_temp_x
	.export		_temp_y
	.export		_i
	.export		_health
	.export		_maxHealth
	.export		_knight
	.export		_Enemy
	.export		_numberOfE
	.export		_E
	.export		_tempE
	.export		_mapPos
	.export		_c_map
	.export		_All_Collision_Maps
	.export		_drawSprites
	.export		_move
	.export		_testCollision
	.export		_draw_bg
	.export		_bgCollision
	.export		_check_start
	.export		_loadEnemyData
	.export		_updateHealth
	.export		_loseCheck
	.export		_testButton
	.export		_nextRoom
	.export		_main

.segment	"DATA"

_mapWidth:
	.word	$0003
_health:
	.word	$0008
_maxHealth:
	.word	$0008
_knight:
	.byte	$28
	.byte	$3E
	.byte	$0F
	.byte	$0F
_Enemy:
	.byte	$40
	.byte	$93
	.byte	$0F
	.byte	$0F
_numberOfE:
	.word	$0003
_mapPos:
	.word	$0004

.segment	"RODATA"

_metasprite:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$08
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$08
	.byte	$10
	.byte	$00
	.byte	$08
	.byte	$08
	.byte	$11
	.byte	$00
	.byte	$80
_metasprite2:
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$40
	.byte	$00
	.byte	$08
	.byte	$11
	.byte	$40
	.byte	$08
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$08
	.byte	$08
	.byte	$11
	.byte	$00
	.byte	$80
_metasprite3:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$08
	.byte	$10
	.byte	$00
	.byte	$08
	.byte	$00
	.byte	$00
	.byte	$40
	.byte	$08
	.byte	$08
	.byte	$10
	.byte	$40
	.byte	$80
_paletteBg:
	.byte	$0F
	.byte	$00
	.byte	$0C
	.byte	$15
	.byte	$30
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
_paletteSp:
	.byte	$25
	.byte	$00
	.byte	$0C
	.byte	$07
	.byte	$30
	.byte	$16
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
_map0:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
_map1:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
_map2:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
_map3:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
_map4:
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
_worldMap:
	.byte	$00
	.byte	$01
	.byte	$00
	.byte	$03
	.byte	$00
	.byte	$04
	.byte	$00
	.byte	$02
	.byte	$00
_text:
	.byte	$59,$6F,$75,$20,$74,$72,$75,$6C,$79,$20,$61,$72,$65,$20,$74,$68
	.byte	$65,$20,$64,$61,$72,$6B,$20,$73,$6F,$75,$6C,$00
_All_Collision_Maps:
	.addr	_map0
	.addr	_map1
	.addr	_map2
	.addr	_map3
	.addr	_map4

.segment	"BSS"

_pad1:
	.res	1,$00
_pad1_new:
	.res	1,$00
_collision:
	.res	1,$00
_collision_L:
	.res	1,$00
_collision_R:
	.res	1,$00
_collision_U:
	.res	1,$00
_collision_D:
	.res	1,$00
_which_bg:
	.res	1,$00
_p_maps:
	.res	2,$00
_coordinates:
	.res	1,$00
_temp1:
	.res	1,$00
_temp2:
	.res	1,$00
_temp3:
	.res	1,$00
_temp4:
	.res	1,$00
_temp_x:
	.res	1,$00
_temp_y:
	.res	1,$00
_i:
	.res	2,$00
_E:
	.res	12,$00
_tempE:
	.res	12,$00
_c_map:
	.res	240,$00

; ---------------------------------------------------------------
; void __near__ drawSprites (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_drawSprites: near

	.dbg	func, "drawSprites", "00", extern, "_drawSprites"

.segment	"CODE"

;
; ppu_wait_nmi(); // wait till beginning of the frame
;
	.dbg	line, "game.c", 80
	jsr     _ppu_wait_nmi
;
; oam_clear();
;
	.dbg	line, "game.c", 82
	jsr     _oam_clear
;
; bank_spr(1);//switch to player spritesheet
;
	.dbg	line, "game.c", 83
	lda     #$01
	jsr     _bank_spr
;
; oam_meta_spr(knight.x, knight.y, metasprite);
;
	.dbg	line, "game.c", 86
	jsr     decsp2
	lda     _knight
	ldy     #$01
	sta     (sp),y
	lda     _knight+1
	dey
	sta     (sp),y
	lda     #<(_metasprite)
	ldx     #>(_metasprite)
	jsr     _oam_meta_spr
;
; for(i = 0; i < numberOfE; i++){
;
	.dbg	line, "game.c", 90
	lda     #$00
	sta     _i
	sta     _i+1
L0002:	lda     _i
	cmp     _numberOfE
	lda     _i+1
	sbc     _numberOfE+1
	bvc     L0007
	eor     #$80
L0007:	bpl     L0003
;
; oam_meta_spr(E[i].x, E[i].y , metasprite2);
;
	.dbg	line, "game.c", 91
	jsr     decsp2
	lda     _i
	ldx     _i+1
	jsr     aslax2
	sta     ptr1
	txa
	clc
	adc     #>(_E)
	sta     ptr1+1
	ldy     #<(_E)
	lda     (ptr1),y
	ldy     #$01
	sta     (sp),y
	lda     _i
	ldx     _i+1
	jsr     aslax2
	clc
	adc     #<(_E)
	sta     ptr1
	txa
	adc     #>(_E)
	sta     ptr1+1
	lda     (ptr1),y
	dey
	sta     (sp),y
	lda     #<(_metasprite2)
	ldx     #>(_metasprite2)
	jsr     _oam_meta_spr
;
; for(i = 0; i < numberOfE; i++){
;
	.dbg	line, "game.c", 90
	inc     _i
	bne     L0002
	inc     _i+1
	jmp     L0002
;
; }
;
	.dbg	line, "game.c", 94
L0003:	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ move (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_move: near

	.dbg	func, "move", "00", extern, "_move"

.segment	"CODE"

;
; if(pad1 & PAD_LEFT){
;
	.dbg	line, "game.c", 57
	lda     _pad1
	and     #$02
	beq     L000E
;
; knight.x -= 1;
;
	.dbg	line, "game.c", 58
	dec     _knight
;
; else if (pad1 & PAD_RIGHT){
;
	.dbg	line, "game.c", 60
	jmp     L0004
L000E:	lda     _pad1
	and     #$01
	beq     L0004
;
; knight.x += 1;
;
	.dbg	line, "game.c", 61
	inc     _knight
;
; bgCollision();
;
	.dbg	line, "game.c", 64
L0004:	jsr     _bgCollision
;
; if(collision_R) knight.x -= 1;
;
	.dbg	line, "game.c", 65
	lda     _collision_R
	beq     L0005
	dec     _knight
;
; if(collision_L) knight.x += 1;
;
	.dbg	line, "game.c", 66
L0005:	lda     _collision_L
	beq     L0006
	inc     _knight
;
; if(pad1 & PAD_UP){
;
	.dbg	line, "game.c", 67
L0006:	lda     _pad1
	and     #$08
	beq     L000F
;
; knight.y -= 1;
;
	.dbg	line, "game.c", 68
	dec     _knight+1
;
; else if (pad1 & PAD_DOWN){
;
	.dbg	line, "game.c", 71
	jmp     L0009
L000F:	lda     _pad1
	and     #$04
	beq     L0009
;
; knight.y += 1;
;
	.dbg	line, "game.c", 72
	inc     _knight+1
;
; bgCollision();
;
	.dbg	line, "game.c", 74
L0009:	jsr     _bgCollision
;
; if(collision_D) knight.y -= 1;
;
	.dbg	line, "game.c", 75
	lda     _collision_D
	beq     L000A
	dec     _knight+1
;
; if(collision_U) knight.y += 1;
;
	.dbg	line, "game.c", 76
L000A:	lda     _collision_U
	beq     L000B
	inc     _knight+1
;
; }
;
	.dbg	line, "game.c", 77
L000B:	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ testCollision (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_testCollision: near

	.dbg	func, "testCollision", "00", extern, "_testCollision"

.segment	"CODE"

;
; for(i = 0; i < numberOfE; i++){
;
	.dbg	line, "game.c", 97
	lda     #$00
	sta     _i
	sta     _i+1
L0002:	lda     _i
	cmp     _numberOfE
	lda     _i+1
	sbc     _numberOfE+1
	bvc     L0008
	eor     #$80
L0008:	bpl     L0003
;
; collision = check_collision(&knight, &E[i]); 
;
	.dbg	line, "game.c", 98
	lda     #<(_knight)
	ldx     #>(_knight)
	jsr     pushax
	lda     _i
	ldx     _i+1
	jsr     aslax2
	clc
	adc     #<(_E)
	tay
	txa
	adc     #>(_E)
	tax
	tya
	jsr     _check_collision
	sta     _collision
;
; if (collision){
;
	.dbg	line, "game.c", 100
	lda     _collision
	beq     L0004
;
; E[i].y++;
;
	.dbg	line, "game.c", 101
	lda     _i
	ldx     _i+1
	jsr     aslax2
	clc
	adc     #<(_E)
	tay
	txa
	adc     #>(_E)
	tax
	tya
	sta     sreg
	stx     sreg+1
	sta     ptr1
	stx     ptr1+1
	ldy     #$01
	lda     (ptr1),y
	clc
	adc     #$01
	sta     (sreg),y
;
; for(i = 0; i < numberOfE; i++){
;
	.dbg	line, "game.c", 97
L0004:	inc     _i
	bne     L0002
	inc     _i+1
	jmp     L0002
;
; }
;
	.dbg	line, "game.c", 105
L0003:	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ draw_bg (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_draw_bg: near

	.dbg	func, "draw_bg", "00", extern, "_draw_bg"

.segment	"CODE"

;
; ppu_off(); // screen off
;
	.dbg	line, "game.c", 110
	jsr     _ppu_off
;
; p_maps = All_Collision_Maps[which_bg];
;
	.dbg	line, "game.c", 112
	ldx     #$00
	lda     _which_bg
	asl     a
	bcc     L0025
	inx
	clc
L0025:	adc     #<(_All_Collision_Maps)
	sta     ptr1
	txa
	adc     #>(_All_Collision_Maps)
	sta     ptr1+1
	ldy     #$01
	lda     (ptr1),y
	sta     _p_maps+1
	dey
	lda     (ptr1),y
	sta     _p_maps
;
; memcpy (c_map, p_maps, 240);
;
	.dbg	line, "game.c", 114
	lda     #<(_c_map)
	ldx     #>(_c_map)
	jsr     pushax
	lda     _p_maps
	ldx     _p_maps+1
	jsr     pushax
	ldx     #$00
	lda     #$F0
	jsr     _memcpy
;
; vram_adr(NAMETABLE_A);
;
	.dbg	line, "game.c", 117
	ldx     #$20
	lda     #$00
	jsr     _vram_adr
;
; for(temp_y = 0; temp_y < 15; ++temp_y){
;
	.dbg	line, "game.c", 121
	lda     #$00
	sta     _temp_y
L0026:	lda     _temp_y
	cmp     #$0F
	jcs     L0003
;
; for(temp_x = 0; temp_x < 16; ++temp_x){
;
	.dbg	line, "game.c", 122
	lda     #$00
	sta     _temp_x
L0027:	lda     _temp_x
	cmp     #$10
	bcs     L0029
;
; temp1 = (temp_y << 4) + temp_x;
;
	.dbg	line, "game.c", 123
	lda     _temp_y
	asl     a
	asl     a
	asl     a
	asl     a
	clc
	adc     _temp_x
	sta     _temp1
;
; if(c_map[temp1] == 1){
;
	.dbg	line, "game.c", 125
	ldy     _temp1
	lda     _c_map,y
	cmp     #$01
	bne     L000A
;
; vram_put(0x02); // wall
;
	.dbg	line, "game.c", 126
	lda     #$02
	jsr     _vram_put
;
; vram_put(0x02);
;
	.dbg	line, "game.c", 127
	lda     #$02
;
; else if(c_map[temp1] == 2){
;
	.dbg	line, "game.c", 129
	jmp     L0023
L000A:	ldy     _temp1
	lda     _c_map,y
	cmp     #$02
	bne     L000D
;
; vram_put(0x03); // Pink
;
	.dbg	line, "game.c", 130
	lda     #$03
	jsr     _vram_put
;
; vram_put(0x03);
;
	.dbg	line, "game.c", 131
	lda     #$03
;
; else if(c_map[temp1] == 3){
;
	.dbg	line, "game.c", 133
	jmp     L0023
L000D:	ldy     _temp1
	lda     _c_map,y
	cmp     #$03
	bne     L0028
;
; vram_put(0x07); // Heart 
;
	.dbg	line, "game.c", 134
	lda     #$07
	jsr     _vram_put
;
; vram_put(0x08); // Heart 
;
	.dbg	line, "game.c", 135
	lda     #$08
;
; else{
;
	.dbg	line, "game.c", 137
	jmp     L0023
;
; vram_put(0); // blank
;
	.dbg	line, "game.c", 138
L0028:	lda     #$00
	jsr     _vram_put
;
; vram_put(0);
;
	.dbg	line, "game.c", 139
	lda     #$00
L0023:	jsr     _vram_put
;
; for(temp_x = 0; temp_x < 16; ++temp_x){
;
	.dbg	line, "game.c", 122
	inc     _temp_x
	jmp     L0027
;
; for(temp_x = 0; temp_x < 16; ++temp_x){
;
	.dbg	line, "game.c", 144
L0029:	lda     #$00
	sta     _temp_x
L002A:	lda     _temp_x
	cmp     #$10
	bcs     L002C
;
; temp1 = (temp_y << 4) + temp_x;
;
	.dbg	line, "game.c", 145
	lda     _temp_y
	asl     a
	asl     a
	asl     a
	asl     a
	clc
	adc     _temp_x
	sta     _temp1
;
; if(c_map[temp1] == 1){
;
	.dbg	line, "game.c", 147
	ldy     _temp1
	lda     _c_map,y
	cmp     #$01
	bne     L0017
;
; vram_put(0x02); // wall
;
	.dbg	line, "game.c", 148
	lda     #$02
	jsr     _vram_put
;
; vram_put(0x02);
;
	.dbg	line, "game.c", 149
	lda     #$02
;
; else if(c_map[temp1] == 2){
;
	.dbg	line, "game.c", 151
	jmp     L0024
L0017:	ldy     _temp1
	lda     _c_map,y
	cmp     #$02
	bne     L001A
;
; vram_put(0x03); // Pink
;
	.dbg	line, "game.c", 152
	lda     #$03
	jsr     _vram_put
;
; vram_put(0x03);
;
	.dbg	line, "game.c", 153
	lda     #$03
;
; else if(c_map[temp1] == 3){
;
	.dbg	line, "game.c", 155
	jmp     L0024
L001A:	ldy     _temp1
	lda     _c_map,y
	cmp     #$03
	bne     L002B
;
; vram_put(0x17); // Heart 
;
	.dbg	line, "game.c", 156
	lda     #$17
	jsr     _vram_put
;
; vram_put(0x18);
;
	.dbg	line, "game.c", 157
	lda     #$18
;
; else{
;
	.dbg	line, "game.c", 159
	jmp     L0024
;
; vram_put(0); // blank
;
	.dbg	line, "game.c", 160
L002B:	lda     #$00
	jsr     _vram_put
;
; vram_put(0);
;
	.dbg	line, "game.c", 161
	lda     #$00
L0024:	jsr     _vram_put
;
; for(temp_x = 0; temp_x < 16; ++temp_x){
;
	.dbg	line, "game.c", 144
	inc     _temp_x
	jmp     L002A
;
; for(temp_y = 0; temp_y < 15; ++temp_y){
;
	.dbg	line, "game.c", 121
L002C:	inc     _temp_y
	jmp     L0026
;
; loadEnemyData();
;
	.dbg	line, "game.c", 165
L0003:	jsr     _loadEnemyData
;
; ppu_on_all(); // turn on screen
;
	.dbg	line, "game.c", 166
	jmp     _ppu_on_all

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ bgCollision (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_bgCollision: near

	.dbg	func, "bgCollision", "00", extern, "_bgCollision"

.segment	"CODE"

;
; collision_L = 0;
;
	.dbg	line, "game.c", 172
	lda     #$00
	sta     _collision_L
;
; collision_R = 0;
;
	.dbg	line, "game.c", 173
	sta     _collision_R
;
; collision_U = 0;
;
	.dbg	line, "game.c", 174
	sta     _collision_U
;
; collision_D = 0;
;
	.dbg	line, "game.c", 175
	sta     _collision_D
;
; temp_x = knight.x; // left side
;
	.dbg	line, "game.c", 177
	lda     _knight
	sta     _temp_x
;
; temp_y = knight.y; // top side
;
	.dbg	line, "game.c", 178
	lda     _knight+1
	sta     _temp_y
;
; if(temp_y >= 0xf0) return;
;
	.dbg	line, "game.c", 180
	cmp     #$F0
	bcc     L0015
;
; }
;
	.dbg	line, "game.c", 214
	rts
;
; coordinates = (temp_x >> 4) + (temp_y & 0xf0); // upper left
;
	.dbg	line, "game.c", 183
L0015:	lda     _temp_x
	lsr     a
	lsr     a
	lsr     a
	lsr     a
	sta     ptr1
	lda     _temp_y
	and     #$F0
	clc
	adc     ptr1
	sta     _coordinates
;
; if(c_map[coordinates]){ // find a corner in the collision map
;
	.dbg	line, "game.c", 184
	ldy     _coordinates
	lda     _c_map,y
	beq     L0012
;
; ++collision_L;
;
	.dbg	line, "game.c", 185
	inc     _collision_L
;
; ++collision_U;
;
	.dbg	line, "game.c", 186
	inc     _collision_U
;
; temp_x = knight.x + knight.width; // right side
;
	.dbg	line, "game.c", 189
L0012:	lda     _knight
	clc
	adc     _knight+2
	sta     _temp_x
;
; coordinates = (temp_x >> 4) + (temp_y & 0xf0); // upper right
;
	.dbg	line, "game.c", 191
	lsr     a
	lsr     a
	lsr     a
	lsr     a
	sta     ptr1
	lda     _temp_y
	and     #$F0
	clc
	adc     ptr1
	sta     _coordinates
;
; if(c_map[coordinates]){
;
	.dbg	line, "game.c", 192
	ldy     _coordinates
	lda     _c_map,y
	beq     L0013
;
; ++collision_R;
;
	.dbg	line, "game.c", 193
	inc     _collision_R
;
; ++collision_U;
;
	.dbg	line, "game.c", 194
	inc     _collision_U
;
; temp_y = knight.y + knight.height; // bottom side
;
	.dbg	line, "game.c", 197
L0013:	lda     _knight+1
	clc
	adc     _knight+3
	sta     _temp_y
;
; if(temp_y >= 0xf0) return;
;
	.dbg	line, "game.c", 198
	cmp     #$F0
	bcs     L000A
;
; coordinates = (temp_x >> 4) + (temp_y & 0xf0); // bottom right
;
	.dbg	line, "game.c", 201
	lda     _temp_x
	lsr     a
	lsr     a
	lsr     a
	lsr     a
	sta     ptr1
	lda     _temp_y
	and     #$F0
	clc
	adc     ptr1
	sta     _coordinates
;
; if(c_map[coordinates]){
;
	.dbg	line, "game.c", 202
	ldy     _coordinates
	lda     _c_map,y
	beq     L0014
;
; ++collision_R;
;
	.dbg	line, "game.c", 203
	inc     _collision_R
;
; ++collision_D;
;
	.dbg	line, "game.c", 204
	inc     _collision_D
;
; temp_x = knight.x; // left side
;
	.dbg	line, "game.c", 207
L0014:	lda     _knight
	sta     _temp_x
;
; coordinates = (temp_x >> 4) + (temp_y & 0xf0); // bottom left
;
	.dbg	line, "game.c", 209
	lsr     a
	lsr     a
	lsr     a
	lsr     a
	sta     ptr1
	lda     _temp_y
	and     #$F0
	clc
	adc     ptr1
	sta     _coordinates
;
; if(c_map[coordinates]){
;
	.dbg	line, "game.c", 210
	ldy     _coordinates
	lda     _c_map,y
	beq     L000A
;
; ++collision_L;
;
	.dbg	line, "game.c", 211
	inc     _collision_L
;
; ++collision_D;
;
	.dbg	line, "game.c", 212
	inc     _collision_D
;
; }
;
	.dbg	line, "game.c", 214
L000A:	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ check_start (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_check_start: near

	.dbg	func, "check_start", "00", extern, "_check_start"

.segment	"CODE"

;
; if(pad1_new & PAD_START){
;
	.dbg	line, "game.c", 218
	lda     _pad1_new
	and     #$10
	beq     L0002
;
; ++which_bg;
;
	.dbg	line, "game.c", 219
	inc     _which_bg
;
; if(which_bg >= 2) which_bg = 0;
;
	.dbg	line, "game.c", 220
	lda     _which_bg
	cmp     #$02
	bcc     L0003
	lda     #$00
	sta     _which_bg
;
; draw_bg();
;
	.dbg	line, "game.c", 221
L0003:	jmp     _draw_bg
;
; }
;
	.dbg	line, "game.c", 223
L0002:	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ loadEnemyData (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_loadEnemyData: near

	.dbg	func, "loadEnemyData", "00", extern, "_loadEnemyData"

.segment	"CODE"

;
; E[0].x = 64;
;
	.dbg	line, "game.c", 226
	lda     #$40
	sta     _E
;
; E[0].y = 64;
;
	.dbg	line, "game.c", 227
	sta     _E+1
;
; E[0].width = 15;
;
	.dbg	line, "game.c", 228
	lda     #$0F
	sta     _E+2
;
; E[0].height = 15;
;
	.dbg	line, "game.c", 229
	sta     _E+3
;
; E[1].x = 128;
;
	.dbg	line, "game.c", 231
	lda     #$80
	sta     _E+4
;
; E[1].y = 128;
;
	.dbg	line, "game.c", 232
	sta     _E+5
;
; E[1].width = 15;
;
	.dbg	line, "game.c", 233
	lda     #$0F
	sta     _E+6
;
; E[1].height = 15;
;
	.dbg	line, "game.c", 234
	sta     _E+7
;
; E[2].x = 420;
;
	.dbg	line, "game.c", 236
	lda     #$A4
	sta     _E+8
;
; E[2].y = 64;
;
	.dbg	line, "game.c", 237
	lda     #$40
	sta     _E+9
;
; E[2].width = 15;
;
	.dbg	line, "game.c", 238
	lda     #$0F
	sta     _E+10
;
; E[2].height = 15;
;
	.dbg	line, "game.c", 239
	sta     _E+11
;
; numberOfE = which_bg+1;
;
	.dbg	line, "game.c", 243
	ldx     #$00
	lda     _which_bg
	clc
	adc     #$01
	bcc     L0002
	inx
L0002:	sta     _numberOfE
	stx     _numberOfE+1
;
; }
;
	.dbg	line, "game.c", 246
	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ updateHealth (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_updateHealth: near

	.dbg	func, "updateHealth", "00", extern, "_updateHealth"

.segment	"CODE"

;
; for(i = 0; i < health; i++){
;
	.dbg	line, "game.c", 249
	lda     #$00
	sta     _i
	sta     _i+1
L0002:	lda     _i
	cmp     _health
	lda     _i+1
	sbc     _health+1
	bvc     L0007
	eor     #$80
L0007:	bpl     L0003
;
; oam_spr((i*8), 0, 0x80, 1);
;
	.dbg	line, "game.c", 250
	jsr     decsp3
	lda     _i
	asl     a
	asl     a
	asl     a
	ldy     #$02
	sta     (sp),y
	lda     #$00
	dey
	sta     (sp),y
	lda     #$80
	dey
	sta     (sp),y
	lda     #$01
	jsr     _oam_spr
;
; for(i = 0; i < health; i++){
;
	.dbg	line, "game.c", 249
	inc     _i
	bne     L0002
	inc     _i+1
	jmp     L0002
;
; }
;
	.dbg	line, "game.c", 253
L0003:	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ loseCheck (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_loseCheck: near

	.dbg	func, "loseCheck", "00", extern, "_loseCheck"

.segment	"CODE"

;
; if(health < 0){
;
	.dbg	line, "game.c", 256
	ldx     _health+1
	cpx     #$80
	bcc     L0002
;
; ppu_off(); // screen off //make this better and fade in/out after saying you died
;
	.dbg	line, "game.c", 258
	jsr     _ppu_off
;
; which_bg = 0;
;
	.dbg	line, "game.c", 259
	lda     #$00
	sta     _which_bg
;
; draw_bg();
;
	.dbg	line, "game.c", 260
	jsr     _draw_bg
;
; health = maxHealth;
;
	.dbg	line, "game.c", 261
	lda     _maxHealth+1
	sta     _health+1
	lda     _maxHealth
	sta     _health
;
; knight.x = 120;
;
	.dbg	line, "game.c", 262
	lda     #$78
	sta     _knight
;
; knight.y = 112;
;
	.dbg	line, "game.c", 263
	lda     #$70
	sta     _knight+1
;
; ppu_wait_nmi();
;
	.dbg	line, "game.c", 264
	jsr     _ppu_wait_nmi
;
; ppu_on_all();
;
	.dbg	line, "game.c", 265
	jmp     _ppu_on_all
;
; }
;
	.dbg	line, "game.c", 267
L0002:	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ testButton (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_testButton: near

	.dbg	func, "testButton", "00", extern, "_testButton"

.segment	"CODE"

;
; if(pad1_new & PAD_SELECT){
;
	.dbg	line, "game.c", 271
	lda     _pad1_new
	and     #$20
	beq     L0002
;
; health -= 1;
;
	.dbg	line, "game.c", 272
	lda     _health
	sec
	sbc     #$01
	sta     _health
	bcs     L0002
	dec     _health+1
;
; }
;
	.dbg	line, "game.c", 276
L0002:	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ nextRoom (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nextRoom: near

	.dbg	func, "nextRoom", "00", extern, "_nextRoom"

.segment	"CODE"

;
; if(knight.y < 16){
;
	.dbg	line, "game.c", 279
	lda     _knight+1
	cmp     #$10
	bcs     L000C
;
; knight.y = 224;
;
	.dbg	line, "game.c", 280
	lda     #$E0
	sta     _knight+1
;
; mapPos -= mapWidth;
;
	.dbg	line, "game.c", 281
	lda     _mapWidth
	eor     #$FF
	sec
	adc     _mapPos
	sta     _mapPos
	lda     _mapWidth+1
	eor     #$FF
	adc     _mapPos+1
	sta     _mapPos+1
;
; which_bg = worldMap[mapPos];
;
	.dbg	line, "game.c", 282
	lda     _mapPos
;
; else if(knight.y > 224){
;
	.dbg	line, "game.c", 285
	jmp     L0016
L000C:	lda     _knight+1
	cmp     #$E1
	bcc     L000D
;
; knight.y = 16;
;
	.dbg	line, "game.c", 286
	lda     #$10
	sta     _knight+1
;
; mapPos += mapWidth;
;
	.dbg	line, "game.c", 287
	lda     _mapWidth
	clc
	adc     _mapPos
	sta     _mapPos
	lda     _mapWidth+1
	adc     _mapPos+1
	sta     _mapPos+1
;
; which_bg = worldMap[mapPos];
;
	.dbg	line, "game.c", 288
	lda     _mapPos
;
; else if(knight.x <= 0 ){
;
	.dbg	line, "game.c", 291
	jmp     L0016
L000D:	lda     _knight
	bne     L000E
;
; knight.x = 239;
;
	.dbg	line, "game.c", 292
	lda     #$EF
	sta     _knight
;
; mapPos=mapPos-1;
;
	.dbg	line, "game.c", 293
	lda     _mapPos
	ldx     _mapPos+1
	sec
	sbc     #$01
	bcs     L000A
	dex
;
; else if(knight.x >= 240){
;
	.dbg	line, "game.c", 297
	jmp     L000A
L000E:	lda     _knight
	cmp     #$F0
	bcc     L0009
;
; knight.x = 1;//can't go less than 0, so have to be a pixel over
;
	.dbg	line, "game.c", 298
	lda     #$01
	sta     _knight
;
; mapPos=mapPos+1;
;
	.dbg	line, "game.c", 299
	lda     _mapPos
	ldx     _mapPos+1
	clc
	adc     #$01
	bcc     L000A
	inx
L000A:	sta     _mapPos
	stx     _mapPos+1
;
; which_bg = worldMap[mapPos];
;
	.dbg	line, "game.c", 300
L0016:	sta     ptr1
	lda     _mapPos+1
	clc
	adc     #>(_worldMap)
	sta     ptr1+1
	ldy     #<(_worldMap)
	lda     (ptr1),y
	sta     _which_bg
;
; draw_bg();
;
	.dbg	line, "game.c", 301
	jmp     _draw_bg
;
; }
;
	.dbg	line, "game.c", 305
L0009:	rts

	.dbg	line
.endproc

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

	.dbg	func, "main", "00", extern, "_main"

.segment	"CODE"

;
; ppu_off(); // screen off
;
	.dbg	line, "game.c", 14
	jsr     _ppu_off
;
; pal_bg(paletteBg); // load the BG palette
;
	.dbg	line, "game.c", 16
	lda     #<(_paletteBg)
	ldx     #>(_paletteBg)
	jsr     _pal_bg
;
; pal_spr(paletteSp);//load the sprite palette
;
	.dbg	line, "game.c", 17
	lda     #<(_paletteSp)
	ldx     #>(_paletteSp)
	jsr     _pal_spr
;
; bank_spr(1);
;
	.dbg	line, "game.c", 18
	lda     #$01
	jsr     _bank_spr
;
; vram_adr(NTADR_A(3,3)); // screen is 32 x 30 tiles
;
	.dbg	line, "game.c", 21
	ldx     #$20
	lda     #$63
	jsr     _vram_adr
;
; bank_spr(1);
;
	.dbg	line, "game.c", 24
	lda     #$01
	jsr     _bank_spr
;
; set_scroll_y(0xff); //shift the bg down 1 pixel
;
	.dbg	line, "game.c", 26
	ldx     #$00
	lda     #$FF
	jsr     _set_scroll_y
;
; draw_bg();
;
	.dbg	line, "game.c", 30
	jsr     _draw_bg
;
; ppu_wait_nmi();
;
	.dbg	line, "game.c", 40
L0002:	jsr     _ppu_wait_nmi
;
; pad1 = pad_poll(0); //read first controller input
;
	.dbg	line, "game.c", 41
	lda     #$00
	jsr     _pad_poll
	sta     _pad1
;
; pad1_new = get_pad_new(0); // newly pressed button. do pad_poll first
;
	.dbg	line, "game.c", 42
	lda     #$00
	jsr     _get_pad_new
	sta     _pad1_new
;
; move();//move the player
;
	.dbg	line, "game.c", 44
	jsr     _move
;
; testCollision();//sprite collisions
;
	.dbg	line, "game.c", 45
	jsr     _testCollision
;
; drawSprites();
;
	.dbg	line, "game.c", 46
	jsr     _drawSprites
;
; check_start();
;
	.dbg	line, "game.c", 47
	jsr     _check_start
;
; testButton();//currently select
;
	.dbg	line, "game.c", 48
	jsr     _testButton
;
; updateHealth();
;
	.dbg	line, "game.c", 49
	jsr     _updateHealth
;
; nextRoom();
;
	.dbg	line, "game.c", 50
	jsr     _nextRoom
;
; loseCheck();
;
	.dbg	line, "game.c", 51
	jsr     _loseCheck
;
; while (1){
;
	.dbg	line, "game.c", 37
	jmp     L0002

	.dbg	line
.endproc

