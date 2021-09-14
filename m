Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBECC40AB05
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhINJjv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhINJjr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 05:39:47 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B7C061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 02:38:30 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso17537158otv.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7KFN+kOEbLRU1oyPcn4BCimcXnbrpcLqySWxj76DlhI=;
        b=JgVbjJ75UrN18+bBF/j8/i+LBvcB0MZGfdx4xOshFvwcMRJ9NPc6EV9engeZNVyhIC
         7QiIuvzHXu2cxIr4Wmmn6J1izEk86IRYYGJnM78xdrIx/q1g5YMhFfAvcmtyiAd59Wly
         1G3bK/DaFcn/PrCCk7VETq8KaQhk0QxAsysxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7KFN+kOEbLRU1oyPcn4BCimcXnbrpcLqySWxj76DlhI=;
        b=xf6RxXQasZxE7uXjbwtU9CWVjJVmKHZB7RrvJc1Nu1k5HbIGf5cxaor+iiORADk9B7
         xODVMJsq2k9Rp+7ARdOXXIoz/+vqXUbs33ZdmEcWFUNLjXCz4ybWsZUPn3E7M0dOCV+U
         31VD8fkSMbxJ5qDTsQn+NZe5Fjav5BQG99MiymvdpPvZysCZoYkDM1stpjC5/GEtOTcX
         84HabB8VUiQTac6Cpde0ol1oiF98UEwqbGrOiV506E7Xkq0vPQYbfxSdNOC4HWOmGdyp
         wKSzAHpMuqsbJmkwS8r/Rt3c4wGYcumCmKri4CnIgoq0bKiS7rK4u7ISHL66clttqxiT
         EhXQ==
X-Gm-Message-State: AOAM532Ex7HxdIrYUT7kvMFmxFoHBO3vQx0S5zGeiJ5mtFCFL+M2JmME
        ZQ9tQbp1mtMHFm99ufe7tHBuJ4tOb2GtzMzAY4aNrQ==
X-Google-Smtp-Source: ABdhPJwKH2tOW/CaIyEIXPAZeV5hHj6hSHYMa81lXis87njsxExJlKwCiUdBXL4uQQHYu4Zpo9i5or65E1BU2aEgrgU=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr13774657otn.239.1631612310212;
 Tue, 14 Sep 2021 02:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org> <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org> <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
 <20210908111804.GX1200268@ziepe.ca> <1c0356f5-19cf-e883-3d96-82a87d0cffcb@amd.com>
 <CAKMK7uE=mQwgcSaTcT8U3GgCeeKOmPqS=YOqkn+SEnbbUNM1=A@mail.gmail.com>
 <20210908233354.GB3544071@ziepe.ca> <CAKMK7uHx+bDEkbg3RcwdGr9wbUgt2wx8zfx4N7G-K6d4HSY7XA@mail.gmail.com>
 <CANXvt5rYxr0xBrdbmqqKAV8ctCZaJrxEM7F0Hpt2k98wBvah7Q@mail.gmail.com>
 <CAKMK7uE8Nzq05aGcZ9kwRwwxRbgnzk=wkWNJix5WEy6pNBYQtg@mail.gmail.com> <CANXvt5p4H5cSR3jBFM8++TwWKP2FaaiJ4kESEvnwZdDoxXhi-w@mail.gmail.com>
In-Reply-To: <CANXvt5p4H5cSR3jBFM8++TwWKP2FaaiJ4kESEvnwZdDoxXhi-w@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 14 Sep 2021 11:38:19 +0200
Message-ID: <CAKMK7uH0RcUOjMyS=AW7HnrKpbTvA6Z-heuQTrvLg7Dw=+cB_A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma device
To:     Shunsuke Mie <mie@igel.co.jp>
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

On Tue, Sep 14, 2021 at 9:11 AM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> 2021=E5=B9=B49=E6=9C=8814=E6=97=A5(=E7=81=AB) 4:23 Daniel Vetter <daniel.=
vetter@ffwll.ch>:
> >
> > On Fri, Sep 10, 2021 at 3:46 AM Shunsuke Mie <mie@igel.co.jp> wrote:
> > >
> > > 2021=E5=B9=B49=E6=9C=889=E6=97=A5(=E6=9C=A8) 18:26 Daniel Vetter <dan=
iel.vetter@ffwll.ch>:
> > > >
> > > > On Thu, Sep 9, 2021 at 1:33 AM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
> > > > > On Wed, Sep 08, 2021 at 09:22:37PM +0200, Daniel Vetter wrote:
> > > > > > On Wed, Sep 8, 2021 at 3:33 PM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> > > > > > > Am 08.09.21 um 13:18 schrieb Jason Gunthorpe:
> > > > > > > > On Wed, Sep 08, 2021 at 05:41:39PM +0900, Shunsuke Mie wrot=
e:
> > > > > > > >> 2021=E5=B9=B49=E6=9C=888=E6=97=A5(=E6=B0=B4) 16:20 Christo=
ph Hellwig <hch@infradead.org>:
> > > > > > > >>> On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wr=
ote:
> > > > > > > >>>> Thank you for your comment.
> > > > > > > >>>>> On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie =
wrote:
> > > > > > > >>>>>> To share memory space using dma-buf, a API of the dma-=
buf requires dma
> > > > > > > >>>>>> device, but devices such as rxe do not have a dma devi=
ce. For those case,
> > > > > > > >>>>>> change to specify a device of struct ib instead of the=
 dma device.
