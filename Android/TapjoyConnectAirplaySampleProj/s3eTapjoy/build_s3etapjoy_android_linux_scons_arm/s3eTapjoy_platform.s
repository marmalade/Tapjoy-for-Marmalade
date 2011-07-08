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
	.file	"s3eTapjoy_platform.cpp"
	.section	.text._ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_,"axG",%progbits,_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_,comdat
	.align	2
	.weak	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	.hidden	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	.type	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_, %function
_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_:
	.fnstart
.LFB29:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	.save {r3, lr}
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #132]
	mov	lr, pc
	bx	ip
	ldmfd	sp!, {r3, lr}
	bx	lr
	.fnend
	.size	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_, .-_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	.section	.text._Z27s3eTapjoyTerminate_platformv,"ax",%progbits
	.align	2
	.global	_Z27s3eTapjoyTerminate_platformv
	.hidden	_Z27s3eTapjoyTerminate_platformv
	.type	_Z27s3eTapjoyTerminate_platformv, %function
_Z27s3eTapjoyTerminate_platformv:
	.fnstart
.LFB253:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.fnend
	.size	_Z27s3eTapjoyTerminate_platformv, .-_Z27s3eTapjoyTerminate_platformv
	.section	.text._ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz,"axG",%progbits,_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz,comdat
	.align	2
	.weak	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	.hidden	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	.type	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz, %function
_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz:
	.fnstart
