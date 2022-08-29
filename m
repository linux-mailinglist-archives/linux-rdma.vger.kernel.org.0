Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD495A4B92
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 14:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiH2MXr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 08:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiH2MXO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 08:23:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF871A8301;
        Mon, 29 Aug 2022 05:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E749B80DD5;
        Mon, 29 Aug 2022 12:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD369C433D6;
        Mon, 29 Aug 2022 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661774808;
        bh=r910AOmdtzWh1T2nXLlZAY+q5vomdymJKiLIiX4kBxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sufZFZ5DzLcRGkjvc6sMF8qxrF7bGVWN8CVZrBEX1dOcjQKvBCyfC7tqXEQWKPERV
         IqQ1/3VxVndXTW5AzIMHYdrmcLxkJboY7iRt7+C7EI2qsj69MtcHNrCv4ekDOfl8gP
         V2sroHLcenKcyK9NJc2wZgp60mRjpEFxHzHd74ApPiYGxNPgWM73hgfA5DzDmo2VdZ
         6sNnrYjRNHzCyxloQyU3xiXL1WO3sAt9PLhAgIHjkatSghIOWLguVeg0JuYGxtrkep
         Nw2CUr3NagEKUnpat68AYXoL2S3tFRL6Emeopu0eg2VqNdPv+ch2T5PvEOEh8gPYtI
         GU33Rdgbg9LpA==
Date:   Mon, 29 Aug 2022 15:06:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RDMA: dma-mapping: Return an unsigned int from
 ib_dma_map_sg{,_attrs}
Message-ID: <Ywyr0+b350SZrznw@unreal>
References: <20220826095615.74328-1-jinpu.wang@ionos.com>
 <20220826095615.74328-3-jinpu.wang@ionos.com>
 <YwtM+/nB1F6p1Ey3@unreal>
 <CAMGffEmffkW0fHrjx84gQ6FnWuwriRUg=HSdwzU4W_sZLdiT7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmffkW0fHrjx84gQ6FnWuwriRUg=HSdwzU4W_sZLdiT7g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 11:40:40AM +0200, Jinpu Wang wrote:
> On Sun, Aug 28, 2022 at 1:09 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Aug 26, 2022 at 11:56:15AM +0200, Jack Wang wrote:
> > > Following 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}")
> > > change the return value of ib_dma_map_sg{,attrs} to unsigned int.
> > >
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Leon Romanovsky <leon@kernel.org>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: linux-rdma@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > >
> > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > ---
> > >  drivers/infiniband/core/device.c | 2 +-
> > >  include/rdma/ib_verbs.h          | 6 +++---
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > You forgot to change ib_dma_map_sgtable_attrs() and various
> > ib_dma_map_sg*() callers.
> No, they are different.
> ib_dma_map_sgtable_attrs and dma_map_sgtable return negative on errors.

It is not the point. You changed ib_dma_virt_map_sg() to be unsigned,
so now the following lines are not correct:

  4138         int nents;
  4139
  4140         if (ib_uses_virt_dma(dev)) {
  4141                 nents = ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);

"int nents" should be changed to "unsigned int".

Thanks

> >
> > Thanks
> Thanks!
