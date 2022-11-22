Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C878633A9E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 11:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiKVK4i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 05:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiKVK4h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 05:56:37 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBFE2AC73
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 02:56:35 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by albert.telenet-ops.be with bizsmtp
        id nNwZ2800A5WXlCv06NwZjj; Tue, 22 Nov 2022 11:56:33 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oxQx6-001C3A-OH; Tue, 22 Nov 2022 11:56:32 +0100
Date:   Tue, 22 Nov 2022 11:56:32 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-staging@lists.linux.dev, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: Build regressions/improvements in v6.1-rc6
In-Reply-To: <20221122105054.4062213-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2211221154280.284524@ramsan.of.borg>
References: <CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com> <20221122105054.4062213-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 22 Nov 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.1-rc6[1] to v6.1-rc5[3], the summaries are:
>  - build errors: +6/-0

   + /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]:  => 239:34

sh4-gcc11/sh-allmodconfig (in cvm_oct_free_hw_memory())

   + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer:  => 94:18
   + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1934:1

um-x86_64/um-all{mod,yes}config (in kfd_cpumask_to_apic_id())

   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function):  => 149:37
   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor':  => 149:22
   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]:  => 150:1

um-x86_64/um-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/eb7081409f94a9a8608593d0fb63a1aa3d6f95d8/ (all 149 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/094226ad94f471a9f19e8f8e7140a09c2625abaa/ (all 149 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
