Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA6F577CD9
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 09:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGRHvO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 03:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiGRHvO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 03:51:14 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C654140A0
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 00:51:06 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id wXr42700L4C55Sk01Xr4Y5; Mon, 18 Jul 2022 09:51:04 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oDLWy-003z0a-0E; Mon, 18 Jul 2022 09:51:04 +0200
Date:   Mon, 18 Jul 2022 09:51:03 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-rdma@vger.kernel.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.19-rc7
In-Reply-To: <20220718074308.3801763-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2207180949260.949449@ramsan.of.borg>
References: <CAHk-=wj63HHDU0MTRVKese5a4j82g3s3u4Ztno7=7Cj=cRRFFQ@mail.gmail.com> <20220718074308.3801763-1-geert@linux-m68k.org>
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

On Mon, 18 Jul 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v5.19-rc7[1] to v5.19-rc6[3], the summaries are:
>  - build errors: +11/-6

   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'X86_VENDOR_AMD' undeclared (first use in this function):  => 149:37
   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: 'struct cpuinfo_um' has no member named 'x86_vendor':  => 149:22
   + /kisskb/src/drivers/infiniband/hw/qib/qib_wc_x86_64.c: error: control reaches end of non-void function [-Werror=return-type]:  => 150:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2

um-x86_64/um-all{mod,yes}config
(seen before in v5.18)

   + {standard input}: Error: displacement to undefined symbol .L271 overflows 12-bit field:  => 1625
   + {standard input}: Error: displacement to undefined symbol .L271 overflows 8-bit field :  => 1634
   + {standard input}: Error: displacement to undefined symbol .L318 overflows 8-bit field :  => 1665, 1681, 1711, 1693
   + {standard input}: Error: pcrel too far:  => 1657, 1667, 1629, 1685, 1649, 1655, 1635, 1698, 1618, 1644, 1695, 1705, 1676, 1673, 1670, 1660, 1686, 1656, 1702, 1672, 1700, 1609, 1632, 1684
   + {standard input}: Error: unknown opcode:  => 1713

sh4-gcc11/sh-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ff6992735ade75aae3e35d16b17da1008d753d28/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/32346491ddf24599decca06190ebca03ff9de7f8/ (all 135 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
