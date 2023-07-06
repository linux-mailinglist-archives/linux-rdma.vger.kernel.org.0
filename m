Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35517492FD
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jul 2023 03:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjGFBRz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 21:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjGFBRy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 21:17:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34E19AD
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 18:17:52 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso132089276.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jul 2023 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688606271; x=1691198271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLpBEWm0pyR5LDArWKNLZgik34a5WAbJKk4VIu4a3mM=;
        b=4//uKxlvWkGMHPzbfDP452dSEOLEXmN1iaJ//zX0rqP/mbDzvCG5TyTIw0DWPUERnF
         bFuiirw8RrlS3ZXoiPx8V5m2pC0/DQmoyQq6pRMgeyiiosUaxxiNJEhNVlxNVkTtjfcD
         O0HbxSwU8xJBqKqU7og1+KqIEUJ3mGr5lsE9XcRDCuzBQbMLXb7X8fhCRp1PtUEgSPxa
         98p815bY0xDraVhFBsnQipGUjeeVYLIte4Tj4mb2UHdtPIGrc/AubtmyLjTwpJ+LFftM
         WS73MxucrQDbAc0IIf+hHxzZ3cp7tBFtvv6B/uj+lOSXbnepsln4ABkuwudKSVOcQbK0
         QYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688606271; x=1691198271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLpBEWm0pyR5LDArWKNLZgik34a5WAbJKk4VIu4a3mM=;
        b=UhPaSNOAirdb5wbTos2kRV6aeY12iZZZD8suC0jfYvwY3menZWDt5DzIdqoyjjxwQE
         V1iqlAtGwlK4i3Xrr67Jm/SAdqm5EDZ2PcXyzNHGoFiNJ37gk8izx1y8k+z1T76mdbBh
         pxHazAbuqSsaaHndVuAh9LUBOGzUuG6hRIPudEpomxAWzJv25MmRX0Acq9Vmr0WnTLSS
         JyXxhedzwe6VDX5n/lTFTHRXgRiNg5ZgK4Dy/jOAzB2crbRqjUDYa1/wzj93dZHbJ/fz
         ulaTrZHX9wIkrv0BwThx1dNTUmMR6BSzqB1rpFTqakpu+l3BEyYRA8FrMYcT+yj4TSKj
         1lfQ==
X-Gm-Message-State: ABy/qLa6Z+kZqkHtyNCnyIJuXHyURjgzYe1R9TRAroUOnqg+a+O6gPNG
        mkkmHEeKh5WbnZCdwJJIpchmQP3WLNeLcZAGpTcjZg==
X-Google-Smtp-Source: APBJJlGkjwSPjge9ilAY8GDDe5IrMG3BEPPOLWt15ljhiPhs9+iYTg+xk7Xou7RlUIzPoz00OzNcF0vADrayLGJqrP8=
X-Received: by 2002:a05:6902:110:b0:c62:bdfa:57f4 with SMTP id
 o16-20020a056902011000b00c62bdfa57f4mr924315ybh.15.1688606271064; Wed, 05 Jul
 2023 18:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
 <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com> <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com> <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com> <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org> <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
In-Reply-To: <ZKNA9Pkg2vMJjHds@ziepe.ca>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 5 Jul 2023 18:17:39 -0700
Message-ID: <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 3, 2023 at 2:43=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Sun, Jul 02, 2023 at 11:22:33PM -0700, Mina Almasry wrote:
> > On Sun, Jul 2, 2023 at 9:20=E2=80=AFPM David Ahern <dsahern@kernel.org>=
 wrote:
> > >
> > > On 6/29/23 8:27 PM, Mina Almasry wrote:
> > > >
> > > > Hello Jakub, I'm looking into device memory (peer-to-peer) networki=
ng
> > > > actually, and I plan to pursue using the page pool as a front end.
> > > >
> > > > Quick description of what I have so far:
> > > > current implementation uses device memory with struct pages; I am
> > > > putting all those pages in a gen_pool, and we have written an
> > > > allocator that allocates pages from the gen_pool. In the driver, we
> > > > use this allocator instead of alloc_page() (the driver in question =
is
> > > > gve which currently doesn't use the page pool). When the driver is
> > > > done with the p2p page, it simply decrements the refcount on it and
> > > > the page is freed back to the gen_pool.
> >
> > Quick update here, I was able to get my implementation working with
> > the page pool as a front end with the memory provider API Jakub wrote
> > here:
> > https://github.com/kuba-moo/linux/tree/pp-providers
> >
> > The main complication indeed was the fact that my device memory pages
> > are ZONE_DEVICE pages, which are incompatible with the page_pool due
> > to the union in struct page. I thought of a couple of approaches to
> > resolve that.
> >
> > 1. Make my device memory pages non-ZONE_DEVICE pages.
>
> Hard no on this from a mm perspective.. We need P2P memory to be
> properly tagged and have the expected struct pages to be DMA mappable
> and otherwise, you totally break everything if you try to do this..
>
> > 2. Convert the pages from ZONE_DEVICE pages to page_pool pages and
> > vice versa as they're being inserted and removed from the page pool.
>
> This is kind of scary, it is very, very, fragile to rework the pages
> like this. Eg what happens when the owning device unplugs and needs to
> revoke these pages? I think it would likely crash..
>
> I think it also technically breaks the DMA API as we may need to look
> into the pgmap to do cache ops on some architectures.
>
> I suggest you try to work with 8k folios and then the tail page's
> struct page is empty enough to store the information you need..

Hi Jason, sorry for the late reply,

I think this could work, and the page pool already supports > order 0
allocations. It may end up being a big change to the GVE driver which
as I understand currently deals with order 0 allocations exclusively.

Another issue is that in networks with low MTU, we could be DMAing
1400/1500 bytes into each allocation, which is problematic if the
allocation is 8K+. I would need to investigate a bit to see if/how to
solve that, and we may end up having to split the page and again run
into the 'not enough room in struct page' problem.

> Or allocate per page memory and do a memdesc like thing..
>

I need to review memdesc more closely. Do you imagine I add a pointer
in struct page that points to the memdesc? Or implement a page to
memdesc mapping in the page_pool? Either approach could work. I think
the concern would be accessing the memdesc entries may be a cache miss
unacceptable in fast paths, but I think I already dereference
page->pgmap in a few places and it doesn't seem to be an issue.

> Though overall, you won't find devices creating struct pages for their
> P2P memory today, so I'm not sure what the purpose is. Jonathan
> already got highly slammed for proposing code to the kernel that was
> unusable. Please don't repeat that. Other than a special NVMe use case
> the interface for P2P is DMABUF right now and it is not struct page
> backed.
>

Our approach is actually to extend DMABUF to provide struct page
backed attachment mappings, which as far as I understand sidesteps the
issues Jonathan ran into. Our code is fully functional with any device
that supports dmabuf and in fact a lot of my tests use udmabuf to
minimize the dependencies. The RFC may come with a udmabuf selftest to
showcase that any dmabuf, even a mocked one, would be supported.

> Even if we did get to struct pages for device memory, it is highly
> likely cases you are interested in will be using larger than 4k
> folios, so page pool would need to cope with this nicely as well.
>

--
Thanks,
Mina
