Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E119140AB78
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 12:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhINKPB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 06:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhINKPA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 06:15:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5573C061766
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 03:13:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k4so27658771lfj.7
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ayzPNtRNfY0z+RpTkRRnA3Io/5qC6jVpVhpucCF4zt0=;
        b=z1ATTbEjr8tFhdfO4IecWUBapOPq+9+DyCj1G0yctetzU4paiFLNOec+ljEKDa0kx2
         cO1YydNOw1JiJX0ZooC10x1o0AeziWL9ty8c9WlTygXiED0mPG6ek+Q21L+mywHZTh6E
         /PZ08nVHA8rmnl3rRlQ/D6uGqyBcZyNvKZv8WJ2UT2X5LVzMvVUc+hCqGt+GKhYBNmCN
         oMj27X9hesHYz3y4Xij8LQLBgJXttBFF8nUyEUl1lruzWLn4RM63RRK0W9JC77uw0dwZ
         q9deoBs0mCiQQ9Nn0sEDSaa31lUEcctS6+Ty6qbijr1Xjh1kxxoOgWqMntTiR/ddB6iW
         l/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ayzPNtRNfY0z+RpTkRRnA3Io/5qC6jVpVhpucCF4zt0=;
        b=xOn5K65fG2oBuX5DpxkzUlw4J3pn/ut18dxzt/sm5J0/HHLYs31TRdtyLzGOpK6DN7
         E6spypeDZM4IyUVQvazttwJAxYAjq484IwSqQCk93WdtVilSEeEe826txBPAFBzTH7So
         ST+1I+MBOan68UCVL1AF6HE1GfQML+RDKsA8n4H6rbJWcUTT9NhjckE46yQ0NOupWXlq
         tuR/zLmA1dZu1kGtzO1BKzVqb/rkcU/wzukzfrx/IlIGJwu+BpbNV0bFID7Qt5hErAb7
         xcz0w4MZOcv9J8qPPP8pgOrfoUwaxbmnt7HSe8WkV1Qc+pWK7WplJUkr6Y0fO0DmzbTa
         DhKg==
X-Gm-Message-State: AOAM532Lduzdxx3bzMRxiu2C0LXAvhsG8qp61HFfSCMfnUEhvayaUum0
        KrkLP7Rc4TlNpTe+m7p2m0wALcyrpAhzddD5jcIwiw==
X-Google-Smtp-Source: ABdhPJxZFUL9W+F8+8EX8Vfmbkrh/mu7w2oQdInkBZSmCMKsMzzi/QzGXkjw12ZjRyTx39dgEXThk6bpM5XauPS5wJw=
X-Received: by 2002:a19:6b18:: with SMTP id d24mr12332496lfa.46.1631614421035;
 Tue, 14 Sep 2021 03:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org> <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org> <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
 <20210908111804.GX1200268@ziepe.ca> <1c0356f5-19cf-e883-3d96-82a87d0cffcb@amd.com>
 <CAKMK7uE=mQwgcSaTcT8U3GgCeeKOmPqS=YOqkn+SEnbbUNM1=A@mail.gmail.com>
 <20210908233354.GB3544071@ziepe.ca> <CAKMK7uHx+bDEkbg3RcwdGr9wbUgt2wx8zfx4N7G-K6d4HSY7XA@mail.gmail.com>
 <CANXvt5rYxr0xBrdbmqqKAV8ctCZaJrxEM7F0Hpt2k98wBvah7Q@mail.gmail.com>
 <CAKMK7uE8Nzq05aGcZ9kwRwwxRbgnzk=wkWNJix5WEy6pNBYQtg@mail.gmail.com>
 <CANXvt5p4H5cSR3jBFM8++TwWKP2FaaiJ4kESEvnwZdDoxXhi-w@mail.gmail.com> <CAKMK7uH0RcUOjMyS=AW7HnrKpbTvA6Z-heuQTrvLg7Dw=+cB_A@mail.gmail.com>
