;
; File generated by cc65 v 2.19 - Git bb1b5c3
;
	.fopt		compiler,"cc65 v 2.19 - Git bb1b5c3"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.forceimport	__STARTUP__
	.import		_pal_bg
	.import		_pal_spr
	.import		_ppu_wait_nmi
	.import		_ppu_off
	.import		_ppu_on_all
	.import		_oam_clear
	.import		_oam_meta_spr
	.import		_pad_poll
	.import		_bank_spr
	.import		_vram_adr
	.import		_vram_write
	.export		_metasprite
	.export		_metasprite2
	.export		_yPos
	.export		_xPos
	.export		_pad1
	.export		_text
	.export		_palette
	.export		_main

.segment	"DATA"

_yPos:
	.byte	$40
_xPos:
	.byte	$88

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
_text:
	.byte	$59,$6F,$75,$20,$74,$72,$75,$6C,$79,$20,$61,$72,$65,$20,$74,$68
	.byte	$65,$20,$64,$61,$72,$6B,$20,$73,$6F,$75,$6C,$00
_palette:
	.byte	$0F
	.byte	$00
	.byte	$0C
	.byte	$07
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

.segment	"BSS"

.segment	"ZEROPAGE"
_pad1:
	.res	1,$00

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

;
; ppu_off(); // screen off
;
	jsr     _ppu_off
;
; pal_bg(palette); // load the BG palette
;
	lda     #<(_palette)
	ldx     #>(_palette)
	jsr     _pal_bg
;
; pal_spr(palette);//load the sprite palette
;
	lda     #<(_palette)
	ldx     #>(_palette)
	jsr     _pal_spr
;
; bank_spr(1);
;
	lda     #$01
	jsr     _bank_spr
;
; vram_adr(NTADR_A(3,3)); // screen is 32 x 30 tiles
;
	ldx     #$20
	lda     #$63
	jsr     _vram_adr
;
; vram_write(text,sizeof(text)); 
;
	lda     #<(_text)
	ldx     #>(_text)
	jsr     pushax
	ldx     #$00
	lda     #$1C
	jsr     _vram_write
;
; ppu_on_all(); // turn on screen
;
	jsr     _ppu_on_all
;
; pad1 = pad_poll(0); //read first controller input
;
L0002:	lda     #$00
	jsr     _pad_poll
	sta     _pad1
;
; if(pad1 & PAD_LEFT){
;
	and     #$02
	beq     L000D
;
; xPos -= 1;
;
	dec     _xPos
;
; else if (pad1 & PAD_RIGHT){
;
	jmp     L000E
L000D:	lda     _pad1
	and     #$01
	beq     L000E
;
; xPos += 1;
;
	inc     _xPos
;
; if(pad1 & PAD_UP){
;
L000E:	lda     _pad1
	and     #$08
	beq     L000F
;
; yPos -= 1;
;
	dec     _yPos
;
; else if (pad1 & PAD_DOWN){
;
	jmp     L000A
L000F:	lda     _pad1
	and     #$04
	beq     L000A
;
; yPos += 1;
;
	inc     _yPos
;
; ppu_wait_nmi(); // wait till beginning of the frame
;
L000A:	jsr     _ppu_wait_nmi
;
; oam_clear(); //Clear the sprite buffer.
;
	jsr     _oam_clear
;
; oam_meta_spr(xPos,yPos,metasprite); //Push 1 metasprite to the buffer.
;
	jsr     decsp2
	lda     _xPos
	ldy     #$01
	sta     (sp),y
	lda     _yPos
	dey
	sta     (sp),y
	lda     #<(_metasprite)
	ldx     #>(_metasprite)
	jsr     _oam_meta_spr
;
; while (1){
;
	jmp     L0002

.endproc

