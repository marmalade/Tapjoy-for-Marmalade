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
	.file	"s3eTapjoy.cpp"
	.section	.text.TapjoySetDisplayAdView,"ax",%progbits
	.align	2
	.global	TapjoySetDisplayAdView
	.hidden	TapjoySetDisplayAdView
	.type	TapjoySetDisplayAdView, %function
TapjoySetDisplayAdView:
	.fnstart
.LFB20:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z31TapjoySetDisplayAdView_platformiiii
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoySetDisplayAdView, .-TapjoySetDisplayAdView
	.section	.text.TapjoyGetDisplayAd,"ax",%progbits
	.align	2
	.global	TapjoyGetDisplayAd
	.hidden	TapjoyGetDisplayAd
	.type	TapjoyGetDisplayAd, %function
TapjoyGetDisplayAd:
	.fnstart
.LFB19:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z27TapjoyGetDisplayAd_platformPKchPFiP24TapjoyGetDisplayAdResultPvES3_
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyGetDisplayAd, .-TapjoyGetDisplayAd
	.section	.text.TapjoySetUserDefinedColor,"ax",%progbits
	.align	2
	.global	TapjoySetUserDefinedColor
	.hidden	TapjoySetUserDefinedColor
	.type	TapjoySetUserDefinedColor, %function
TapjoySetUserDefinedColor:
	.fnstart
.LFB18:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z34TapjoySetUserDefinedColor_platformi
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoySetUserDefinedColor, .-TapjoySetUserDefinedColor
	.section	.text.TapjoySetOffersNavBarImage,"ax",%progbits
	.align	2
	.global	TapjoySetOffersNavBarImage
	.hidden	TapjoySetOffersNavBarImage
	.type	TapjoySetOffersNavBarImage, %function
TapjoySetOffersNavBarImage:
	.fnstart
.LFB17:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z35TapjoySetOffersNavBarImage_platformPKc
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoySetOffersNavBarImage, .-TapjoySetOffersNavBarImage
	.section	.text.TapjoySetTransitionEffect,"ax",%progbits
	.align	2
	.global	TapjoySetTransitionEffect
	.hidden	TapjoySetTransitionEffect
	.type	TapjoySetTransitionEffect, %function
TapjoySetTransitionEffect:
	.fnstart
.LFB16:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z34TapjoySetTransitionEffect_platformi
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoySetTransitionEffect, .-TapjoySetTransitionEffect
	.section	.text.TapjoySetFeaturedAppDisplayCount,"ax",%progbits
	.align	2
	.global	TapjoySetFeaturedAppDisplayCount
	.hidden	TapjoySetFeaturedAppDisplayCount
	.type	TapjoySetFeaturedAppDisplayCount, %function
TapjoySetFeaturedAppDisplayCount:
	.fnstart
.LFB15:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z41TapjoySetFeaturedAppDisplayCount_platformi
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoySetFeaturedAppDisplayCount, .-TapjoySetFeaturedAppDisplayCount
	.section	.text.TapjoyShowFeaturedAppFullScreenAd,"ax",%progbits
	.align	2
	.global	TapjoyShowFeaturedAppFullScreenAd
	.hidden	TapjoyShowFeaturedAppFullScreenAd
	.type	TapjoyShowFeaturedAppFullScreenAd, %function
TapjoyShowFeaturedAppFullScreenAd:
	.fnstart
.LFB14:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z42TapjoyShowFeaturedAppFullScreenAd_platformv
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyShowFeaturedAppFullScreenAd, .-TapjoyShowFeaturedAppFullScreenAd
	.section	.text.TapjoyGetFeaturedApp,"ax",%progbits
	.align	2
	.global	TapjoyGetFeaturedApp
	.hidden	TapjoyGetFeaturedApp
	.type	TapjoyGetFeaturedApp, %function
TapjoyGetFeaturedApp:
	.fnstart
.LFB13:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z29TapjoyGetFeaturedApp_platformPFiP26TapjoyGetFeaturedAppResultPvES1_
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyGetFeaturedApp, .-TapjoyGetFeaturedApp
	.section	.text.TapjoyGetAvailableItem,"ax",%progbits
	.align	2
	.global	TapjoyGetAvailableItem
	.hidden	TapjoyGetAvailableItem
	.type	TapjoyGetAvailableItem, %function
TapjoyGetAvailableItem:
	.fnstart
.LFB12:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z31TapjoyGetAvailableItem_platformi
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyGetAvailableItem, .-TapjoyGetAvailableItem
	.section	.text.TapjoyGetPurchasedItem,"ax",%progbits
	.align	2
	.global	TapjoyGetPurchasedItem
	.hidden	TapjoyGetPurchasedItem
	.type	TapjoyGetPurchasedItem, %function
TapjoyGetPurchasedItem:
	.fnstart
.LFB11:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z31TapjoyGetPurchasedItem_platformi
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyGetPurchasedItem, .-TapjoyGetPurchasedItem
	.section	.text.TapjoyShowVirtualGoods,"ax",%progbits
	.align	2
	.global	TapjoyShowVirtualGoods
	.hidden	TapjoyShowVirtualGoods
	.type	TapjoyShowVirtualGoods, %function
