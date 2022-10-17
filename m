Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A086012B2
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Oct 2022 17:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJQP0J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Oct 2022 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJQP0I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Oct 2022 11:26:08 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C34558EF
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 08:26:02 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:bdc5:2f22:6678:ef3])
        by andre.telenet-ops.be with bizsmtp
        id Z3Rx2800j0MC6vi013RxB9; Mon, 17 Oct 2022 17:26:00 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1okS00-0002Vj-S9; Mon, 17 Oct 2022 17:25:52 +0200
Date:   Mon, 17 Oct 2022 17:25:52 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     D Scott Phillips <scott@os.amperecomputing.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-um@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.1-rc1
In-Reply-To: <20221017145157.1866351-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2210171653540.9136@ramsan.of.borg>
References: <20221017145157.1866351-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 17 Oct 2022, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.1-rc1[1] compared to v6.0[2].
>
> Summarized:
>  - build errors: +25/-13

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9abf2313adc1ca1b6180c508c25f22f9395cc780/ (all 149 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4fe89d07dcc2804c8b562f6c7896a45643d34b2f/ (135 out of 149 configs)
>
>
> *** ERRORS ***
>
> 25 error regressions:
>  + /kisskb/src/arch/arm64/include/asm/cputype.h: error: initializer element is not constant:  => 44:2

arm64-gcc5/arm64-allmodconfig (arch/arm64/kernel/proton-pack.c:872)

>  + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer:  => 94:18
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1934:1
>  + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function):  => 149:37
>  + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor':  => 149:22
>  + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]:  => 150:1
>  + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
>  + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
>  + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2

um-x86_64/um-all{mod,yes}config

>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: error: array subscript is above array bounds [-Werror=array-bounds]:  => 531:55

arm64-gcc5/arm64-allmodconfig
mipsel-gcc5/mips-allmodconfig
powerpc-gcc5/powerpc-all{mod,yes}config
powerpc-gcc5/ppc32_allmodconfig
powerpc-gcc5/ppc64_book3e_allmodconfig
powerpc-gcc5/ppc64le_allmodconfig
sparc64-gcc5/sparc64-allmodconfig

>  + error: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>  + error: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>  + error: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>  + error: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>  + error: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>  + error: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>  + error: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>  + error: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!:  => N/A

sparc64-gcc5/sparc-allmodconfig

>  + error: modpost: "riscv_cbom_block_size" [arch/riscv/kvm/kvm.ko] undefined!:  => N/A

riscv-gcc11/riscv-defconfig
riscv-gcc11/rv32_defconfig

>  + {standard input}: Error: branch to a symbol in another ISA mode: 1339 => 2616, 2621

mips-gcc11/micro32r2_defconfig
mips-gcc11/micro32r2el_defconfig

>  + {standard input}: Error: displacement to undefined symbol .L377 overflows 12-bit field:  => 2286
>  + {standard input}: Error: displacement to undefined symbol .L378 overflows 8-bit field :  => 2302
>  + {standard input}: Error: displacement to undefined symbol .L382 overflows 8-bit field :  => 2213
>  + {standard input}: Error: pcrel too far:  => 2247, 2261, 2232, 2231, 2262, 2216, 2204, 2248, 2274, 2293, 2217, 2206, 2221, 2229, 2209, 2249, 2259, 2215
>  + {standard input}: Error: unknown pseudo-op: `.l':  => 2305

sh4-gcc11/sh-all{mod,yes}config (ICE in drivers/net/pcs/pcs-xpcs.o)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
