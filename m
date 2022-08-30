Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ADA5A5DFD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 10:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiH3IYC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiH3IYB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 04:24:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FAFA3442
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 01:23:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s11so13134291edd.13
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mpUjxCyEhTu/Vrrq9HCqiAy81B12JY5DlQuis+EGEOg=;
        b=MDr2bJ1CbyLXhYi6zppIC7UWXfFIzwkollCWgwln4IgA0QGnokbrwiqTjaik/eXYT9
         856bLTwXjSTvgsZOi1zwOozPmQGGUO8jttiPMpqItLONYPV6Gf1i9AI4yKBtft7O6KSd
         eeewRUA9tWENYiQQQG8IW9a9At0QYj40f6CwI3oJXONZJ6zlGydjZgeE7x9x11QPvn4q
         U217l+gOHGobaL3lsuuhaopvPvBy0qVDXkItHchyYo49aA96dw2zPrtjUDa/5APi8ggX
         LnsjfhjkDuedFoFBpVYjqqGOgiR4LqxThE+p7Gl1hAg3vNNb28fOQS7bNaZh/eDNad73
         DF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mpUjxCyEhTu/Vrrq9HCqiAy81B12JY5DlQuis+EGEOg=;
        b=jzXQR+v/P2fkq1yM+XZgI3Ej4YtizGoTz9kMrrMW97yjniSyR2AHZZeh+kbrS/0zeX
         Vu7CdC6cfFxiyfYig1B1dLfW8ROnlt0Ea5qEEY424E9sSgc3VEIk1o2pQcX0sOIYKpEd
         leycMmB1VObFcWd5E8jaEf1wiuNv/r5uQeC3UmspOugI8qnFnGucaCSuT9mwzHOjGloz
         Ukhohm5rSiSeLEfnaxYXH+XjTuvlvL1/+mcCqwbjRqitqqMC7Owvpyvn5lVRIzq29EPc
         YzKgn5P0/+s0aLNVYOGZShhrNQzpSrzl8eSGoEADULiwcAN7XKvuZBki24SjnI6jDWNK
         CFLw==
X-Gm-Message-State: ACgBeo0Q+oiOsXBAc85z7QCS/JPnnZuJg5Z3AXpYBe8dj0IcRrhBYttg
        ei7gj+xUrs0FDNjcy8ViUCaUMLJVkIM2jbobqXdpcg==
X-Google-Smtp-Source: AA6agR5/IswRYM3PT+dPUwbiFcg/FVwCQjSZGLT2Sq2969wQy4hj2pgslkB5JCcfz/BL8HKIluLz+ycVriSnvKoEz3c=
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id
 i19-20020a05640242d300b004352c49313dmr19348314edc.86.1661847836877; Tue, 30
 Aug 2022 01:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220826095615.74328-1-jinpu.wang@ionos.com> <20220826095615.74328-3-jinpu.wang@ionos.com>
 <YwtM+/nB1F6p1Ey3@unreal> <CAMGffEmffkW0fHrjx84gQ6FnWuwriRUg=HSdwzU4W_sZLdiT7g@mail.gmail.com>
 <Ywyr0+b350SZrznw@unreal> <CAMGffE=m_Na9n-oHkxm6C2C1sC3U9LkN_7k8Xx9g9SG2ifDjrw@mail.gmail.com>
 <Yw3D7TVgkANv7PDI@unreal>
In-Reply-To: <Yw3D7TVgkANv7PDI@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 30 Aug 2022 10:23:46 +0200
Message-ID: <CAMGffEmyhXEN99_yJpiGJFOtAKGEThz=c2MLw8qbWVn70XnSdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] RDMA: dma-mapping: Return an unsigned int from ib_dma_map_sg{,_attrs}
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 30, 2022 at 10:01 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 03:19:14PM +0200, Jinpu Wang wrote:
> > On Mon, Aug 29, 2022 at 2:06 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Mon, Aug 29, 2022 at 11:40:40AM +0200, Jinpu Wang wrote:
> > > > On Sun, Aug 28, 2022 at 1:09 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Fri, Aug 26, 2022 at 11:56:15AM +0200, Jack Wang wrote:
> > > > > > Following 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}")
> > > > > > change the return value of ib_dma_map_sg{,attrs} to unsigned int.
> > > > > >
> > > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > > Cc: Leon Romanovsky <leon@kernel.org>
> > > > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > > > Cc: linux-rdma@vger.kernel.org
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > >
> > > > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > > > ---
> > > > > >  drivers/infiniband/core/device.c | 2 +-
> > > > > >  include/rdma/ib_verbs.h          | 6 +++---
> > > > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > You forgot to change ib_dma_map_sgtable_attrs() and various
> > > > > ib_dma_map_sg*() callers.
> > > > No, they are different.
> > > > ib_dma_map_sgtable_attrs and dma_map_sgtable return negative on errors.
> > >
> > > It is not the point. You changed ib_dma_virt_map_sg() to be unsigned,
> > > so now the following lines are not correct:
> > >
> > >   4138         int nents;
> > >   4139
> > >   4140         if (ib_uses_virt_dma(dev)) {
> > >   4141                 nents = ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
> > >
> > > "int nents" should be changed to "unsigned int".
> > >
> > > Thanks
> > ok, I can do it.
> > just to check if we are on the same page:
> > For all the callers of ib_dma_map_sg,  would it be better to fix it
> > one patch per driver or do it in a single bigger patch.
> > I feel it's better to do it per driver, and there are drivers from
> > different subsystems e.g. nvme/rds/etc.
>
> I don't know, everything here looks not nice to me.
>
> After commit 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}"),
> all callers left in limbo state where they expect that dma_map_sg{,_attrs} will return
> upto INT_MAX. However now, the API can return upto UINT_MAX, which is not the case now
> due to internal implementation of dma_map_sg_*(), but can be changed any second.
>
> Can we simply revert that commit and restore the "int" return type?
> I don't see any benefit in having "unsigned int" if compiler doesn't enforce it.
I feel different, the dma_map_sg api since the kernel 2.x, is
documented in DMA-API.txt[1]:
"

int
dma_map_sg(struct device *dev, struct scatterlist *sg,
int nents, enum dma_data_direction direction)

Returns: the number of physical segments mapped (this may be shorter
than <nents> passed in if some elements of the scatter/gather list are
physically or virtually adjacent and an IOMMU maps them with a single
entry).

Please note that the sg cannot be mapped again if it has been mapped once.
The mapping process is allowed to destroy information in the sg.

As with the other mapping interfaces, dma_map_sg can fail. When it
does, 0 is returned and a driver must take appropriate action. It is
critical that the driver do something, in the case of a block driver
aborting the request or even oopsing is better than doing nothing and
corrupting the filesystem.

"
It seems the return range for dma_map_sg never returns a negative
value. I think it's just the API
should have been defined to return "unsigned int"  IMHO. We should
update the documentation in the Documentation there
too. in core-api/dma-api.rst



[1] https://elixir.bootlin.com/linux/v2.6.39.4/source/Documentation/DMA-API.txt


>
> Thanks
>
> >
> > Thx!
> >
> >
> > >
> > > > >
> > > > > Thanks
> > > > Thanks!
