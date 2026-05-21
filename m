Return-Path: <linux-rdma+bounces-21122-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNtKJs8aD2qeFwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21122-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:46:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0145B5A7955
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7C13268464
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB83FE364;
	Thu, 21 May 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPhEAPPX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QhDyIrrB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CD3FD130;
	Thu, 21 May 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370874; cv=none; b=KhoAE8N4zv+9Y9RK17uhXlXTEvAwY6F9ZwC0BNKPSY49srNik+0NVr09j4IGZ/8HQf+4r+5Akrwdhs6uuBoYKNoKoZImqClaLeWSeIA1CyWbc9c9Mt0lenkC1y4LG3UUl/FeZHi+RFtXurapvUpaGd5agmOcG+iXkeNoyvurkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370874; c=relaxed/simple;
	bh=YvDliQ300mLow/Wuc7hrWY/877pqDGX0o1cX95+MLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxHQMCfhguwIz2s5Mm3iSyx8Oo/oIY8JNgqJZtORcaPpImBBvvaifMqFjxO1noOyd9OdELxAvWBuHp+eD9HgQxvLc5hYnmUfipzP+AJu6cdcq4g21670+G8T0AnAcU643IGa4R40GMHnVvvIJIpuDKrCk/zEfnBMBtY/Dxb+Wj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPhEAPPX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QhDyIrrB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 May 2026 15:41:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779370870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaJqwkq2eOlywRq+nMAB2iAIu1V2LuK/QcmpmRhp1zk=;
	b=CPhEAPPXZGUZ1qcYt2wG/ANRYkqmNyJi/5IW6LpahCKvgTnsDb2mldkDVYaduhKcu/4FZp
	LAeXDB3cU1ji29bjjvSQQCyEMF6JIOEhzvUAW0hpsS0uyLMOyNwMLPLdLHc4iLl3qLJSup
	QVkHGZMUffrPhRYaxcYUQGbO8L439tfkQ8Cr8hKKTmWE9grigqSt9qCt+lW5t6MPHQPNog
	/sK5eIb34C2qIsnwRBK4VaR4eJ2mq3Zw9vfysRFzSfSB/1vYk72RuujP0RGws9JGM5REM0
	O5uAylJa3yq9SyGUcua19yabIwaNXcmy43yAjcwDIvLATXriPhlxTOQwsYW1Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779370870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaJqwkq2eOlywRq+nMAB2iAIu1V2LuK/QcmpmRhp1zk=;
	b=QhDyIrrBgjfjdLlpFMho35sdaF10Coi0xwiddy+lFVyBRkFvVMfCMQok5DQ6VzdPu5UeWu
	AfyMwCwJ+1TpF5BQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Thomas Gleixner <tglx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Li RongQing <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch
 mode during init
Message-ID: <20260521152845-11899163-df79-435c-b8c9-d3003403c6c9@linutronix.de>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com>
 <3bbcf456-322c-46f9-b238-88fb8ad227b2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3bbcf456-322c-46f9-b238-88fb8ad227b2@nvidia.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21122-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 0145B5A7955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 04:16:28PM +0300, Mark Bloch wrote:
(...)