> > > > > > > >>>>> So if dma-buf doesn't actually need a device to dma map=
 why do we ever
> > > > > > > >>>>> pass the dma_device here?  Something does not add up.
> > > > > > > >>>> As described in the dma-buf api guide [1], the dma_devic=
e is used by dma-buf
> > > > > > > >>>> exporter to know the device buffer constraints of import=
er.
> > > > > > > >>>> [1] https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flwn.net%2FArticles%2F489703%2F&amp;data=3D04%7C01%7Cchrist=
ian.koenig%40amd.com%7C4d18470a94df4ed24c8108d972ba5591%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637666967356417448%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sda=
ta=3DARwQyo%2BCjMohaNbyREofToHIj2bndL5L0HaU9cOrYq4%3D&amp;reserved=3D0
> > > > > > > >>> Which means for rxe you'd also have to pass the one for t=
he underlying
> > > > > > > >>> net device.
> > > > > > > >> I thought of that way too. In that case, the memory region=
 is constrained by the
> > > > > > > >> net device, but rxe driver copies data using CPU. To avoid=
 the constraints, I
> > > > > > > >> decided to use the ib device.
> > > > > > > > Well, that is the whole problem.
> > > > > > > >
> > > > > > > > We can't mix the dmabuf stuff people are doing that doesn't=
 fill in
> > > > > > > > the CPU pages in the SGL with RXE - it is simply impossible=
 as things
> > > > > > > > currently are for RXE to acess this non-struct page memory.
> > > > > > >
> > > > > > > Yeah, agree that doesn't make much sense.
> > > > > > >
> > > > > > > When you want to access the data with the CPU then why do you=
 want to
> > > > > > > use DMA-buf in the first place?
> > > > > > >
> > > > > > > Please keep in mind that there is work ongoing to replace the=
 sg table
> > > > > > > with an DMA address array and so make the underlying struct p=
age
> > > > > > > inaccessible for importers.
> > > > > >
> > > > > > Also if you do have a dma-buf, you can just dma_buf_vmap() the =
buffer
> > > > > > for cpu access. Which intentionally does not require any device=
. No
> > > > > > idea why there's a dma_buf_attach involved. Now not all exporte=
rs
> > > > > > support this, but that's fixable, and you must call
> > > > > > dma_buf_begin/end_cpu_access for cache management if the alloca=
tion
> > > > > > isn't cpu coherent. But it's all there, no need to apply hacks =
of
> > > > > > allowing a wrong device or other fun things.
> > > > >
> > > > > Can rxe leave the vmap in place potentially forever?
> > > >
> > > > Yeah, it's like perma-pinning the buffer into system memory for
> > > > non-p2p dma-buf sharing. We just squint and pretend that can't be
> > > > abused too badly :-) On 32bit you'll run out of vmap space rather
> > > > quickly, but that's not something anyone cares about here either. W=
e
> > > > have a bunch of more sw modesetting drivers in drm which use
> > > > dma_buf_vmap() like this, so it's all fine.
> > > > -Daniel
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > >
> > > Thanks for your comments.
> > >
> > > In the first place, the CMA region cannot be used for RDMA because th=
e
> > > region has no struct page. In addition, some GPU drivers use CMA and =
share
> > > the region as dma-buf. As a result, RDMA cannot transfer for the regi=
on. To
> > > solve this problem, rxe dma-buf support is better I thought.
> > >
> > > I'll consider and redesign the rxe dma-buf support using the dma_buf_=
vmap()
> > > instead of the dma_buf_dynamic_attach().
> >
> > btw for next version please cc dri-devel. get_maintainers.pl should
> > pick it up for these patches.
> A CC list of these patches is generated by get_maintainers.pl but it
> didn't pick up the dri-devel. Should I add the dri-devel to the cc
> manually?

Hm yes, on rechecking the regex doesn't match since you're not
touching any dma-buf code directly. Or not directly enough for
get_maintainers.pl to pick it up.

DMA BUFFER SHARING FRAMEWORK
M:    Sumit Semwal <sumit.semwal@linaro.org>
M:    Christian K=C3=B6nig <christian.koenig@amd.com>
L:    linux-media@vger.kernel.org
L:    dri-devel@lists.freedesktop.org
L:    linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
S:    Maintained
T:    git git://anongit.freedesktop.org/drm/drm-misc
F:    Documentation/driver-api/dma-buf.rst
F:    drivers/dma-buf/
F:    include/linux/*fence.h
F:    include/linux/dma-buf*
F:    include/linux/dma-resv.h
K:    \bdma_(?:buf|fence|resv)\b

Above is the MAINTAINERS entry that's always good to cc for anything
related to dma_buf/fence/resv and any of these related things.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
