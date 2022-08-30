Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F565A5D94
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 10:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiH3IB7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiH3IB5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 04:01:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF19D11F;
        Tue, 30 Aug 2022 01:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94303B81629;
        Tue, 30 Aug 2022 08:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20E3C433D6;
        Tue, 30 Aug 2022 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661846513;
        bh=ht4Zb7xny/jU85fv7zKRsCxM3zyAR48FezEpPUUfMrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0lqN22g0FEIFVPmdUDewu7idrLTy5lvQq1ak0rhRTi1K5PV4hH0Se+i8+pKPeynW
         kGSlcn0/mSos+bwADVsjUVgE3F1znICkDnst2LdAvMtcpeG6ZpXhERqNiBNHd8lkE1
         XjjrytdP2vNgPjhxTZf7A8Pzhhh+7O+vum6rEmYmpe0STVoNGkCJkuNjtzFBvQl4p1
         03zVuveOwu0+kIVIK5waxr1t8Ny3BRNOM9Losl+l8MUmD9Gj3VK4HqjDEB5ySWFO9E
         iqmtPoYEZSUyltFzMGI97om3L6OMADoGHqLE7uGkBe8XZVawJG/zFIPLCEEBf8W5Mj
         71Id5ok+Awg0Q==
Date:   Tue, 30 Aug 2022 11:01:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>, Christoph Hellwig <hch@lst.de>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RDMA: dma-mapping: Return an unsigned int from
 ib_dma_map_sg{,_attrs}
Message-ID: <Yw3D7TVgkANv7PDI@unreal>
References: <20220826095615.74328-1-jinpu.wang@ionos.com>
 <20220826095615.74328-3-jinpu.wang@ionos.com>
 <YwtM+/nB1F6p1Ey3@unreal>
 <CAMGffEmffkW0fHrjx84gQ6FnWuwriRUg=HSdwzU4W_sZLdiT7g@mail.gmail.com>
 <Ywyr0+b350SZrznw@unreal>
 <CAMGffE=m_Na9n-oHkxm6C2C1sC3U9LkN_7k8Xx9g9SG2ifDjrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=m_Na9n-oHkxm6C2C1sC3U9LkN_7k8Xx9g9SG2ifDjrw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 03:19:14PM +0200, Jinpu Wang wrote:
> On Mon, Aug 29, 2022 at 2:06 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Aug 29, 2022 at 11:40:40AM +0200, Jinpu Wang wrote:
> > > On Sun, Aug 28, 2022 at 1:09 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Fri, Aug 26, 2022 at 11:56:15AM +0200, Jack Wang wrote:
> > > > > Following 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}")
> > > > > change the return value of ib_dma_map_sg{,attrs} to unsigned int.
> > > > >
> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Cc: Leon Romanovsky <leon@kernel.org>
> > > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > > Cc: linux-rdma@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > >
> > > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > > ---
> > > > >  drivers/infiniband/core/device.c | 2 +-
> > > > >  include/rdma/ib_verbs.h          | 6 +++---
> > > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > You forgot to change ib_dma_map_sgtable_attrs() and various
> > > > ib_dma_map_sg*() callers.
> > > No, they are different.
> > > ib_dma_map_sgtable_attrs and dma_map_sgtable return negative on errors.
> >
> > It is not the point. You changed ib_dma_virt_map_sg() to be unsigned,
> > so now the following lines are not correct:
> >
> >   4138         int nents;
> >   4139
> >   4140         if (ib_uses_virt_dma(dev)) {
> >   4141                 nents = ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
> >
> > "int nents" should be changed to "unsigned int".
> >
> > Thanks
> ok, I can do it.
> just to check if we are on the same page:
> For all the callers of ib_dma_map_sg,  would it be better to fix it
> one patch per driver or do it in a single bigger patch.
> I feel it's better to do it per driver, and there are drivers from
> different subsystems e.g. nvme/rds/etc.

I don't know, everything here looks not nice to me.

After commit 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}"),
all callers left in limbo state where they expect that dma_map_sg{,_attrs} will return
upto INT_MAX. However now, the API can return upto UINT_MAX, which is not the case now
due to internal implementation of dma_map_sg_*(), but can be changed any second.

Can we simply revert that commit and restore the "int" return type?
I don't see any benefit in having "unsigned int" if compiler doesn't enforce it.

Thanks

> 
> Thx!
> 
> 
> >
> > > >
> > > > Thanks
> > > Thanks!
