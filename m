Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560867D96F5
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 13:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbjJ0Lva (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345686AbjJ0Lv3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 07:51:29 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876FC1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 04:51:27 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-58686e94ad7so1138619eaf.3
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698407486; x=1699012286; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AY1C0MqkkPvHiCpGxH4xxQxeIQdpsKZJozzC6yq8NBA=;
        b=oZ9FalBYKjXKFH0kPlqhaHa7NpXBWM5yWrL3KaQMliHqj6FRH7UT2WRywgji5VKBtq
         XqDA+frsh1vHuQrNRLaf1tB/oCotdnQqtdXQr3pZvTSNxU1l1Rx1m8l8Z/YvkRIK2xdO
         5ToTVbPH/UKcdttTeHDmzh3IcAZgyAOXxqzpl5txBZuL2hA1oOmWgPHv8sFbm1iC9005
         qvpdE1zOaSGjEnrUIXbXhdu20+ZUxwYIjFKPsWoLJbqTgLNoy1qj5NDMDQVw2hTUsDcz
         0HjM+pob/KO0d/KXQIJiQ3bI3sjsKtsFz36aumwttZLlPdzjrEYgllFd4fL33KO3vAgT
         kN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698407486; x=1699012286;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AY1C0MqkkPvHiCpGxH4xxQxeIQdpsKZJozzC6yq8NBA=;
        b=ULw2jevE5idnmyLnq7D9EEJRvaBENS7EIFeUx4BLmmcxgbSB6lLrHi7HXnKCSDEcOD
         Lj3qPHulCx99qOhcwhITnERxNu/OnniSb6adl673F0p2yDfUR+pdO78mVw/bpS+NnwDz
         OX/kZ+exmK1lfJHvb9RQdh8oQEamNMiViaEQmcxwQD6ZbqIRlk8CW/rVxvSPL6HUNb4H
         ueP8rNMmiG0A+syGSWzZA3WeNyCsGcM+bZr2FH2ukEMwcXri0GaKkbJAkGhBrHJSYtrq
         8567YWVCUFUZ+w5OWKXaUsPKnBDmLWsTp7hu88NzmlgwpbjtDqq5ppuJDPRjZcpm9Onu
         SOkA==
X-Gm-Message-State: AOJu0YxjziwRHm3tF7gO3ueDxcnkhfjJOfsX8Z/HLE2y2ktd0b+yl0FZ
        TCuzkD5heLp0r9Mlr6q83F8mFQ==
X-Google-Smtp-Source: AGHT+IFRGRlTjC6nUfy+ywDwWs3p7RlvHENvyRVZQQ98md/Y+ECf0m3kaD5tHeWWYlNDD1Hjzpkbow==
X-Received: by 2002:a4a:bc81:0:b0:57d:e5e7:6d00 with SMTP id m1-20020a4abc81000000b0057de5e76d00mr2586465oop.6.1698407486494;
        Fri, 27 Oct 2023 04:51:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id w12-20020a4aa98c000000b0057b6d8e51ddsm312955oom.40.2023.10.27.04.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:51:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qwLN6-005cSE-G4;
        Fri, 27 Oct 2023 08:51:24 -0300
Date:   Fri, 27 Oct 2023 08:51:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Message-ID: <20231027115124.GB691768@ziepe.ca>
References: <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
 <20231026114221.GT691768@ziepe.ca>
 <2374eb54-6a7e-4a56-b7e9-3aa5c9048fa1@linux.dev>
 <20231026232327.GZ691768@ziepe.ca>
 <2330d7dc-d17d-45d5-a162-f8f95c24c051@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2330d7dc-d17d-45d5-a162-f8f95c24c051@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 27, 2023 at 12:01:47PM +0800, Zhu Yanjun wrote:
> 
> 在 2023/10/27 7:23, Jason Gunthorpe 写道:
> > On Thu, Oct 26, 2023 at 08:59:34PM +0800, Zhu Yanjun wrote:
> > > 在 2023/10/26 19:42, Jason Gunthorpe 写道:
> > > > On Thu, Oct 26, 2023 at 09:05:52AM +0000, Zhijian Li (Fujitsu) wrote:
> > > > > The root cause is that
> > > > > 
> > > > > rxe:rxe_set_page() gets wrong when mr.page_size != PAGE_SIZE where it only stores the *page to xarray.
> > > > > So the offset will get lost.
> > > > > 
> > > > > For example,
> > > > > store process:
> > > > > page_size = 0x1000;
> > > > > PAGE_SIZE = 0x10000;
> > > > > va0 = 0xffff000020651000;
> > > > > page_offset = 0 = va & (page_size - 1);
> > > > > page = va_to_page(va);
> > > > > xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL);
> > > > > 
> > > > > load_process:
> > > > > page = xa_load(&mr->page_list, index);
> > > > > page_va = kmap_local_page(page) --> it must be a PAGE_SIZE align value, assume it as 0xffff000020650000
> > > > > va1 = page_va + page_offset = 0xffff000020650000 + 0 = 0xffff000020650000;
> > > > > 
> > > > > Obviously, *va0 != va1*, page_offset get lost.
> > > > > 
> > > > > 
> > > > > How to fix:
> > > > > - revert 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c")
> > > > > - don't allow ulp registering mr.page_size != PAGE_SIZE ?
> > > > Lets do the second one please. Most devices only support PAGE_SIZE anyhow.
> > > Normally page_size is PAGE_SIZE or the size of the whole compound page (in
> > > the latest kernel version, it is the size of folio). When compound page or
> > > folio is taken into account, the page_size is not equal to
> > > PAGE_SIZE.
> > folios are always multiples of PAGE_SIZE. rxe splits everything into
> > PAGE_SIZE units in the xarray.
> > 
> > > If the ULP uses the compound page or folio, the similar problem will occur
> > > again.
> > No, it won't. We never store folios in the xarray.
> 
> Sure.
> 
> I mean, in ULP, if folio is used, the page size is set to multiple
> PAGE_SIZE, but in RXE, the page size is set to PAGE_SIZE.
> 
> So the page size in ULP is different with the page size in RXE.

There is no such thing as a "page size" in the ULP. rxe is the thing
that keeps things in PAGE_SIZE units, and it should be fragmenting
whatever the ulp gives into that. The ULP must simply give virtually
contiguous runs of memory that are PAGE_SIZE aligned

Jason
