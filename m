Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9F7614575
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 09:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiKAIIJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKAIIH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 04:08:07 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5551834E
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 01:08:05 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:cd8a:284a:a448:1949])
        by laurent.telenet-ops.be with bizsmtp
        id ew832800N2kye1T01w84Ru; Tue, 01 Nov 2022 09:08:04 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1opmJX-002GBw-KJ; Tue, 01 Nov 2022 09:08:03 +0100
Date:   Tue, 1 Nov 2022 09:08:03 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-mips@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: Build regressions/improvements in v6.1-rc3
In-Reply-To: <20221101080246.795789-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2211010906390.538850@ramsan.of.borg>
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com> <20221101080246.795789-1-geert@linux-m68k.org>
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

On Tue, 1 Nov 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.1-rc3[1] to v6.1-rc2[3], the summaries are:
>  - build errors: +4/-0

   + /kisskb/src/arch/sh/include/asm/io.h: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]:  => 239:34

sh4-gcc11/sh-allmodconfig
cvmx_ptr_to_phys() should return physaddr_t instead (patch sent)

   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2

um-x86_64/um-all{mod,yes}config

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							     - Linus Torvalds
