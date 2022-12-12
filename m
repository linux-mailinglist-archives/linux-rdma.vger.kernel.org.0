Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC23649BA4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 11:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiLLKFK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 05:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiLLKEv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 05:04:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6878664E8;
        Mon, 12 Dec 2022 02:04:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0736360F3F;
        Mon, 12 Dec 2022 10:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC35AC433EF;
        Mon, 12 Dec 2022 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670839466;
        bh=ybMPHt3XK5/GwLcbilV5iJjyInjKq6N8fSXMSwjw0w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZXRm0+xMUamQOoyJMgDpKDJe/qJ1ET47c4mbaQZMUM07oID+liB5kygZNfkt+wbK
         pt1TjwGxOkx83BqzCPCHVekD09z3vXNXFZppSaDh8Blr/NNWvm1qhyD24BsLWl7oEB
         hvl7IsgGNqjKG+5IkoCdkmavvIFnCQX9PL7rk7g6AYGjQEWxTL7g2EA8klmAN3kYPO
         sQzCMFFPb2FilWf3slHAELbJeA8Q+88Gz1BMUdatCxFyw2N4FdLEnTdaB7g3Kow/bX
         aszJMbo2/J16qKfOwfXbX5uS4T50GZ4fnI8byF65cYisElDdl/l9DWHE8AQ/Dm/CZc
         kx0JIWbvSvOLA==
Date:   Mon, 12 Dec 2022 12:04:21 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-rdma@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.1
Message-ID: <Y5b8pa75a9EbCwPv@unreal>
References: <CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com>
 <20221212084219.1424746-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212120951140.5685@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212120951140.5685@ramsan.of.borg>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 12, 2022 at 09:51:55AM +0100, Geert Uytterhoeven wrote:
> On Mon, 12 Dec 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.1[1] to v6.1-rc8[3], the summaries are:
> >  - build errors: +3/-1
> 
>   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: 'struct cpuinfo_um' has no member named 'x86_cache_size':  => 88:22
>   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: control reaches end of non-void function [-Werror=return-type]:  => 89:1
>   + /kisskb/src/drivers/infiniband/sw/rdmavt/qp.c: error: implicit declaration of function '__copy_user_nocache' [-Werror=implicit-function-declaration]:  => 100:2
> 
> um-x86_64/um-all{mod,yes}config

We have a fix in rdma-next: 323a74fc20f5 ("RDMA: Disable IB HW for UML")

Thanks

> 
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/830b3c68c1fb1e9176028d02ef86f3cf76aa2476/ (all 152 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/76dcd734eca23168cb008912c0f69ff408905235/ (all 152 configs)
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