In-Reply-To: <CAKMK7uH0RcUOjMyS=AW7HnrKpbTvA6Z-heuQTrvLg7Dw=+cB_A@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 14 Sep 2021 19:13:29 +0900
Message-ID: <CANXvt5qNjmN7pW-ZGqzmfXDEBUbca9Ctq501kdcpkV=TpkHxFw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma device
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

2021=E5=B9=B49=E6=9C=8814=E6=97=A5(=E7=81=AB) 18:38 Daniel Vetter <daniel.v=
etter@ffwll.ch>:
>
> On Tue, Sep 14, 2021 at 9:11 AM Shunsuke Mie <mie@igel.co.jp> wrote:
> >
> > 2021=E5=B9=B49=E6=9C=8814=E6=97=A5(=E7=81=AB) 4:23 Daniel Vetter <danie=
l.vetter@ffwll.ch>:
> > >
> > > On Fri, Sep 10, 2021 at 3:46 AM Shunsuke Mie <mie@igel.co.jp> wrote:
> > > >
> > > > 2021=E5=B9=B49=E6=9C=889=E6=97=A5(=E6=9C=A8) 18:26 Daniel Vetter <d=
aniel.vetter@ffwll.ch>:
> > > > >
> > > > > On Thu, Sep 9, 2021 at 1:33 AM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
> > > > > > On Wed, Sep 08, 2021 at 09:22:37PM +0200, Daniel Vetter wrote:
> > > > > > > On Wed, Sep 8, 2021 at 3:33 PM Christian K=C3=B6nig <christia=
n.koenig@amd.com> wrote:
> > > > > > > > Am 08.09.21 um 13:18 schrieb Jason Gunthorpe:
> > > > > > > > > On Wed, Sep 08, 2021 at 05:41:39PM +0900, Shunsuke Mie wr=
ote:
> > > > > > > > >> 2021=E5=B9=B49=E6=9C=888=E6=97=A5(=E6=B0=B4) 16:20 Chris=
toph Hellwig <hch@infradead.org>:
> > > > > > > > >>> On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie =
wrote:
> > > > > > > > >>>> Thank you for your comment.
> > > > > > > > >>>>> On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mi=
e wrote:
> > > > > > > > >>>>>> To share memory space using dma-buf, a API of the dm=
a-buf requires dma
> > > > > > > > >>>>>> device, but devices such as rxe do not have a dma de=
vice. For those case,
> > > > > > > > >>>>>> change to specify a device of struct ib instead of t=
he dma device.
> > > > > > > > >>>>> So if dma-buf doesn't actually need a device to dma m=
ap why do we ever
> > > > > > > > >>>>> pass the dma_device here?  Something does not add up.
> > > > > > > > >>>> As described in the dma-buf api guide [1], the dma_dev=
ice is used by dma-buf
> > > > > > > > >>>> exporter to know the device buffer constraints of impo=
rter.
> > > > > > > > >>>> [1] https://nam11.safelinks.protection.outlook.com/?ur=
l=3Dhttps%3A%2F%2Flwn.net%2FArticles%2F489703%2F&amp;data=3D04%7C01%7Cchris=
tian.koenig%40amd.com%7C4d18470a94df4ed24c8108d972ba5591%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637666967356417448%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sd=
ata=3DARwQyo%2BCjMohaNbyREofToHIj2bndL5L0HaU9cOrYq4%3D&amp;reserved=3D0
> > > > > > > > >>> Which means for rxe you'd also have to pass the one for=
 the underlying