TapjoyShowVirtualGoods:
	.fnstart
.LFB10:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z31TapjoyShowVirtualGoods_platformv
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyShowVirtualGoods, .-TapjoyShowVirtualGoods
	.section	.text.TapjoyAwardTapPoints,"ax",%progbits
	.align	2
	.global	TapjoyAwardTapPoints
	.hidden	TapjoyAwardTapPoints
	.type	TapjoyAwardTapPoints, %function
TapjoyAwardTapPoints:
	.fnstart
.LFB9:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z29TapjoyAwardTapPoints_platformiPFiP26TapjoyAwardTapPointsResultPvES1_
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyAwardTapPoints, .-TapjoyAwardTapPoints
	.section	.text.TapjoySpendTapPoints,"ax",%progbits
	.align	2
	.global	TapjoySpendTapPoints
	.hidden	TapjoySpendTapPoints
	.type	TapjoySpendTapPoints, %function
TapjoySpendTapPoints:
	.fnstart
.LFB8:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z29TapjoySpendTapPoints_platformiPFiP26TapjoySpendTapPointsResultPvES1_
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoySpendTapPoints, .-TapjoySpendTapPoints
	.section	.text.TapjoyGetTapPoints,"ax",%progbits
	.align	2
	.global	TapjoyGetTapPoints
	.hidden	TapjoyGetTapPoints
	.type	TapjoyGetTapPoints, %function
TapjoyGetTapPoints:
	.fnstart
.LFB7:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z27TapjoyGetTapPoints_platformPFiP24TapjoyGetTapPointsResultPvES1_
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyGetTapPoints, .-TapjoyGetTapPoints
	.section	.text.TapjoyShowOffersWithCurrenyID,"ax",%progbits
	.align	2
	.global	TapjoyShowOffersWithCurrenyID
	.hidden	TapjoyShowOffersWithCurrenyID
	.type	TapjoyShowOffersWithCurrenyID, %function
TapjoyShowOffersWithCurrenyID:
	.fnstart
.LFB6:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z38TapjoyShowOffersWithCurrenyID_platformPKch
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyShowOffersWithCurrenyID, .-TapjoyShowOffersWithCurrenyID
	.section	.text.TapjoyShowOffers,"ax",%progbits
	.align	2
	.global	TapjoyShowOffers
	.hidden	TapjoyShowOffers
	.type	TapjoyShowOffers, %function
TapjoyShowOffers:
	.fnstart
.LFB5:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z25TapjoyShowOffers_platformv
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyShowOffers, .-TapjoyShowOffers
	.section	.text.TapjoySetUserID,"ax",%progbits
	.align	2
	.global	TapjoySetUserID
	.hidden	TapjoySetUserID
	.type	TapjoySetUserID, %function
TapjoySetUserID:
	.fnstart
.LFB4:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z24TapjoySetUserID_platformPKc
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoySetUserID, .-TapjoySetUserID
	.section	.text.TapjoyActionComplete,"ax",%progbits
	.align	2
	.global	TapjoyActionComplete
	.hidden	TapjoyActionComplete
	.type	TapjoyActionComplete, %function
TapjoyActionComplete:
	.fnstart
.LFB3:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z29TapjoyActionComplete_platformPKc
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyActionComplete, .-TapjoyActionComplete
	.section	.text.TapjoyRequestConnect,"ax",%progbits
	.align	2
	.global	TapjoyRequestConnect
	.hidden	TapjoyRequestConnect
	.type	TapjoyRequestConnect, %function
TapjoyRequestConnect:
	.fnstart
.LFB2:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z29TapjoyRequestConnect_platformPKcS0_
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	TapjoyRequestConnect, .-TapjoyRequestConnect
	.section	.text._Z18s3eTapjoyTerminatev,"ax",%progbits
	.align	2
	.global	_Z18s3eTapjoyTerminatev
	.hidden	_Z18s3eTapjoyTerminatev
	.type	_Z18s3eTapjoyTerminatev, %function
_Z18s3eTapjoyTerminatev:
	.fnstart
.LFB1:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z27s3eTapjoyTerminate_platformv
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	_Z18s3eTapjoyTerminatev, .-_Z18s3eTapjoyTerminatev
	.section	.text._Z13s3eTapjoyInitv,"ax",%progbits
	.align	2
	.global	_Z13s3eTapjoyInitv
	.hidden	_Z13s3eTapjoyInitv
	.type	_Z13s3eTapjoyInitv, %function
_Z13s3eTapjoyInitv:
	.fnstart
.LFB0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	bl	_Z22s3eTapjoyInit_platformv
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	_Z13s3eTapjoyInitv, .-_Z13s3eTapjoyInitv
	.ident	"GCC: (Sourcery G++ Lite 2010q1-202) 4.4.1"
	.section	.note.GNU-stack,"",%progbits