> NIPA flagged this patch with a build_allmodconfig_warn failure:
> https://netdev-ctrl.bots.linux.dev/logs/build/1098506/14585935/build_allm=
odconfig_warn/
>=20
> I do not see how this mlx5 patch is related to the reported issue,
> but I looked into it anyway.
>=20
> After the kernel has been built once, the issue can be reproduced by reru=
nning sparse
> only on version.o, which filters out the unrelated noise. I had an older =
sparse installed,
> so I used a local copy:
>=20
> rm -f arch/x86/boot/version.o
> make V=3D1 C=3D1 CHECK=3D/labhome/mbloch/bin/sparse arch/x86/boot/version=
=2Eo
>=20
> This gives the same error reported by NIPA:
>=20
> ...
> ...
> make -f ./scripts/Makefile.vmlinux
> make -f ./scripts/Makefile.build obj=3Darch/x86/boot arch/x86/boot/bzImage
> make -f ./scripts/Makefile.build obj=3Darch/x86/boot/compressed arch/x86/=
boot/compressed/vmlinux
> # CC      arch/x86/boot/version.o
>   gcc -Wp,-MMD,arch/x86/boot/.version.o.d -nostdinc -I./arch/x86/include =
-I./arch/x86/include/generated -I./include -I./include -I./arch/x86/include=
/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/gene=
rated/uapi -include ./include/linux/compiler-version.h -include ./include/l=
inux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -std=
=3Dgnu11 -fms-extensions -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE=
_EXPORTS -Wall -Wstrict-prototypes -march=3Di386 -mregparm=3D3 -fno-strict-=
aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse -fcf-protection=3D=
none -ffreestanding -fno-stack-protector -Wno-address-of-packed-member -mpr=
eferred-stack-boundary=3D2 -D_SETUP -fno-asynchronous-unwind-tables -Wimpli=
cit-fallthrough=3D5     -DKBUILD_MODFILE=3D'"arch/x86/boot/version"' -DKBUI=
LD_BASENAME=3D'"version"' -DKBUILD_MODNAME=3D'"version"' -D__KBUILD_MODNAME=
=3Dversion -c -o arch/x86/boot/version.o arch/x86/boot/version.c
> # CHECK   arch/x86/boot/version.c
>   /labhome/mbloch/bin/sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__un=
ix__ -Wbitwise -Wno-return-void -Wno-unknown-attribute  -D__x86_64__ --arch=
=3Dx86 -mlittle-endian -m64 -Wp,-MMD,arch/x86/boot/.version.o.d -nostdinc -=
I./arch/x86/include -I./arch/x86/include/generated -I./include -I./include =
-I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/u=
api -I./include/generated/uapi -include ./include/linux/compiler-version.h =
-include ./include/linux/kconfig.h -include ./include/linux/compiler_types.=
h -D__KERNEL__ -std=3Dgnu11 -fms-extensions -m16 -g -Os -DDISABLE_BRANCH_PR=
OFILING -D__DISABLE_EXPORTS -Wall -Wstrict-prototypes -march=3Di386 -mregpa=
rm=3D3 -fno-strict-aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse=
 -fcf-protection=3Dnone -ffreestanding -fno-stack-protector -Wno-address-of=
-packed-member -mpreferred-stack-boundary=3D2 -D_SETUP -fno-asynchronous-un=
wind-tables -Wimplicit-fallthrough=3D5     -DKBUILD_MODFILE=3D'"arch/x86/bo=
ot/version"' -DKBUILD_BASENAME=3D'"version"' -DKBUILD_MODNAME=3D'"version"'=
 -D__KBUILD_MODNAME=3Dversion arch/x86/boot/version.c
> arch/x86/boot/version.c: note: in included file (through arch/x86/include=
/uapi/asm/bitsperlong.h, include/uapi/asm-generic/int-ll64.h, include/asm-g=
eneric/int-ll64.h, include/uapi/asm-generic/types.h, ...):
> ./include/asm-generic/bitsperlong.h:23:2: error: Inconsistent word size. =
Check asm/bitsperlong.h
> ./include/asm-generic/bitsperlong.h:27:33: error: static assertion failed=
: "Inconsistent word size. Check asm/bitsperlong.h"
> # cmd_gen_symversions_c arch/x86/boot/version.o
>   if nm arch/x86/boot/version.o 2>/dev/null | grep -q ' __export_symbol_'=
; then gcc -E -D__GENKSYMS__ -Wp,-MMD,arch/x86/boot/.version.o.d -nostdinc =
-I./arch/x86/include -I./arch/x86/include/generated -I./include -I./include=
 -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/=
uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h=
 -include ./include/linux/kconfig.h -include ./include/linux/compiler_types=