> > > > > > > > >>> net device.
> > > > > > > > >> I thought of that way too. In that case, the memory regi=
on is constrained by the
> > > > > > > > >> net device, but rxe driver copies data using CPU. To avo=
id the constraints, I
> > > > > > > > >> decided to use the ib device.
> > > > > > > > > Well, that is the whole problem.
> > > > > > > > >
> > > > > > > > > We can't mix the dmabuf stuff people are doing that doesn=
't fill in
> > > > > > > > > the CPU pages in the SGL with RXE - it is simply impossib=
le as things
> > > > > > > > > currently are for RXE to acess this non-struct page memor=
y.
> > > > > > > >
> > > > > > > > Yeah, agree that doesn't make much sense.
> > > > > > > >
> > > > > > > > When you want to access the data with the CPU then why do y=
ou want to
> > > > > > > > use DMA-buf in the first place?
> > > > > > > >
> > > > > > > > Please keep in mind that there is work ongoing to replace t=
he sg table
> > > > > > > > with an DMA address array and so make the underlying struct=
 page
> > > > > > > > inaccessible for importers.
> > > > > > >
> > > > > > > Also if you do have a dma-buf, you can just dma_buf_vmap() th=
e buffer
> > > > > > > for cpu access. Which intentionally does not require any devi=
ce. No
> > > > > > > idea why there's a dma_buf_attach involved. Now not all expor=
ters
> > > > > > > support this, but that's fixable, and you must call
> > > > > > > dma_buf_begin/end_cpu_access for cache management if the allo=
cation
> > > > > > > isn't cpu coherent. But it's all there, no need to apply hack=
s of
> > > > > > > allowing a wrong device or other fun things.
> > > > > >
> > > > > > Can rxe leave the vmap in place potentially forever?
> > > > >
> > > > > Yeah, it's like perma-pinning the buffer into system memory for
> > > > > non-p2p dma-buf sharing. We just squint and pretend that can't be
> > > > > abused too badly :-) On 32bit you'll run out of vmap space rather
> > > > > quickly, but that's not something anyone cares about here either.=
 We
> > > > > have a bunch of more sw modesetting drivers in drm which use
> > > > > dma_buf_vmap() like this, so it's all fine.
> > > > > -Daniel
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > http://blog.ffwll.ch
> > > >
> > > > Thanks for your comments.
> > > >
> > > > In the first place, the CMA region cannot be used for RDMA because =
the
> > > > region has no struct page. In addition, some GPU drivers use CMA an=
d share
> > > > the region as dma-buf. As a result, RDMA cannot transfer for the re=
gion. To
> > > > solve this problem, rxe dma-buf support is better I thought.
> > > >
> > > > I'll consider and redesign the rxe dma-buf support using the dma_bu=
f_vmap()
> > > > instead of the dma_buf_dynamic_attach().
> > >
> > > btw for next version please cc dri-devel. get_maintainers.pl should
> > > pick it up for these patches.
> > A CC list of these patches is generated by get_maintainers.pl but it
> > didn't pick up the dri-devel. Should I add the dri-devel to the cc
> > manually?
>
> Hm yes, on rechecking the regex doesn't match since you're not
> touching any dma-buf code directly. Or not directly enough for
> get_maintainers.pl to pick it up.
>
> DMA BUFFER SHARING FRAMEWORK
> M:    Sumit Semwal <sumit.semwal@linaro.org>
> M:    Christian K=C3=B6nig <christian.koenig@amd.com>
> L:    linux-media@vger.kernel.org
> L:    dri-devel@lists.freedesktop.org
> L:    linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> S:    Maintained
> T:    git git://anongit.freedesktop.org/drm/drm-misc
> F:    Documentation/driver-api/dma-buf.rst
> F:    drivers/dma-buf/
> F:    include/linux/*fence.h
> F:    include/linux/dma-buf*
> F:    include/linux/dma-resv.h
> K:    \bdma_(?:buf|fence|resv)\b
>
> Above is the MAINTAINERS entry that's always good to cc for anything
> related to dma_buf/fence/resv and any of these related things.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
Yes, the dma-buf was not directly included in my changes. However, this is
related to dma-buf. So I'll add the dma-buf related ML and members
to cc using
`./scripts/get_maintainer.pl -f drivers/infiniband/core/umem_dmabuf.c`.
I think it is enough to list the email addresses.

Thank you for letting me know that.

Regards,
Shunsuke,
