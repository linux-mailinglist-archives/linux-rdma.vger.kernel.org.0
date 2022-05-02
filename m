Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5D2516B27
	for <lists+linux-rdma@lfdr.de>; Mon,  2 May 2022 09:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358362AbiEBHRy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 May 2022 03:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350633AbiEBHRx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 May 2022 03:17:53 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4821F4B848
        for <linux-rdma@vger.kernel.org>; Mon,  2 May 2022 00:14:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:194e:5782:c420:7f87])
        by andre.telenet-ops.be with bizsmtp
        id RjEK2700a28fWK501jEKBR; Mon, 02 May 2022 09:14:20 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nlQGB-002lJZ-99; Mon, 02 May 2022 09:14:19 +0200
Date:   Mon, 2 May 2022 09:14:19 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.18-rc5
In-Reply-To: <20220502065353.2658957-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2205020912140.658493@ramsan.of.borg>
References: <CAHk-=wjUhfhaes6_hMYDQFTbGjkmA-j2ZSeXZ32H66ufRfYrmQ@mail.gmail.com> <20220502065353.2658957-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 2 May 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.18-rc5[1] to v5.18-rc4[3], the summaries are:
>  - build errors: +6/-21

6 error regressions:
   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33

sh4-gcc11/se7750_defconfig
sh4-gcc11/sh-defconfig
sh4-gcc11/se7619_defconfig
sh4-gcc11/sh-allmodconfig
sh4-gcc11/sh-allyesconfig
sh4-gcc11/sh-allnoconfig

gcc-11 fallout

   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2

um-x86_64/um-all{yes,no}config

   + /kisskb/src/include/linux/sh_intc.h: error: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Werror=sizeof-pointer-div]:  => 100:63

v5.18-rc5/sh4-gcc11/se7750_defconfig
v5.18-rc5/sh4-gcc11/sh-defconfig
v5.18-rc5/sh4-gcc11/se7619_defconfig
v5.18-rc5/sh4-gcc11/sh-allmodconfig
v5.18-rc5/sh4-gcc11/sh-allyesconfig
v5.18-rc5/sh4-gcc11/sh-allnoconfig

gcc-10/11 fallout, seen before for sh4-gcc10/se7750_defconfig and sh4-gcc10/se7619_defconfig

   + {standard input}: Error: branch to a symbol in another ISA mode:  => 1295

mips-gcc11/micro32r2_defconfig
mips-gcc11/micro32r2el_defconfig

gcc-11 fallout

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/672c0c5173427e6b3e2a9bbb7be51ceeec78093a/ (all 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/af2d861d4cd2a4da5137f795ee3509e6f944a25b/ (96 out of 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
