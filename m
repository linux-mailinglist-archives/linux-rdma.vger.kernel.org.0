Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC3408543
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhIMHWM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 03:22:12 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:41667 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhIMHWM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Sep 2021 03:22:12 -0400
Received: by mail-vk1-f170.google.com with SMTP id g18so3022024vkq.8;
        Mon, 13 Sep 2021 00:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sa0Gb92rSOdfFNnzmGv1L64+0DeNzZyeNwu+ustj1Gw=;
        b=l2u0kJmXnwSYSPFodqVJy8qLwbQNkks+UCVlLclOKZsTBOX++P8pkwhPdWGVgCV5xV
         DbCu3F1eB3YsvBKT5CzUzJYTW776TsRpf4Uni7U+i6j6eHtOmRQjKT6D4xWz6GKapt3/
         btrzDS9d2tNzvRwnR1EzDd0Q29SZ1vC7wzUXBNMeh2pnOZjodDmXLHo4H/9nyyFbSbvc
         qsWGJJ3R39qE/VLeugPKqCC7oSGEuMBblgH14Qn+yr8dn7N0vxrRDpiXiwgVGajyVMtQ
         rcUp5fr0bHKiZmXxsr+dzUvbLxPDxNE7hCnh9akJZ5xME2RBYuYGJZdqVZloPTo9DS4k
         8CeA==
X-Gm-Message-State: AOAM5339C7Bas42b6kQjFwBBD3IeljP99GTRfrOd2VYK0XAkHKJMppn4
        rSNVqWFYMa0T6pEDhyY151pWSiApdrPPru8oG5yk0/uaVOk=
X-Google-Smtp-Source: ABdhPJwl+0wsm0ZjKRzSjXaJRF2ZV+LHRgbqlKU8XOItXXa12ME5I8OiXI/D00E9eSbOP18LxIEUKpUUVo6V097P61o=
X-Received: by 2002:a05:6122:21ab:: with SMTP id j43mr3447373vkd.19.1631517655938;
 Mon, 13 Sep 2021 00:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210913070906.1941147-1-geert@linux-m68k.org>
In-Reply-To: <20210913070906.1941147-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Sep 2021 09:20:44 +0200
Message-ID: <CAMuHMdWHDOC2WedHfgYh2nwijEsqnb3+LXgHwST29TaLugiTdA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.15-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 9:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.15-rc1[1] compared to v5.14[2].
>
> Summarized:
>   - build errors: +62/-12

>   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1859' declared with attribute error: FIELD_PREP: value too large for the field:  => 322:38
>   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1866' declared with attribute error: FIELD_PREP: value too large for the field:  => 322:38

Actual error in drivers/infiniband/hw/hns/hns_roce_hw_v2.c

arm64-gcc5.4/arm64-allmodconfig
arm64-gcc8/arm64-allmodconfig

>   + error: modpost: "__aeabi_ldivmod" [drivers/block/nbd.ko] undefined!:  => N/A
>   + error: nbd.c: undefined reference to `__aeabi_ldivmod':  => .text+0x246c), .text+0x2334)

arm-gcc4.9/imote2_defconfig
arm-gcc4.9/ep93xx_defconfig
arm-gcc4.9/colibri_pxa270_defconfig
arm-gcc4.9/ezx_defconfig
arm-gcc4.9/mini2440_defconfig
arm-gcc4.9/trizeps4_defconfig

>   + error: modpost: "__divdi3" [drivers/block/nbd.ko] undefined!:  => N/A
>   + error: nbd.c: undefined reference to `__divdi3':  => .text+0x24a0), .text+0x2458)

powerpc-gcc4.9/corenet32_smp_defconfig
powerpc-gcc4.9/mpc85xx_defconfig
powerpc-gcc4.9/ppc6xx_defconfig
mips-gcc4.9/malta_defconfig
arm-gcc4.9/iop32x_defconfig
arm-gcc4.9/s3c2410_defconfig
arm-gcc4.9/badge4_defconfig
arm-gcc4.9/footbridge_defconfig
arm-gcc4.9/jornada720_defconfig
arm-gcc4.9/lpd270_defconfig

The others are fallout of -Werror.  Still, it would be good to get them
fixed, too.

>   - build warnings: +6/-267

Amazing, we still have new build warnings ;-)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f/ (all 182 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7d2a07b769330c34b4deabeed939325c77a7ec2f/ (all 182 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