=2Eh -D__KERNEL__ -std=3Dgnu11 -fms-extensions -m16 -g -Os -DDISABLE_BRANCH=
_PROFILING -D__DISABLE_EXPORTS -Wall -Wstrict-prototypes -march=3Di386 -mre=
gparm=3D3 -fno-strict-aliasing -fomit-frame-pointer -fno-pic -mno-mmx -mno-=
sse -fcf-protection=3Dnone -ffreestanding -fno-stack-protector -Wno-address=
-of-packed-member -mpreferred-stack-boundary=3D2 -D_SETUP -fno-asynchronous=
-unwind-tables -Wimplicit-fallthrough=3D5     -DKBUILD_MODFILE=3D'"arch/x86=
/boot/version"' -DKBUILD_BASENAME=3D'"version"' -DKBUILD_MODNAME=3D'"versio=
n"' -D__KBUILD_MODNAME=3Dversion arch/x86/boot/version.c | ./scripts/genksy=
ms/genksyms    >> arch/x86/boot/.version.o.cmd; fi
> # LD      arch/x86/boot/setup.elf
>   ld -m elf_x86_64 -z noexecstack  -m elf_i386 -z noexecstack -T arch/x86=
/boot/setup.ld arch/x86/boot/a20.o arch/x86/boot/bioscall.o arch/x86/boot/c=
mdline.o arch/x86/boot/copy.o arch/x86/boot/cpu.o arch/x86/boot/cpuflags.o =
arch/x86/boot/cpucheck.o arch/x86/boot/early_serial_console.o arch/x86/boot=
/edd.o arch/x86/boot/header.o arch/x86/boot/main.o arch/x86/boot/memory.o a=
rch/x86/boot/pm.o arch/x86/boot/pmjump.o arch/x86/boot/printf.o arch/x86/bo=
ot/regs.o arch/x86/boot/string.o arch/x86/boot/tty.o arch/x86/boot/video.o =
arch/x86/boot/video-mode.o arch/x86/boot/version.o arch/x86/boot/video-vga.=
o arch/x86/boot/video-vesa.o arch/x86/boot/video-bios.o -o arch/x86/boot/se=
tup.elf
> # OBJCOPY arch/x86/boot/setup.bin
>   objcopy  -O binary arch/x86/boot/setup.elf arch/x86/boot/setup.bin
> # BUILD   arch/x86/boot/bzImage
>   (dd if=3Darch/x86/boot/setup.bin bs=3D4k conv=3Dsync status=3Dnone; cat=
 arch/x86/boot/vmlinux.bin) >arch/x86/boot/bzImage
> mkdir -p ./arch/x86_64/boot
> ln -fsn ../../x86/boot/bzImage ./arch/x86_64/boot/bzImage
>=20
> To me this looks like sparse is getting a conflicting set of flags.
> The command line contains both "-D__x86_64__ -m64" and "-m16 -march=3Di38=
6 -D_SETUP".
>=20
> I confirmed that the following patch "fixes" the issue, but I do not know=
 whether
> this is the right fix. This area is outside my comfort zone, so it would =
be
> helpful if someone more familiar with the x86 build/sparse flow could tak=
e a
> look:
>=20
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 3f9fb3698d66..80923864f6f9 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -71,6 +71,10 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
>=20
>  SETUP_OBJS =3D $(addprefix $(obj)/,$(setup-y))
>=20
> +realmode-checkflags-$(CONFIG_X86_64) :=3D -m32 -U__x86_64__ -D__i386__
> +REALMODE_CHECKFLAGS :=3D $(filter-out -m64 -D__x86_64__,$(CHECKFLAGS)) $=
(realmode-checkflags-y)
> +$(SETUP_OBJS): CHECKFLAGS :=3D $(REALMODE_CHECKFLAGS)
> +
>  sed-zoffset :=3D -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._st=
ub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_tex=
t\|_e\?data\|_e\?sbat\|z_.*\)$$/\#define ZO_\2 0x\1/p'
>=20
>  quiet_cmd_zoffset =3D ZOFFSET $@
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> index a0fb39abc5c8..341b0ff20c3d 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -29,6 +29,10 @@ targets      +=3D $(realmode-y)
>=20
>  REALMODE_OBJS =3D $(addprefix $(obj)/,$(realmode-y))
>=20
> +realmode-checkflags-$(CONFIG_X86_64) :=3D -m32 -U__x86_64__ -D__i386__
> +REALMODE_CHECKFLAGS :=3D $(filter-out -m64 -D__x86_64__,$(CHECKFLAGS)) $=
(realmode-checkflags-y)
> +$(REALMODE_OBJS): CHECKFLAGS :=3D $(REALMODE_CHECKFLAGS)
> +

The idea looks good, we do something similar for the 32-bit vDSO:

arch/x86/entry/vdso/vdso32/Makefile

CHECKFLAGS :=3D $(subst -m64,-m32,$(CHECKFLAGS))
CHECKFLAGS :=3D $(subst -D__x86_64__,-D__i386__,$(CHECKFLAGS))

It seems the same kind of substitution would work here.
We can add a helper function to arch/x86/Makefile and
use that also for the compat vDSO.

I am wondering why this didn't show up before.
Are you going to send a patch or should I?


Thomas