.LFB45:
	@ Function supports interworking.
	@ args = 4, pretend = 8, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 1
	stmfd	sp!, {r2, r3}
	.save {r2, r3}
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #12
	sub	sp, sp, #12
	add	r3, sp, #20
	str	r3, [sp, #4]
	ldr	r2, [sp, #16]
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #200]
	mov	lr, pc
	bx	ip
	add	sp, sp, #12
	ldr	lr, [sp], #4
	add	sp, sp, #8
	bx	lr
	.fnend
	.size	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz, .-_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	.section	.text._ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz,"axG",%progbits,_ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz,comdat
	.align	2
	.weak	_ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz
	.hidden	_ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz
	.type	_ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz, %function
_ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz:
	.fnstart
.LFB57:
	@ Function supports interworking.
	@ args = 4, pretend = 8, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 1
	stmfd	sp!, {r2, r3}
	.save {r2, r3}
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #12
	sub	sp, sp, #12
	add	r3, sp, #20
	str	r3, [sp, #4]
	ldr	ip, [r0, #0]
	ldr	r2, [sp, #16]
	ldr	ip, [ip, #248]
	mov	lr, pc
	bx	ip
	add	sp, sp, #12
	ldr	lr, [sp], #4
	add	sp, sp, #8
	bx	lr
	.fnend
	.size	_ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz, .-_ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz
	.section	.text._ZN7_JNIEnv9NewObjectEP7_jclassP10_jmethodIDz,"axG",%progbits,_ZN7_JNIEnv9NewObjectEP7_jclassP10_jmethodIDz,comdat
	.align	2
	.weak	_ZN7_JNIEnv9NewObjectEP7_jclassP10_jmethodIDz
	.hidden	_ZN7_JNIEnv9NewObjectEP7_jclassP10_jmethodIDz
	.type	_ZN7_JNIEnv9NewObjectEP7_jclassP10_jmethodIDz, %function
_ZN7_JNIEnv9NewObjectEP7_jclassP10_jmethodIDz:
	.fnstart
.LFB24:
	@ Function supports interworking.
	@ args = 4, pretend = 8, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 1
	stmfd	sp!, {r2, r3}
	.save {r2, r3}
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #12
	sub	sp, sp, #12
	add	r3, sp, #20
	str	r3, [sp, #4]
	ldr	r2, [sp, #16]
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #116]
	mov	lr, pc
	bx	ip
	add	sp, sp, #12
	ldr	lr, [sp], #4
	add	sp, sp, #8
	bx	lr
	.fnend
	.size	_ZN7_JNIEnv9NewObjectEP7_jclassP10_jmethodIDz, .-_ZN7_JNIEnv9NewObjectEP7_jclassP10_jmethodIDz
	.section	.text._Z29TapjoyGetFeaturedApp_platformPFiP26TapjoyGetFeaturedAppResultPvES1_,"ax",%progbits
	.align	2
	.global	_Z29TapjoyGetFeaturedApp_platformPFiP26TapjoyGetFeaturedAppResultPvES1_
	.hidden	_Z29TapjoyGetFeaturedApp_platformPFiP26TapjoyGetFeaturedAppResultPvES1_
	.type	_Z29TapjoyGetFeaturedApp_platformPFiP26TapjoyGetFeaturedAppResultPvES1_, %function
_Z29TapjoyGetFeaturedApp_platformPFiP26TapjoyGetFeaturedAppResultPvES1_:
	.fnstart
.LFB267:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	.save {r4, r5, lr}
	.pad #20
	sub	sp, sp, #20
	mov	r5, r0
	bl	s3eEdkJNIGetVM
	mov	r4, #0
	add	r1, sp, #16
	str	r4, [r1, #-4]!
	mov	r2, #65536
	ldr	ip, [r0, #0]
	add	r2, r2, #2
	ldr	ip, [ip, #24]
	mov	lr, pc
	bx	ip
	mov	r3, r5
	mov	r1, #7
	mov	r2, #4
	ldr	r0, .L13
	str	r4, [sp, #4]
	str	r4, [sp, #0]
	ldr	r4, [sp, #12]
	bl	s3eEdkCallbacksRegister
	ldr	r3, .L13+4
	mov	r0, r4
	ldmia	r3, {r1, r2}	@ phole ldm
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #20
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L14:
	.align	2
.L13:
	.word	-880042745
	.word	.LANCHOR0
	.fnend
	.size	_Z29TapjoyGetFeaturedApp_platformPFiP26TapjoyGetFeaturedAppResultPvES1_, .-_Z29TapjoyGetFeaturedApp_platformPFiP26TapjoyGetFeaturedAppResultPvES1_
	.section	.text._ZL19FeaturedAppCallbackP7_JNIEnvP8_jobjectS2_,"ax",%progbits
	.align	2
	.type	_ZL19FeaturedAppCallbackP7_JNIEnvP8_jobjectS2_, %function
_ZL19FeaturedAppCallbackP7_JNIEnvP8_jobjectS2_:
	.fnstart
.LFB278:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #60
	sub	sp, sp, #60
	mov	ip, #0
	mov	lr, #1
	mov	r1, #4
	add	r2, sp, #20
	mov	r3, #36
	ldr	r0, .L17
	str	lr, [sp, #4]
	str	ip, [sp, #12]
	str	ip, [sp, #0]
	str	ip, [sp, #8]
	bl	s3eEdkCallbacksEnqueue
	add	sp, sp, #60
	ldr	lr, [sp], #4
	bx	lr
.L18:
	.align	2
.L17:
	.word	-880042745
	.fnend
	.size	_ZL19FeaturedAppCallbackP7_JNIEnvP8_jobjectS2_, .-_ZL19FeaturedAppCallbackP7_JNIEnvP8_jobjectS2_
	.section	.text._ZL22AwardTapPointsCallbackP7_JNIEnvP8_jobjecti,"ax",%progbits
	.align	2
	.type	_ZL22AwardTapPointsCallbackP7_JNIEnvP8_jobjecti, %function
_ZL22AwardTapPointsCallbackP7_JNIEnvP8_jobjecti:
	.fnstart
.LFB277:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #36
	sub	sp, sp, #36
	mov	ip, #0
	str	r2, [sp, #28]
	mov	lr, #1
	mov	r1, #3
	add	r2, sp, #16
	mov	r3, #16
	ldr	r0, .L21
	str	lr, [sp, #4]
	str	ip, [sp, #12]
	str	ip, [sp, #0]
	str	ip, [sp, #8]
	bl	s3eEdkCallbacksEnqueue
	add	sp, sp, #36
	ldr	lr, [sp], #4
	bx	lr
.L22:
	.align	2
.L21:
	.word	-880042745
	.fnend
	.size	_ZL22AwardTapPointsCallbackP7_JNIEnvP8_jobjecti, .-_ZL22AwardTapPointsCallbackP7_JNIEnvP8_jobjecti
	.section	.text._ZL22SpendTapPointsCallbackP7_JNIEnvP8_jobjecti,"ax",%progbits
	.align	2
	.type	_ZL22SpendTapPointsCallbackP7_JNIEnvP8_jobjecti, %function
_ZL22SpendTapPointsCallbackP7_JNIEnvP8_jobjecti:
	.fnstart
.LFB276:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #36
	sub	sp, sp, #36
	mov	ip, #0
	str	r2, [sp, #28]
	mov	lr, #1
	mov	r1, #2
	add	r2, sp, #16
	mov	r3, #16
	ldr	r0, .L25
	str	lr, [sp, #4]
	str	ip, [sp, #12]
	str	ip, [sp, #0]
	str	ip, [sp, #8]
	bl	s3eEdkCallbacksEnqueue
	add	sp, sp, #36
	ldr	lr, [sp], #4
	bx	lr
.L26:
	.align	2
.L25:
	.word	-880042745
	.fnend
	.size	_ZL22SpendTapPointsCallbackP7_JNIEnvP8_jobjecti, .-_ZL22SpendTapPointsCallbackP7_JNIEnvP8_jobjecti
	.section	.text._ZL20GetTapPointsCallbackP7_JNIEnvP8_jobjecti,"ax",%progbits
	.align	2
	.type	_ZL20GetTapPointsCallbackP7_JNIEnvP8_jobjecti, %function
_ZL20GetTapPointsCallbackP7_JNIEnvP8_jobjecti:
	.fnstart
.LFB275:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	mov	lr, #1
	.pad #36
	sub	sp, sp, #36
	mov	ip, #0
	str	r2, [sp, #28]
	mov	r1, lr
	add	r2, sp, #16
	mov	r3, #16
	ldr	r0, .L29
	str	ip, [sp, #12]
	stmia	sp, {ip, lr}	@ phole stm
	str	ip, [sp, #8]
	bl	s3eEdkCallbacksEnqueue
	add	sp, sp, #36
	ldr	lr, [sp], #4
	bx	lr
.L30:
	.align	2
.L29:
	.word	-880042745
	.fnend
	.size	_ZL20GetTapPointsCallbackP7_JNIEnvP8_jobjecti, .-_ZL20GetTapPointsCallbackP7_JNIEnvP8_jobjecti
	.section	.text._ZL27s3eEdkAndroidFindClass_realPKc,"ax",%progbits
	.align	2
	.type	_ZL27s3eEdkAndroidFindClass_realPKc, %function
_ZL27s3eEdkAndroidFindClass_realPKc:
	.fnstart
.LFB235:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	.save {r4, lr}
	.pad #8
	sub	sp, sp, #8
	mov	r4, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	r2, #0
	str	r2, [r1, #-4]!
	mov	r3, #65536
	add	r2, r3, #2
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #24]
	mov	lr, pc
	bx	ip
	ldr	r2, [sp, #4]
	mov	r1, r4
	mov	r0, r2
	ldr	r3, [r2, #0]
	ldr	ip, [r3, #24]
	mov	lr, pc
	bx	ip
	add	sp, sp, #8
	ldmfd	sp!, {r4, lr}
	bx	lr
	.fnend
	.size	_ZL27s3eEdkAndroidFindClass_realPKc, .-_ZL27s3eEdkAndroidFindClass_realPKc
	.section	.text._Z31TapjoySetDisplayAdView_platformiiii,"ax",%progbits
	.align	2
	.global	_Z31TapjoySetDisplayAdView_platformiiii
	.hidden	_Z31TapjoySetDisplayAdView_platformiiii
	.type	_Z31TapjoySetDisplayAdView_platformiiii, %function
_Z31TapjoySetDisplayAdView_platformiiii:
	.fnstart
.LFB274:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, lr}
	.save {r4, r5, r6, r7, lr}
	.pad #28
	sub	sp, sp, #28
	mov	r4, r3
	mov	r6, r1
	mov	r5, r2
	mov	r7, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #24
	mov	r3, #0
	str	r3, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #24]
	mov	lr, pc
	bx	ip
	ldr	r3, .L35
	ldr	r0, [sp, #20]
	ldr	r2, [r3, #8]
	ldr	r1, [r3, #0]
	mov	r3, r7
	str	r6, [sp, #0]
	str	r5, [sp, #4]
	str	r4, [sp, #8]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #28
	ldmfd	sp!, {r4, r5, r6, r7, lr}
	bx	lr
.L36:
	.align	2
.L35:
	.word	.LANCHOR0
	.fnend
	.size	_Z31TapjoySetDisplayAdView_platformiiii, .-_Z31TapjoySetDisplayAdView_platformiiii
	.section	.text._Z27TapjoyGetDisplayAd_platformPKchPFiP24TapjoyGetDisplayAdResultPvES3_,"ax",%progbits
	.align	2
	.global	_Z27TapjoyGetDisplayAd_platformPKchPFiP24TapjoyGetDisplayAdResultPvES3_
	.hidden	_Z27TapjoyGetDisplayAd_platformPKchPFiP24TapjoyGetDisplayAdResultPvES3_
	.type	_Z27TapjoyGetDisplayAd_platformPKchPFiP24TapjoyGetDisplayAdResultPvES3_, %function
_Z27TapjoyGetDisplayAd_platformPKchPFiP24TapjoyGetDisplayAdResultPvES3_:
	.fnstart
.LFB273:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	.save {r4, r5, r6, lr}
	.pad #16
	sub	sp, sp, #16
	mov	r4, r1
	mov	r5, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #16
	mov	ip, #0
	str	ip, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r6, [r0, #0]
	ldr	ip, [r6, #24]
	mov	lr, pc
	bx	ip
	ldr	r6, [sp, #12]
	mov	r1, r5
	ldr	r3, [r6, #0]
	mov	r0, r6
	ldr	ip, [r3, #668]
	mov	lr, pc
	bx	ip
	ldr	r1, .L39
	mov	r3, r0
	ldr	r2, [r1, #12]
	mov	r0, r6
	ldr	r1, [r1, #0]
	str	r4, [sp, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L40:
	.align	2
.L39:
	.word	.LANCHOR0
	.fnend
	.size	_Z27TapjoyGetDisplayAd_platformPKchPFiP24TapjoyGetDisplayAdResultPvES3_, .-_Z27TapjoyGetDisplayAd_platformPKchPFiP24TapjoyGetDisplayAdResultPvES3_
	.section	.text._Z29TapjoyAwardTapPoints_platformiPFiP26TapjoyAwardTapPointsResultPvES1_,"ax",%progbits
	.align	2
	.global	_Z29TapjoyAwardTapPoints_platformiPFiP26TapjoyAwardTapPointsResultPvES1_
	.hidden	_Z29TapjoyAwardTapPoints_platformiPFiP26TapjoyAwardTapPointsResultPvES1_
	.type	_Z29TapjoyAwardTapPoints_platformiPFiP26TapjoyAwardTapPointsResultPvES1_, %function
_Z29TapjoyAwardTapPoints_platformiPFiP26TapjoyAwardTapPointsResultPvES1_:
	.fnstart
.LFB263:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	.save {r4, r5, r6, lr}
	.pad #16
	sub	sp, sp, #16
	mov	r6, r1
	mov	r5, r0
	bl	s3eEdkJNIGetVM
	mov	r4, #0
	add	r1, sp, #16
	str	r4, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r3, [r0, #0]
	ldr	ip, [r3, #24]
	mov	lr, pc
	bx	ip
	mov	r3, r6
	mov	r1, #7
	mov	r2, #3
	ldr	r0, .L43
	str	r4, [sp, #4]
	str	r4, [sp, #0]
	ldr	r4, [sp, #12]
	bl	s3eEdkCallbacksRegister
	ldr	r1, .L43+4
	mov	r0, r4
	ldr	r2, [r1, #16]
	mov	r3, r5
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L44:
	.align	2
.L43:
	.word	-880042745
	.word	.LANCHOR0
	.fnend
	.size	_Z29TapjoyAwardTapPoints_platformiPFiP26TapjoyAwardTapPointsResultPvES1_, .-_Z29TapjoyAwardTapPoints_platformiPFiP26TapjoyAwardTapPointsResultPvES1_
	.section	.text._Z29TapjoySpendTapPoints_platformiPFiP26TapjoySpendTapPointsResultPvES1_,"ax",%progbits
	.align	2
	.global	_Z29TapjoySpendTapPoints_platformiPFiP26TapjoySpendTapPointsResultPvES1_
	.hidden	_Z29TapjoySpendTapPoints_platformiPFiP26TapjoySpendTapPointsResultPvES1_
	.type	_Z29TapjoySpendTapPoints_platformiPFiP26TapjoySpendTapPointsResultPvES1_, %function
_Z29TapjoySpendTapPoints_platformiPFiP26TapjoySpendTapPointsResultPvES1_:
	.fnstart
.LFB262:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	.save {r4, r5, r6, lr}
	.pad #16
	sub	sp, sp, #16
	mov	r6, r1
	mov	r5, r0
	bl	s3eEdkJNIGetVM
	mov	r4, #0
	add	r1, sp, #16
	str	r4, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r3, [r0, #0]
	ldr	ip, [r3, #24]
	mov	lr, pc
	bx	ip
	mov	r3, r6
	mov	r1, #7
	mov	r2, #2
	ldr	r0, .L47
	str	r4, [sp, #4]
	str	r4, [sp, #0]
	ldr	r4, [sp, #12]
	bl	s3eEdkCallbacksRegister
	ldr	r1, .L47+4
	mov	r0, r4
	ldr	r2, [r1, #20]
	mov	r3, r5
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L48:
	.align	2
.L47:
	.word	-880042745
	.word	.LANCHOR0
	.fnend
	.size	_Z29TapjoySpendTapPoints_platformiPFiP26TapjoySpendTapPointsResultPvES1_, .-_Z29TapjoySpendTapPoints_platformiPFiP26TapjoySpendTapPointsResultPvES1_
	.section	.text._Z27TapjoyGetTapPoints_platformPFiP24TapjoyGetTapPointsResultPvES1_,"ax",%progbits
	.align	2
	.global	_Z27TapjoyGetTapPoints_platformPFiP24TapjoyGetTapPointsResultPvES1_
	.hidden	_Z27TapjoyGetTapPoints_platformPFiP24TapjoyGetTapPointsResultPvES1_
	.type	_Z27TapjoyGetTapPoints_platformPFiP24TapjoyGetTapPointsResultPvES1_, %function
_Z27TapjoyGetTapPoints_platformPFiP24TapjoyGetTapPointsResultPvES1_:
	.fnstart
.LFB261:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	.save {r4, r5, lr}
	.pad #20
	sub	sp, sp, #20
	mov	r5, r0
	bl	s3eEdkJNIGetVM
	mov	r4, #0
	add	r1, sp, #16
	str	r4, [r1, #-4]!
	mov	r2, #65536
	ldr	ip, [r0, #0]
	add	r2, r2, #2
	ldr	ip, [ip, #24]
	mov	lr, pc
	bx	ip
	mov	r3, r5
	mov	r1, #7
	mov	r2, #1
	ldr	r0, .L51
	str	r4, [sp, #4]
	str	r4, [sp, #0]
	ldr	r4, [sp, #12]
	bl	s3eEdkCallbacksRegister
	ldr	r3, .L51+4
	mov	r0, r4
	ldr	r2, [r3, #24]
	ldr	r1, [r3, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #20
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L52:
	.align	2
.L51:
	.word	-880042745
	.word	.LANCHOR0
	.fnend
	.size	_Z27TapjoyGetTapPoints_platformPFiP24TapjoyGetTapPointsResultPvES1_, .-_Z27TapjoyGetTapPoints_platformPFiP24TapjoyGetTapPointsResultPvES1_
	.section	.text._Z22s3eTapjoyInit_platformv,"ax",%progbits
	.align	2
	.global	_Z22s3eTapjoyInit_platformv
	.hidden	_Z22s3eTapjoyInit_platformv
	.type	_Z22s3eTapjoyInit_platformv, %function
_Z22s3eTapjoyInit_platformv:
	.fnstart
.LFB252:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	.save {r4, r5, r6, r7, r8, lr}
	.pad #56
	sub	sp, sp, #56
	bl	s3eEdkJNIGetVM
	mov	r4, #0
	add	r1, sp, #56
	str	r4, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r3, [r0, #0]
	ldr	ip, [r3, #24]
	mov	lr, pc
	bx	ip
	ldr	r0, .L60
	mov	r1, #1
	ldr	r2, .L60+4
	ldr	r4, [sp, #52]
	bl	s3eEdkThreadRunOnOS
	subs	r5, r0, #0
	beq	.L54
	ldr	r2, .L60+8
	ldr	ip, [r4, #0]
	mov	r0, r4
	mov	r1, r5
	ldr	r3, .L60+12
	ldr	ip, [ip, #132]
	mov	lr, pc
	bx	ip
	subs	r2, r0, #0
	beq	.L54
	mov	r0, r4
	mov	r1, r5
	bl	_ZN7_JNIEnv9NewObjectEP7_jclassP10_jmethodIDz
	subs	r8, r0, #0
	beq	.L55
	ldr	r6, [r4, #0]
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+16
	ldr	r3, .L60+20
	ldr	ip, [r6, #132]
	mov	lr, pc
	bx	ip
	ldr	r6, .L60+24
	cmp	r0, #0
	str	r0, [r6, #28]
	beq	.L55
	ldr	r7, [r4, #0]
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+28
	ldr	r3, .L60+20
	ldr	ip, [r7, #132]
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	str	r0, [r6, #32]
	beq	.L55
	ldr	ip, [r4, #0]
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+32
	ldr	r3, .L60+36
	ldr	ip, [ip, #132]
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	str	r0, [r6, #36]
	beq	.L55
	ldr	r7, [r4, #0]
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+40
	ldr	r3, .L60+44
	ldr	ip, [r7, #132]
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	str	r0, [r6, #40]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+48
	ldr	r3, .L60+44
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #44]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+52
	ldr	r3, .L60+20
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #48]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+56
	ldr	r3, .L60+60
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #52]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+64
	ldr	r3, .L60+20
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #24]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+68
	ldr	r3, .L60+72
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #20]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+76
	ldr	r3, .L60+72
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #16]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+80
	ldr	r3, .L60+20
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #56]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+84
	ldr	r3, .L60+88
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #60]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+92
	ldr	r3, .L60+88
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #64]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+96
	ldr	r3, .L60+20
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #4]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+100
	ldr	r3, .L60+20
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #68]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+104
	ldr	r3, .L60+72
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #72]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+108
	ldr	r3, .L60+72
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #76]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+112
	ldr	r3, .L60+44
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #80]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+116
	ldr	r3, .L60+72
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #84]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+120
	ldr	r3, .L60+60
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	cmp	r0, #0
	str	r0, [r6, #12]
	beq	.L55
	mov	r0, r4
	mov	r1, r5
	ldr	r2, .L60+124
	ldr	r3, .L60+128
	bl	_ZN7_JNIEnv11GetMethodIDEP7_jclassPKcS3_
	str	r0, [r6, #8]
	b	.L55
.L54:
	mov	r8, #0
.L55:
	ldr	r7, .L60+132
	add	ip, sp, #4
	ldmia	r7!, {r0, r1, r2, r3}
	mov	lr, ip
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	r7!, {r0, r1, r2, r3}
	mov	r6, lr
	stmia	r6!, {r0, r1, r2, r3}
	ldmia	r7, {r0, r1, r2, r3}
	stmia	r6, {r0, r1, r2, r3}
	mov	r2, ip
	mov	r1, r5
	mov	r3, #4
	ldr	r6, [r4, #0]
	mov	r0, r4
	ldr	ip, [r6, #860]
	mov	lr, pc
	bx	ip
	ldr	r1, [r4, #0]
	mov	r0, r4
	ldr	ip, [r1, #60]
	mov	lr, pc
	bx	ip
	subs	r6, r0, #0
	beq	.L56
	mov	r0, r4
	ldr	r2, [r4, #0]
	ldr	ip, [r2, #64]
	mov	lr, pc
	bx	ip
	mov	r0, r4
	ldr	r3, [r4, #0]
	ldr	ip, [r3, #68]
	mov	lr, pc
	bx	ip
	mov	r0, #1
.L57:
	add	sp, sp, #56
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L56:
	ldr	r2, [r4, #0]
	mov	r1, r8
	mov	r0, r4
	ldr	ip, [r2, #84]
	mov	lr, pc
	bx	ip
	ldr	r1, .L60+24
	str	r0, [r1, #0]
	mov	r1, r8
	mov	r0, r4
	ldr	r3, [r4, #0]
	ldr	ip, [r3, #92]
	mov	lr, pc
	bx	ip
	mov	r0, r4
	mov	r1, r5
	ldr	ip, [r4, #0]
	ldr	ip, [ip, #92]
	mov	lr, pc
	bx	ip
	mov	r0, r6
	b	.L57
.L61:
	.align	2
.L60:
	.word	_ZL27s3eEdkAndroidFindClass_realPKc
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LANCHOR0
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	.LANCHOR1
	.fnend
	.size	_Z22s3eTapjoyInit_platformv, .-_Z22s3eTapjoyInit_platformv
	.section	.text._Z34TapjoySetUserDefinedColor_platformi,"ax",%progbits
	.align	2
	.global	_Z34TapjoySetUserDefinedColor_platformi
	.hidden	_Z34TapjoySetUserDefinedColor_platformi
	.type	_Z34TapjoySetUserDefinedColor_platformi, %function
_Z34TapjoySetUserDefinedColor_platformi:
	.fnstart
.LFB272:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	.save {r4, lr}
	.pad #8
	sub	sp, sp, #8
	mov	r4, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	ip, #0
	str	ip, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r3, [r0, #0]
	ldr	ip, [r3, #24]
	mov	lr, pc
	bx	ip
	ldr	r1, .L64
	mov	r3, r4
	ldr	r2, [r1, #84]
	ldr	r0, [sp, #4]
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #8
	ldmfd	sp!, {r4, lr}
	bx	lr
.L65:
	.align	2
.L64:
	.word	.LANCHOR0
	.fnend
	.size	_Z34TapjoySetUserDefinedColor_platformi, .-_Z34TapjoySetUserDefinedColor_platformi
	.section	.text._Z35TapjoySetOffersNavBarImage_platformPKc,"ax",%progbits
	.align	2
	.global	_Z35TapjoySetOffersNavBarImage_platformPKc
	.hidden	_Z35TapjoySetOffersNavBarImage_platformPKc
	.type	_Z35TapjoySetOffersNavBarImage_platformPKc, %function
_Z35TapjoySetOffersNavBarImage_platformPKc:
	.fnstart
.LFB271:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	.save {r4, r5, lr}
	.pad #12
	sub	sp, sp, #12
	mov	r4, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	ip, #0
	str	ip, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r5, [r0, #0]
	ldr	ip, [r5, #24]
	mov	lr, pc
	bx	ip
	ldr	r5, [sp, #4]
	mov	r1, r4
	ldr	r3, [r5, #0]
	mov	r0, r5
	ldr	ip, [r3, #668]
	mov	lr, pc
	bx	ip
	ldr	r1, .L68
	mov	r3, r0
	ldr	r2, [r1, #80]
	mov	r0, r5
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L69:
	.align	2
.L68:
	.word	.LANCHOR0
	.fnend
	.size	_Z35TapjoySetOffersNavBarImage_platformPKc, .-_Z35TapjoySetOffersNavBarImage_platformPKc
	.section	.text._Z34TapjoySetTransitionEffect_platformi,"ax",%progbits
	.align	2
	.global	_Z34TapjoySetTransitionEffect_platformi
	.hidden	_Z34TapjoySetTransitionEffect_platformi
	.type	_Z34TapjoySetTransitionEffect_platformi, %function
_Z34TapjoySetTransitionEffect_platformi:
	.fnstart
.LFB270:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	.save {r4, lr}
	.pad #8
	sub	sp, sp, #8
	mov	r4, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	ip, #0
	str	ip, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r3, [r0, #0]
	ldr	ip, [r3, #24]
	mov	lr, pc
	bx	ip
	ldr	r1, .L72
	mov	r3, r4
	ldr	r2, [r1, #76]
	ldr	r0, [sp, #4]
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #8
	ldmfd	sp!, {r4, lr}
	bx	lr
.L73:
	.align	2
.L72:
	.word	.LANCHOR0
	.fnend
	.size	_Z34TapjoySetTransitionEffect_platformi, .-_Z34TapjoySetTransitionEffect_platformi
	.section	.text._Z41TapjoySetFeaturedAppDisplayCount_platformi,"ax",%progbits
	.align	2
	.global	_Z41TapjoySetFeaturedAppDisplayCount_platformi
	.hidden	_Z41TapjoySetFeaturedAppDisplayCount_platformi
	.type	_Z41TapjoySetFeaturedAppDisplayCount_platformi, %function
_Z41TapjoySetFeaturedAppDisplayCount_platformi:
	.fnstart
.LFB269:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	.save {r4, lr}
	.pad #8
	sub	sp, sp, #8
	mov	r4, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	ip, #0
	str	ip, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r3, [r0, #0]
	ldr	ip, [r3, #24]
	mov	lr, pc
	bx	ip
	ldr	r1, .L76
	mov	r3, r4
	ldr	r2, [r1, #72]
	ldr	r0, [sp, #4]
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #8
	ldmfd	sp!, {r4, lr}
	bx	lr
.L77:
	.align	2
.L76:
	.word	.LANCHOR0
	.fnend
	.size	_Z41TapjoySetFeaturedAppDisplayCount_platformi, .-_Z41TapjoySetFeaturedAppDisplayCount_platformi
	.section	.text._Z42TapjoyShowFeaturedAppFullScreenAd_platformv,"ax",%progbits
	.align	2
	.global	_Z42TapjoyShowFeaturedAppFullScreenAd_platformv
	.hidden	_Z42TapjoyShowFeaturedAppFullScreenAd_platformv
	.type	_Z42TapjoyShowFeaturedAppFullScreenAd_platformv, %function
_Z42TapjoyShowFeaturedAppFullScreenAd_platformv:
	.fnstart
.LFB268:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #12
	sub	sp, sp, #12
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	r3, #0
	str	r3, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #24]
	mov	lr, pc
	bx	ip
	ldr	r3, .L80
	ldr	r0, [sp, #4]
	ldr	r2, [r3, #68]
	ldr	r1, [r3, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #12
	ldr	lr, [sp], #4
	bx	lr
.L81:
	.align	2
.L80:
	.word	.LANCHOR0
	.fnend
	.size	_Z42TapjoyShowFeaturedAppFullScreenAd_platformv, .-_Z42TapjoyShowFeaturedAppFullScreenAd_platformv
	.section	.text._Z31TapjoyShowVirtualGoods_platformv,"ax",%progbits
	.align	2
	.global	_Z31TapjoyShowVirtualGoods_platformv
	.hidden	_Z31TapjoyShowVirtualGoods_platformv
	.type	_Z31TapjoyShowVirtualGoods_platformv, %function
_Z31TapjoyShowVirtualGoods_platformv:
	.fnstart
.LFB264:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #12
	sub	sp, sp, #12
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	r3, #0
	str	r3, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #24]
	mov	lr, pc
	bx	ip
	ldr	r3, .L84
	ldr	r0, [sp, #4]
	ldr	r2, [r3, #56]
	ldr	r1, [r3, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #12
	ldr	lr, [sp], #4
	bx	lr
.L85:
	.align	2
.L84:
	.word	.LANCHOR0
	.fnend
	.size	_Z31TapjoyShowVirtualGoods_platformv, .-_Z31TapjoyShowVirtualGoods_platformv
	.section	.text._Z38TapjoyShowOffersWithCurrenyID_platformPKch,"ax",%progbits
	.align	2
	.global	_Z38TapjoyShowOffersWithCurrenyID_platformPKch
	.hidden	_Z38TapjoyShowOffersWithCurrenyID_platformPKch
	.type	_Z38TapjoyShowOffersWithCurrenyID_platformPKch, %function
_Z38TapjoyShowOffersWithCurrenyID_platformPKch:
	.fnstart
.LFB260:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	.save {r4, r5, r6, lr}
	.pad #16
	sub	sp, sp, #16
	mov	r4, r1
	mov	r5, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #16
	mov	ip, #0
	str	ip, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r6, [r0, #0]
	ldr	ip, [r6, #24]
	mov	lr, pc
	bx	ip
	ldr	r6, [sp, #12]
	mov	r1, r5
	ldr	r3, [r6, #0]
	mov	r0, r6
	ldr	ip, [r3, #668]
	mov	lr, pc
	bx	ip
	ldr	r1, .L88
	mov	r3, r0
	ldr	r2, [r1, #52]
	mov	r0, r6
	ldr	r1, [r1, #0]
	str	r4, [sp, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L89:
	.align	2
.L88:
	.word	.LANCHOR0
	.fnend
	.size	_Z38TapjoyShowOffersWithCurrenyID_platformPKch, .-_Z38TapjoyShowOffersWithCurrenyID_platformPKch
	.section	.text._Z25TapjoyShowOffers_platformv,"ax",%progbits
	.align	2
	.global	_Z25TapjoyShowOffers_platformv
	.hidden	_Z25TapjoyShowOffers_platformv
	.type	_Z25TapjoyShowOffers_platformv, %function
_Z25TapjoyShowOffers_platformv:
	.fnstart
.LFB259:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #12
	sub	sp, sp, #12
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	r3, #0
	str	r3, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #24]
	mov	lr, pc
	bx	ip
	ldr	r3, .L92
	ldr	r0, [sp, #4]
	ldr	r2, [r3, #48]
	ldr	r1, [r3, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #12
	ldr	lr, [sp], #4
	bx	lr
.L93:
	.align	2
.L92:
	.word	.LANCHOR0
	.fnend
	.size	_Z25TapjoyShowOffers_platformv, .-_Z25TapjoyShowOffers_platformv
	.section	.text._Z24TapjoySetUserID_platformPKc,"ax",%progbits
	.align	2
	.global	_Z24TapjoySetUserID_platformPKc
	.hidden	_Z24TapjoySetUserID_platformPKc
	.type	_Z24TapjoySetUserID_platformPKc, %function
_Z24TapjoySetUserID_platformPKc:
	.fnstart
.LFB258:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	.save {r4, r5, lr}
	.pad #12
	sub	sp, sp, #12
	mov	r4, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	ip, #0
	str	ip, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r5, [r0, #0]
	ldr	ip, [r5, #24]
	mov	lr, pc
	bx	ip
	ldr	r5, [sp, #4]
	mov	r1, r4
	ldr	r3, [r5, #0]
	mov	r0, r5
	ldr	ip, [r3, #668]
	mov	lr, pc
	bx	ip
	ldr	r1, .L96
	mov	r3, r0
	ldr	r2, [r1, #44]
	mov	r0, r5
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L97:
	.align	2
.L96:
	.word	.LANCHOR0
	.fnend
	.size	_Z24TapjoySetUserID_platformPKc, .-_Z24TapjoySetUserID_platformPKc
	.section	.text._Z29TapjoyActionComplete_platformPKc,"ax",%progbits
	.align	2
	.global	_Z29TapjoyActionComplete_platformPKc
	.hidden	_Z29TapjoyActionComplete_platformPKc
	.type	_Z29TapjoyActionComplete_platformPKc, %function
_Z29TapjoyActionComplete_platformPKc:
	.fnstart
.LFB257:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	.save {r4, r5, lr}
	.pad #12
	sub	sp, sp, #12
	mov	r4, r0
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	ip, #0
	str	ip, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r5, [r0, #0]
	ldr	ip, [r5, #24]
	mov	lr, pc
	bx	ip
	ldr	r5, [sp, #4]
	mov	r1, r4
	ldr	r3, [r5, #0]
	mov	r0, r5
	ldr	ip, [r3, #668]
	mov	lr, pc
	bx	ip
	ldr	r1, .L100
	mov	r3, r0
	ldr	r2, [r1, #40]
	mov	r0, r5
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L101:
	.align	2
.L100:
	.word	.LANCHOR0
	.fnend
	.size	_Z29TapjoyActionComplete_platformPKc, .-_Z29TapjoyActionComplete_platformPKc
	.section	.text._Z29TapjoyRequestConnect_platformPKcS0_,"ax",%progbits
	.align	2
	.global	_Z29TapjoyRequestConnect_platformPKcS0_
	.hidden	_Z29TapjoyRequestConnect_platformPKcS0_
	.type	_Z29TapjoyRequestConnect_platformPKcS0_, %function
_Z29TapjoyRequestConnect_platformPKcS0_:
	.fnstart
.LFB256:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	.save {r4, r5, r6, lr}
	.pad #16
	sub	sp, sp, #16
	mov	r5, r1
	mov	r4, r0
	bl	s3eEdkJNIGetVM
	mov	r3, #0
	add	r1, sp, #16
	str	r3, [r1, #-4]!
	mov	ip, #65536
	add	r2, ip, #2
	ldr	r6, [r0, #0]
	ldr	ip, [r6, #24]
	mov	lr, pc
	bx	ip
	ldr	r6, [sp, #12]
	mov	r1, r4
	mov	r0, r6
	ldr	r4, [r6, #0]
	ldr	ip, [r4, #668]
	mov	lr, pc
	bx	ip
	mov	r1, r5
	mov	r4, r0
	ldr	r2, [r6, #0]
	mov	r0, r6
	ldr	ip, [r2, #668]
	mov	lr, pc
	bx	ip
	ldr	r3, .L104
	ldr	r2, [r3, #36]
	ldr	r1, [r3, #0]
	str	r0, [sp, #0]
	mov	r3, r4
	mov	r0, r6
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L105:
	.align	2
.L104:
	.word	.LANCHOR0
	.fnend
	.size	_Z29TapjoyRequestConnect_platformPKcS0_, .-_Z29TapjoyRequestConnect_platformPKcS0_
	.section	.text._Z28s3eTapjoyUnRegister_platform17s3eTapjoyCallbackPFiPvS0_E,"ax",%progbits
	.align	2
	.global	_Z28s3eTapjoyUnRegister_platform17s3eTapjoyCallbackPFiPvS0_E
	.hidden	_Z28s3eTapjoyUnRegister_platform17s3eTapjoyCallbackPFiPvS0_E
	.type	_Z28s3eTapjoyUnRegister_platform17s3eTapjoyCallbackPFiPvS0_E, %function
_Z28s3eTapjoyUnRegister_platform17s3eTapjoyCallbackPFiPvS0_E:
	.fnstart
.LFB255:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #12
	sub	sp, sp, #12
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	r3, #0
	str	r3, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #24]
	mov	lr, pc
	bx	ip
	ldr	r3, .L108
	ldr	r0, [sp, #4]
	ldr	r2, [r3, #32]
	ldr	r1, [r3, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #12
	ldr	lr, [sp], #4
	bx	lr
.L109:
	.align	2
.L108:
	.word	.LANCHOR0
	.fnend
	.size	_Z28s3eTapjoyUnRegister_platform17s3eTapjoyCallbackPFiPvS0_E, .-_Z28s3eTapjoyUnRegister_platform17s3eTapjoyCallbackPFiPvS0_E
	.section	.text._Z26s3eTapjoyRegister_platform17s3eTapjoyCallbackPFiPvS0_ES0_,"ax",%progbits
	.align	2
	.global	_Z26s3eTapjoyRegister_platform17s3eTapjoyCallbackPFiPvS0_ES0_
	.hidden	_Z26s3eTapjoyRegister_platform17s3eTapjoyCallbackPFiPvS0_ES0_
	.type	_Z26s3eTapjoyRegister_platform17s3eTapjoyCallbackPFiPvS0_ES0_, %function
_Z26s3eTapjoyRegister_platform17s3eTapjoyCallbackPFiPvS0_ES0_:
	.fnstart
.LFB254:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	.save {lr}
	.pad #12
	sub	sp, sp, #12
	bl	s3eEdkJNIGetVM
	add	r1, sp, #8
	mov	r3, #0
	str	r3, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	ip, [r0, #0]
	ldr	ip, [ip, #24]
	mov	lr, pc
	bx	ip
	ldr	r3, .L112
	ldr	r0, [sp, #4]
	ldr	r2, [r3, #28]
	ldr	r1, [r3, #0]
	bl	_ZN7_JNIEnv13CallIntMethodEP8_jobjectP10_jmethodIDz
	add	sp, sp, #12
	ldr	lr, [sp], #4
	bx	lr
.L113:
	.align	2
.L112:
	.word	.LANCHOR0
	.fnend
	.size	_Z26s3eTapjoyRegister_platform17s3eTapjoyCallbackPFiPvS0_ES0_, .-_Z26s3eTapjoyRegister_platform17s3eTapjoyCallbackPFiPvS0_ES0_
	.section	.text._Z31TapjoyGetAvailableItem_platformi,"ax",%progbits
	.align	2
	.global	_Z31TapjoyGetAvailableItem_platformi
	.hidden	_Z31TapjoyGetAvailableItem_platformi
	.type	_Z31TapjoyGetAvailableItem_platformi, %function
_Z31TapjoyGetAvailableItem_platformi:
	.fnstart
.LFB266:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	.save {r4, r5, lr}
	.pad #12
	sub	sp, sp, #12
	mov	r5, r0
	bl	s3eEdkJNIGetVM
	mov	r4, #0
	add	r1, sp, #8
	str	r4, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r3, [r0, #0]
	ldr	ip, [r3, #24]
	mov	lr, pc
	bx	ip
	ldr	r1, .L116
	ldr	r0, [sp, #4]
	ldr	r2, [r1, #64]
	mov	r3, r5
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz
	mov	r0, r4
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L117:
	.align	2
.L116:
	.word	.LANCHOR0
	.fnend
	.size	_Z31TapjoyGetAvailableItem_platformi, .-_Z31TapjoyGetAvailableItem_platformi
	.section	.text._Z31TapjoyGetPurchasedItem_platformi,"ax",%progbits
	.align	2
	.global	_Z31TapjoyGetPurchasedItem_platformi
	.hidden	_Z31TapjoyGetPurchasedItem_platformi
	.type	_Z31TapjoyGetPurchasedItem_platformi, %function
_Z31TapjoyGetPurchasedItem_platformi:
	.fnstart
.LFB265:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	.save {r4, r5, lr}
	.pad #12
	sub	sp, sp, #12
	mov	r5, r0
	bl	s3eEdkJNIGetVM
	mov	r4, #0
	add	r1, sp, #8
	str	r4, [r1, #-4]!
	mov	r2, #65536
	add	r2, r2, #2
	ldr	r3, [r0, #0]
	ldr	ip, [r3, #24]
	mov	lr, pc
	bx	ip
	ldr	r1, .L120
	ldr	r0, [sp, #4]
	ldr	r2, [r1, #60]
	mov	r3, r5
	ldr	r1, [r1, #0]
	bl	_ZN7_JNIEnv14CallVoidMethodEP8_jobjectP10_jmethodIDz
	mov	r0, r4
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L121:
	.align	2
.L120:
	.word	.LANCHOR0
	.fnend
	.size	_Z31TapjoyGetPurchasedItem_platformi, .-_Z31TapjoyGetPurchasedItem_platformi
	.section	.rodata
	.align	2
.LANCHOR1 = . + 0
	.type	_ZZ22s3eTapjoyInit_platformvE4C.83, %object
	.size	_ZZ22s3eTapjoyInit_platformvE4C.83, 48
_ZZ22s3eTapjoyInit_platformvE4C.83:
	.word	.LC31
	.word	.LC20
	.word	_ZL20GetTapPointsCallbackP7_JNIEnvP8_jobjecti
	.word	.LC32
	.word	.LC20
	.word	_ZL22SpendTapPointsCallbackP7_JNIEnvP8_jobjecti
	.word	.LC33
	.word	.LC20
	.word	_ZL22AwardTapPointsCallbackP7_JNIEnvP8_jobjecti
	.word	.LC34
	.word	.LC35
	.word	_ZL19FeaturedAppCallbackP7_JNIEnvP8_jobjectS2_
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"s3eTapjoy\000"
	.space	2
.LC1:
	.ascii	"<init>\000"
	.space	1
.LC2:
	.ascii	"()V\000"
.LC3:
	.ascii	"s3eTapjoyRegister\000"
	.space	2
.LC4:
	.ascii	"()I\000"
.LC5:
	.ascii	"s3eTapjoyUnRegister\000"
.LC6:
	.ascii	"TapjoyRequestConnect\000"
	.space	3
.LC7:
	.ascii	"(Ljava/lang/String;Ljava/lang/String;)I\000"
.LC8:
	.ascii	"TapjoyActionComplete\000"
	.space	3
.LC9:
	.ascii	"(Ljava/lang/String;)I\000"
	.space	2
.LC10:
	.ascii	"TapjoySetUserID\000"
.LC11:
	.ascii	"TapjoyShowOffers\000"
	.space	3
.LC12:
	.ascii	"TapjoyShowOffersWithCurrenyID\000"
	.space	2
.LC13:
	.ascii	"(Ljava/lang/String;Z)I\000"
	.space	1
.LC14:
	.ascii	"TapjoyGetTapPoints\000"
	.space	1
.LC15:
	.ascii	"TapjoySpendTapPoints\000"
	.space	3
.LC16:
	.ascii	"(I)I\000"
	.space	3
.LC17:
	.ascii	"TapjoyAwardTapPoints\000"
	.space	3
.LC18:
	.ascii	"TapjoyShowVirtualGoods\000"
	.space	1
.LC19:
	.ascii	"TapjoyGetPurchasedItem\000"
	.space	1
.LC20:
	.ascii	"(I)V\000"
	.space	3
.LC21:
	.ascii	"TapjoyGetAvailableItem\000"
	.space	1
.LC22:
	.ascii	"TapjoyGetFeaturedApp\000"
	.space	3
.LC23:
	.ascii	"TapjoyShowFeaturedAppFullScreenAd\000"
	.space	2
.LC24:
	.ascii	"TapjoySetFeaturedAppDisplayCount\000"
	.space	3
.LC25:
	.ascii	"TapjoySetTransitionEffect\000"
	.space	2
.LC26:
	.ascii	"TapjoySetOffersNavBarImage\000"
	.space	1
.LC27:
	.ascii	"TapjoySetUserDefinedColor\000"
	.space	2
.LC28:
	.ascii	"TapjoyGetDisplayAd\000"
	.space	1
.LC29:
	.ascii	"TapjoySetDisplayAdView\000"
	.space	1
.LC30:
	.ascii	"(IIII)I\000"
.LC31:
	.ascii	"GetTapPointsCallback\000"
	.space	3
.LC32:
	.ascii	"SpendTapPointsCallback\000"
	.space	1
.LC33:
	.ascii	"AwardTapPointsCallback\000"
	.space	1
.LC34:
	.ascii	"FeaturedAppCallback\000"
.LC35:
	.ascii	"(Ljava/lang/Object;)V\000"
	.bss
	.align	2
.LANCHOR0 = . + 0
	.type	_ZL5g_Obj, %object
	.size	_ZL5g_Obj, 4
_ZL5g_Obj:
	.space	4
	.type	_ZL22g_TapjoyGetFeaturedApp, %object
	.size	_ZL22g_TapjoyGetFeaturedApp, 4
_ZL22g_TapjoyGetFeaturedApp:
	.space	4
	.type	_ZL24g_TapjoySetDisplayAdView, %object
	.size	_ZL24g_TapjoySetDisplayAdView, 4
_ZL24g_TapjoySetDisplayAdView:
	.space	4
	.type	_ZL20g_TapjoyGetDisplayAd, %object
	.size	_ZL20g_TapjoyGetDisplayAd, 4
_ZL20g_TapjoyGetDisplayAd:
	.space	4
	.type	_ZL22g_TapjoyAwardTapPoints, %object
	.size	_ZL22g_TapjoyAwardTapPoints, 4
_ZL22g_TapjoyAwardTapPoints:
	.space	4
	.type	_ZL22g_TapjoySpendTapPoints, %object
	.size	_ZL22g_TapjoySpendTapPoints, 4
_ZL22g_TapjoySpendTapPoints:
	.space	4
	.type	_ZL20g_TapjoyGetTapPoints, %object
	.size	_ZL20g_TapjoyGetTapPoints, 4
_ZL20g_TapjoyGetTapPoints:
	.space	4
	.type	_ZL19g_s3eTapjoyRegister, %object
	.size	_ZL19g_s3eTapjoyRegister, 4
_ZL19g_s3eTapjoyRegister:
	.space	4
	.type	_ZL21g_s3eTapjoyUnRegister, %object
	.size	_ZL21g_s3eTapjoyUnRegister, 4
_ZL21g_s3eTapjoyUnRegister:
	.space	4
	.type	_ZL22g_TapjoyRequestConnect, %object
	.size	_ZL22g_TapjoyRequestConnect, 4
_ZL22g_TapjoyRequestConnect:
	.space	4
	.type	_ZL22g_TapjoyActionComplete, %object
	.size	_ZL22g_TapjoyActionComplete, 4
_ZL22g_TapjoyActionComplete:
	.space	4
	.type	_ZL17g_TapjoySetUserID, %object
	.size	_ZL17g_TapjoySetUserID, 4
_ZL17g_TapjoySetUserID:
	.space	4
	.type	_ZL18g_TapjoyShowOffers, %object
	.size	_ZL18g_TapjoyShowOffers, 4
_ZL18g_TapjoyShowOffers:
	.space	4
	.type	_ZL31g_TapjoyShowOffersWithCurrenyID, %object
	.size	_ZL31g_TapjoyShowOffersWithCurrenyID, 4
_ZL31g_TapjoyShowOffersWithCurrenyID:
	.space	4
	.type	_ZL24g_TapjoyShowVirtualGoods, %object
	.size	_ZL24g_TapjoyShowVirtualGoods, 4
_ZL24g_TapjoyShowVirtualGoods:
	.space	4
	.type	_ZL24g_TapjoyGetPurchasedItem, %object
	.size	_ZL24g_TapjoyGetPurchasedItem, 4
_ZL24g_TapjoyGetPurchasedItem:
	.space	4
	.type	_ZL24g_TapjoyGetAvailableItem, %object
	.size	_ZL24g_TapjoyGetAvailableItem, 4
_ZL24g_TapjoyGetAvailableItem:
	.space	4
	.type	_ZL35g_TapjoyShowFeaturedAppFullScreenAd, %object
	.size	_ZL35g_TapjoyShowFeaturedAppFullScreenAd, 4
_ZL35g_TapjoyShowFeaturedAppFullScreenAd:
	.space	4
	.type	_ZL34g_TapjoySetFeaturedAppDisplayCount, %object
	.size	_ZL34g_TapjoySetFeaturedAppDisplayCount, 4
_ZL34g_TapjoySetFeaturedAppDisplayCount:
	.space	4
	.type	_ZL27g_TapjoySetTransitionEffect, %object
	.size	_ZL27g_TapjoySetTransitionEffect, 4
_ZL27g_TapjoySetTransitionEffect:
	.space	4
	.type	_ZL28g_TapjoySetOffersNavBarImage, %object
	.size	_ZL28g_TapjoySetOffersNavBarImage, 4
_ZL28g_TapjoySetOffersNavBarImage:
	.space	4
	.type	_ZL27g_TapjoySetUserDefinedColor, %object
	.size	_ZL27g_TapjoySetUserDefinedColor, 4
_ZL27g_TapjoySetUserDefinedColor:
	.space	4
	.ident	"GCC: (Sourcery G++ Lite 2010q1-202) 4.4.1"
	.section	.note.GNU-stack,"",%progbits
