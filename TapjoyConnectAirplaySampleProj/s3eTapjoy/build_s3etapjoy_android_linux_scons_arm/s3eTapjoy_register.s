	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"s3eTapjoy_register.cpp"
	.section	.text.s3eTapjoyGetErrorString,"ax",%progbits
	.align	2
	.global	s3eTapjoyGetErrorString
	.hidden	s3eTapjoyGetErrorString
	.type	s3eTapjoyGetErrorString, %function
s3eTapjoyGetErrorString:
	.fnstart
.LFB14:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r0, #0
	bx	lr
	.fnend
	.size	s3eTapjoyGetErrorString, .-s3eTapjoyGetErrorString
	.section	.text._Z20s3eTapjoyRegisterExtv,"ax",%progbits
	.align	2
	.global	_Z20s3eTapjoyRegisterExtv
	.hidden	_Z20s3eTapjoyRegisterExtv
	.type	_Z20s3eTapjoyRegisterExtv, %function
_Z20s3eTapjoyRegisterExtv:
	.fnstart
.LFB18:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 184
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	.save {r4, r5, lr}
	ldr	r3, .L5
	ldr	lr, .L5+4
	.pad #204
	sub	sp, sp, #204
	str	lr, [sp, #108]
	str	r3, [sp, #112]
	ldr	ip, .L5+8
	ldr	lr, .L5+12
	ldr	r3, .L5+16
	str	ip, [sp, #116]
	str	lr, [sp, #120]
	str	r3, [sp, #124]
	ldr	ip, .L5+20
	ldr	lr, .L5+24
	ldr	r3, .L5+28
	str	ip, [sp, #128]
	str	lr, [sp, #132]
	str	r3, [sp, #136]
	ldr	ip, .L5+32
	ldr	lr, .L5+36
	ldr	r3, .L5+40
	str	ip, [sp, #140]
	str	lr, [sp, #144]
	str	r3, [sp, #148]
	ldr	ip, .L5+44
	ldr	lr, .L5+48
	ldr	r3, .L5+52
	str	ip, [sp, #152]
	str	lr, [sp, #156]
	str	r3, [sp, #160]
	ldr	ip, .L5+56
	ldr	lr, .L5+60
	ldr	r3, .L5+64
	str	ip, [sp, #164]
	str	lr, [sp, #168]
	str	r3, [sp, #172]
	ldr	ip, .L5+68
	ldr	lr, .L5+72
	ldr	r3, .L5+76
	add	r4, sp, #16
	mov	r5, #92
	str	ip, [sp, #176]
	str	lr, [sp, #180]
	str	r3, [sp, #184]
	ldr	ip, .L5+80
	ldr	lr, .L5+84
	ldr	r3, .L5+88
	mov	r2, r5
	mov	r1, #0
	mov	r0, r4
	str	ip, [sp, #188]
	str	r3, [sp, #196]
	str	lr, [sp, #192]
	bl	memset
	ldr	ip, .L5+92
	str	ip, [sp, #0]
	ldr	ip, .L5+96
	mov	r2, r5
	str	ip, [sp, #4]
	mov	r3, r4
	mov	ip, #0
	ldr	r0, .L5+100
	add	r1, sp, #108
	str	ip, [sp, #8]
	bl	s3eEdkRegister
	add	sp, sp, #204
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L6:
	.align	2
.L5:
	.word	s3eTapjoyUnRegister
	.word	s3eTapjoyRegister
	.word	s3eTapjoyGetErrorString
	.word	s3eTapjoyGetError
	.word	TapjoyRequestConnect
	.word	TapjoyActionComplete
	.word	TapjoySetUserID
	.word	TapjoyShowOffers
	.word	TapjoyShowOffersWithCurrenyID
	.word	TapjoyGetTapPoints
	.word	TapjoySpendTapPoints
	.word	TapjoyAwardTapPoints
	.word	TapjoyShowVirtualGoods
	.word	TapjoyGetPurchasedItem
	.word	TapjoyGetAvailableItem
	.word	TapjoyGetFeaturedApp
	.word	TapjoyShowFeaturedAppFullScreenAd
	.word	TapjoySetFeaturedAppDisplayCount
	.word	TapjoySetTransitionEffect
	.word	TapjoySetOffersNavBarImage
	.word	TapjoySetUserDefinedColor
	.word	TapjoyGetDisplayAd
	.word	TapjoySetDisplayAdView
	.word	_Z13s3eTapjoyInitv
	.word	_Z18s3eTapjoyTerminatev
	.word	.LC0
	.fnend
	.size	_Z20s3eTapjoyRegisterExtv, .-_Z20s3eTapjoyRegisterExtv
	.section	.text.s3eTapjoyUnRegister,"ax",%progbits
	.align	2
	.global	s3eTapjoyUnRegister
	.hidden	s3eTapjoyUnRegister
	.type	s3eTapjoyUnRegister, %function
s3eTapjoyUnRegister:
	.fnstart
.LFB17:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	mov	r2, r0
	.pad #12
	sub	sp, sp, #12
	mov	r3, r1
	mov	ip, #0
	mov	r1, #7
	ldr	r0, .L9
	str	ip, [sp, #0]
	bl	s3eEdkCallbacksUnRegister
	add	sp, sp, #12
	ldr	lr, [sp], #4
	bx	lr
.L10:
	.align	2
.L9:
	.word	-880042745
	.fnend
	.size	s3eTapjoyUnRegister, .-s3eTapjoyUnRegister
	.section	.text.s3eTapjoyRegister,"ax",%progbits
	.align	2
	.global	s3eTapjoyRegister
	.hidden	s3eTapjoyRegister
	.type	s3eTapjoyRegister, %function
s3eTapjoyRegister:
	.fnstart
.LFB16:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #12
	sub	sp, sp, #12
	mov	r3, r1
	str	r2, [sp, #0]
	mov	ip, #0
	mov	r2, r0
	mov	r1, #7
	ldr	r0, .L13
	str	ip, [sp, #4]
	bl	s3eEdkCallbacksRegister
	add	sp, sp, #12
	ldr	lr, [sp], #4
	bx	lr
.L14:
	.align	2
.L13:
	.word	-880042745
	.fnend
	.size	s3eTapjoyRegister, .-s3eTapjoyRegister
	.section	.text.s3eTapjoyGetError,"ax",%progbits
	.align	2
	.global	s3eTapjoyGetError
	.hidden	s3eTapjoyGetError
	.type	s3eTapjoyGetError, %function
s3eTapjoyGetError:
	.fnstart
.LFB15:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	ldr	r0, .L17
	bl	s3eEdkErrorGet
	ldmfd	sp!, {r3, lr}
	bx	lr
.L18:
	.align	2
.L17:
	.word	-880042745
	.fnend
	.size	s3eTapjoyGetError, .-s3eTapjoyGetError
	.section	.text.RegisterExt,"ax",%progbits
	.align	2
	.global	RegisterExt
	.type	RegisterExt, %function
RegisterExt:
	.fnstart
.LFB19:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 184
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	.save {r4, r5, lr}
	ldr	r3, .L21
	ldr	lr, .L21+4
	.pad #204
	sub	sp, sp, #204
	str	lr, [sp, #108]
	str	r3, [sp, #112]
	ldr	ip, .L21+8
	ldr	lr, .L21+12
	ldr	r3, .L21+16
	str	ip, [sp, #116]
	str	lr, [sp, #120]
	str	r3, [sp, #124]
	ldr	ip, .L21+20
	ldr	lr, .L21+24
	ldr	r3, .L21+28
	str	ip, [sp, #128]
	str	lr, [sp, #132]
	str	r3, [sp, #136]
	ldr	ip, .L21+32
	ldr	lr, .L21+36
	ldr	r3, .L21+40
	str	ip, [sp, #140]
	str	lr, [sp, #144]
	str	r3, [sp, #148]
	ldr	ip, .L21+44
	ldr	lr, .L21+48
	ldr	r3, .L21+52
	str	ip, [sp, #152]
	str	lr, [sp, #156]
	str	r3, [sp, #160]
	ldr	ip, .L21+56
	ldr	lr, .L21+60
	ldr	r3, .L21+64
	str	ip, [sp, #164]
	str	lr, [sp, #168]
	str	r3, [sp, #172]
	ldr	ip, .L21+68
	ldr	lr, .L21+72
	ldr	r3, .L21+76
	add	r4, sp, #16
	mov	r5, #92
	str	ip, [sp, #176]
	str	lr, [sp, #180]
	str	r3, [sp, #184]
	ldr	ip, .L21+80
	ldr	lr, .L21+84
	ldr	r3, .L21+88
	mov	r2, r5
	mov	r1, #0
	mov	r0, r4
	str	ip, [sp, #188]
	str	r3, [sp, #196]
	str	lr, [sp, #192]
	bl	memset
	ldr	ip, .L21+92
	str	ip, [sp, #0]
	ldr	ip, .L21+96
	mov	r2, r5
	str	ip, [sp, #4]
	mov	r3, r4
	mov	ip, #0
	ldr	r0, .L21+100
	add	r1, sp, #108
	str	ip, [sp, #8]
	bl	s3eEdkRegister
	add	sp, sp, #204
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L22:
	.align	2
.L21:
	.word	s3eTapjoyUnRegister
	.word	s3eTapjoyRegister
	.word	s3eTapjoyGetErrorString
	.word	s3eTapjoyGetError
	.word	TapjoyRequestConnect
	.word	TapjoyActionComplete
	.word	TapjoySetUserID
	.word	TapjoyShowOffers
	.word	TapjoyShowOffersWithCurrenyID
	.word	TapjoyGetTapPoints
	.word	TapjoySpendTapPoints
	.word	TapjoyAwardTapPoints
	.word	TapjoyShowVirtualGoods
	.word	TapjoyGetPurchasedItem
	.word	TapjoyGetAvailableItem
	.word	TapjoyGetFeaturedApp
	.word	TapjoyShowFeaturedAppFullScreenAd
	.word	TapjoySetFeaturedAppDisplayCount
	.word	TapjoySetTransitionEffect
	.word	TapjoySetOffersNavBarImage
	.word	TapjoySetUserDefinedColor
	.word	TapjoyGetDisplayAd
	.word	TapjoySetDisplayAdView
	.word	_Z13s3eTapjoyInitv
	.word	_Z18s3eTapjoyTerminatev
	.word	.LC0
	.fnend
	.size	RegisterExt, .-RegisterExt
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"s3eTapjoy\000"
	.ident	"GCC: (Sourcery G++ Lite 2010q1-202) 4.4.1"
	.section	.note.GNU-stack,"",%progbits
