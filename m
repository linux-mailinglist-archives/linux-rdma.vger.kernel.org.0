Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1C74E1A6
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 01:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjGJXDO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 19:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGJXDO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 19:03:14 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDAD11D
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 16:03:11 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-444c42f608aso1434347137.1
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689030191; x=1691622191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYDiR4A6sQZndl0XT9fcGxrXdj+op4ndy7BoHFL4s70=;
        b=FVxq5TQOlzhUeYgxXSn6ArdwnVF2hbExv8ZbNJDmV9BNzKz3GBQj6+AD6uZMvrgdjA
         xH2s5MBcoPw8P9HZMTzQhVMKFl7KLPJ/0aYueLJBRDrbwr7gSzHyFM2YiWW1icDJju+E
         vvdGR1RgvoEhOEE7I/nKR+NRqYhT3L43ky2dAfF+c8Z90UTc/eqloAdFhr/7E+KCVHK9
         hmmNiC+ql5Bd32aUQnuNmcp+0Qy7zkHQvVJSNgsTENiN4USow1G7e7mPbk+cREQGS465
         1Oh+BTqTZLre92S8DtOsIdsUe/09sJwqAJZZGaMzR0YFR5OxuiKhWVVSnovORxiSqyLX
         xwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030191; x=1691622191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYDiR4A6sQZndl0XT9fcGxrXdj+op4ndy7BoHFL4s70=;
        b=EqnoXYKAc4MSQ2mxWGctPpkinA0j2BHVcU26XyKiopoO51PlnPgZJ80gzG4YCwD8nv
         Hca9weVcW9+3EOB7coemfMiWXPOvpXQSxzA8tKF5F7JMG4OJrnXUxFiP9lb1PN4KYIFQ
         DqDNhdZTbtrAjivCyisy+blwlUpVul5O4vY9+jPCw6im6h0mYCywZWWszMYnSK+2X48v
         20FRx+QmP/9+LSmWjSGfeOV37vCbcqeFiV5OW7sEKiS306GFd9P/rgm84FTJIsT6U+Eq
         WgTpqT2UgVusX5og3iS5XQut8r96WEgnHLOhCFIpIYiT5fadd9/tyN74Qe+srKKd42/S
         5wzg==
X-Gm-Message-State: ABy/qLbxx1cQFN6PynA0+TUyWr40CqAWq8Lp1ee7sNe3pYjAPS0MP97r
        OvP8qH6DmNz1FE5OlfGUXrQibDA9NRXYCGoaetQYnQ==
X-Google-Smtp-Source: APBJJlHd8B3bLHM0BGlcUeLB7BK4Rn2fyXUPRVAiBYrDcyC69ohOF9Etzy1j0dKI2yZcDqXki7DFnPYYFtgRKmlffZ0=
X-Received: by 2002:a67:ff91:0:b0:443:8eab:c664 with SMTP id
 v17-20020a67ff91000000b004438eabc664mr5887615vsq.13.1689030190853; Mon, 10
 Jul 2023 16:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com> <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com> <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org> <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca> <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
In-Reply-To: <ZKxDZfVAbVHgNgIM@ziepe.ca>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 10 Jul 2023 16:02:59 -0700
Message-ID: <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 10, 2023 at 10:44=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Jul 05, 2023 at 06:17:39PM -0700, Mina Almasry wrote:
>
> > Another issue is that in networks with low MTU, we could be DMAing
> > 1400/1500 bytes into each allocation, which is problematic if the
> > allocation is 8K+. I would need to investigate a bit to see if/how to
> > solve that, and we may end up having to split the page and again run
> > into the 'not enough room in struct page' problem.
>
> You don't have an intree driver to use this with, so who knows, but
> the out of tree GPU drivers tend to use a 64k memory management page
> size, and I don't expect you'd make progress with a design where a 64K
> naturaly sized allocator is producing 4k/8k non-compound pages just
> for netdev. We are still struggling with pagemap support for variable
> page size folios, so there is a bunch of technical blockers before
> drivers could do this.
>
> This is why it is so important to come with a complete in-tree
> solution, as we cannot review this design if your work is done with
> hacked up out of tree drivers.
>

I think you're assuming the proposal requires dma-buf exporter driver
changes, and I have a 'hacked up out of tree driver' not visible to
you. Both are not quite right. The proposal requires no changes to the
dma-buf exporter, and works with udmabuf _as is_, proving that. Please
do review the proposal:
https://lore.kernel.org/netdev/20230710223304.1174642-1-almasrymina@google.=
com/

If you still don't like the approach, we can try something else.

> Fully and properly adding P2P ZONE_DEVICE to a real world driver is a
> pretty big ask still.
>

There is no such ask.

> > > Or allocate per page memory and do a memdesc like thing..
> >
> > I need to review memdesc more closely. Do you imagine I add a pointer
> > in struct page that points to the memdesc?
>
> Pointer to extra memory from the PFN has been the usual meaning of
> memdesc, so doing an interm where the pointer is in the struct page is
> a reasonable starting point.
>
> > > Though overall, you won't find devices creating struct pages for thei=
r
> > > P2P memory today, so I'm not sure what the purpose is. Jonathan
> > > already got highly slammed for proposing code to the kernel that was
> > > unusable. Please don't repeat that. Other than a special NVMe use cas=
e
> > > the interface for P2P is DMABUF right now and it is not struct page
> > > backed.
> > >
> >
> > Our approach is actually to extend DMABUF to provide struct page
> > backed attachment mappings, which as far as I understand sidesteps the
> > issues Jonathan ran into.
>
> No DMABUF exporters do this today, so your patch series is just as
> incomplete as the prior ones. Please don't post it as non-RFC,
> unusable code like this must not be merged.
>
> > that supports dmabuf and in fact a lot of my tests use udmabuf to
> > minimize the dependencies. The RFC may come with a udmabuf selftest to
> > showcase that any dmabuf, even a mocked one, would be supported.
>
> That is not good enough to get merged. You need to get agreement and
> coded merged from actual driver owners of dmabuf exporters that they
> want to support this direction. As above it has surprising road
> blocks outside netdev :\
>

The current proposal requires no changes to the dma-buf exporters:
https://lore.kernel.org/netdev/20230710223304.1174642-1-almasrymina@google.=
com/

On dma-buf changes required. I do need approval from the dma-buf
maintainers, but AFAICT, no approval from the dma-buf exporters (all I
need is already supported). If we need to change direction to a
proposal that needs additional support from the driver owners, yes,
we'd need their approval, but this is not the case at the moment.

--=20
Thanks,
Mina
