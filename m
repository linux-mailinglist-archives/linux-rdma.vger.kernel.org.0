Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA48E5A5EF4
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 11:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiH3JNJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 05:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3JNJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 05:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8309925D;
        Tue, 30 Aug 2022 02:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9950C615C4;
        Tue, 30 Aug 2022 09:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC02C433C1;
        Tue, 30 Aug 2022 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661850787;
        bh=F8bubcRuzeMrEHgYHWC3hGXqCd0s4CSYz++LFEj9Eqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIUsIl6mfkJSlIWc4SThl1nS8ATmzbeXEzs65MaoThS0v371lug1gIpGpx40vxEpJ
         UYD07+i0iSPJb3WgbwxoAmFbZxxhcoFnGxxjPPLJNiFO5mjtC7XqMjG4szS6qlhNYd
         /K7KbBl3bKKwc35504sjk3nMudGYzl5gqcpa6B+MZTE7p0SREuiLs+dn7V+d7BWv20
         r+fSHkYmG2ecd3q42BFQnI+NZpKFrg32XeODzCGvYNswZYpFIUpgI7/jeeowkScZNr
         tZ6Rj5/roeOyfbLWzNF7dgJ58GGrS5rP4zZ4nqtmN79v+y8RJf5evCN+F+1RvNpWGb
         HyPd7hW/h6y2w==
Date:   Tue, 30 Aug 2022 12:13:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Christoph Hellwig <hch@lst.de>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RDMA: dma-mapping: Return an unsigned int from
 ib_dma_map_sg{,_attrs}
Message-ID: <Yw3UnqZlv0Wnih7E@unreal>
References: <20220826095615.74328-1-jinpu.wang@ionos.com>
 <20220826095615.74328-3-jinpu.wang@ionos.com>
 <YwtM+/nB1F6p1Ey3@unreal>
 <CAMGffEmffkW0fHrjx84gQ6FnWuwriRUg=HSdwzU4W_sZLdiT7g@mail.gmail.com>
 <Ywyr0+b350SZrznw@unreal>
 <CAMGffE=m_Na9n-oHkxm6C2C1sC3U9LkN_7k8Xx9g9SG2ifDjrw@mail.gmail.com>
 <Yw3D7TVgkANv7PDI@unreal>
 <CAMGffEmyhXEN99_yJpiGJFOtAKGEThz=c2MLw8qbWVn70XnSdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmyhXEN99_yJpiGJFOtAKGEThz=c2MLw8qbWVn70XnSdA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 30, 2022 at 10:23:46AM +0200, Jinpu Wang wrote:
> On Tue, Aug 30, 2022 at 10:01 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Aug 29, 2022 at 03:19:14PM +0200, Jinpu Wang wrote:
> > > On Mon, Aug 29, 2022 at 2:06 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 29, 2022 at 11:40:40AM +0200, Jinpu Wang wrote:
> > > > > On Sun, Aug 28, 2022 at 1:09 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Aug 26, 2022 at 11:56:15AM +0200, Jack Wang wrote:
> > > > > > > Following 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}")
> > > > > > > change the return value of ib_dma_map_sg{,attrs} to unsigned int.
> > > > > > >
> > > > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > > > Cc: Leon Romanovsky <leon@kernel.org>
> > > > > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > > > > Cc: linux-rdma@vger.kernel.org
> > > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > >
> > > > > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > > > > ---
> > > > > > >  drivers/infiniband/core/device.c | 2 +-
> > > > > > >  include/rdma/ib_verbs.h          | 6 +++---
> > > > > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > You forgot to change ib_dma_map_sgtable_attrs() and various
> > > > > > ib_dma_map_sg*() callers.
> > > > > No, they are different.
> > > > > ib_dma_map_sgtable_attrs and dma_map_sgtable return negative on errors.
> > > >
> > > > It is not the point. You changed ib_dma_virt_map_sg() to be unsigned,
> > > > so now the following lines are not correct:
> > > >
> > > >   4138         int nents;
> > > >   4139
> > > >   4140         if (ib_uses_virt_dma(dev)) {
> > > >   4141                 nents = ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
> > > >
> > > > "int nents" should be changed to "unsigned int".
> > > >
> > > > Thanks
> > > ok, I can do it.
> > > just to check if we are on the same page:
> > > For all the callers of ib_dma_map_sg,  would it be better to fix it
> > > one patch per driver or do it in a single bigger patch.
> > > I feel it's better to do it per driver, and there are drivers from
> > > different subsystems e.g. nvme/rds/etc.
> >
> > I don't know, everything here looks not nice to me.
> >
> > After commit 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}"),
> > all callers left in limbo state where they expect that dma_map_sg{,_attrs} will return
> > upto INT_MAX. However now, the API can return upto UINT_MAX, which is not the case now
> > due to internal implementation of dma_map_sg_*(), but can be changed any second.
> >
> > Can we simply revert that commit and restore the "int" return type?
> > I don't see any benefit in having "unsigned int" if compiler doesn't enforce it.
> I feel different, the dma_map_sg api since the kernel 2.x, is
> documented in DMA-API.txt[1]:
> "
> 
> int
> dma_map_sg(struct device *dev, struct scatterlist *sg,
> int nents, enum dma_data_direction direction)
> 
> Returns: the number of physical segments mapped (this may be shorter
> than <nents> passed in if some elements of the scatter/gather list are
> physically or virtually adjacent and an IOMMU maps them with a single
> entry).
> 
> Please note that the sg cannot be mapped again if it has been mapped once.
> The mapping process is allowed to destroy information in the sg.
> 
> As with the other mapping interfaces, dma_map_sg can fail. When it
> does, 0 is returned and a driver must take appropriate action. It is
> critical that the driver do something, in the case of a block driver
> aborting the request or even oopsing is better than doing nothing and
> corrupting the filesystem.
> 
> "
> It seems the return range for dma_map_sg never returns a negative
> value. I think it's just the API
> should have been defined to return "unsigned int"  IMHO. We should
> update the documentation in the Documentation there
> too. in core-api/dma-api.rst

If you need documentation and implementation to use API, it is not best API [1].
According to Rusty's manifesto it is "2. Read the implementation and you'll get it right.".

You need to dig into the function to understand that UINT_MAX is not
possible, instead of relying on compiler that will prevent such number
if callers are not updated to be unsigned int safe.

So commit 2a047e0662ae "downgraded" API from level "3. Read the documentation and
you'll get it right." to level 2.

Thanks

[1] http://sweng.the-davies.net/Home/rustys-api-design-manifesto

> 
> 
> 
> [1] https://elixir.bootlin.com/linux/v2.6.39.4/source/Documentation/DMA-API.txt
> 
> 
> >
> > Thanks
> >
> > >
> > > Thx!
> > >
> > >
> > > >
> > > > > >
> > > > > > Thanks
> > > > > Thanks!
