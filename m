Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66A6409CD8
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 21:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhIMTYW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbhIMTYW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Sep 2021 15:24:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18368C061574
        for <linux-rdma@vger.kernel.org>; Mon, 13 Sep 2021 12:23:06 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso14846134otp.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Sep 2021 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HM9AKRoKfSfRGazDVWKMB6T2NDUKs9/EKkIlbsQJ7Uc=;
        b=ioWH9sjMHm4OXe5UAs73f2LzwqRWvK9JxD6WiCECAdV3XprxcdW/wQnRz533DERIl1
         85ZarTVYpTnl9FPafYaUA6fdao4BXI9Npld6i4E5KeOJitA3beUpuZZVW9S9QhlDVznl
         GylgeAgD8eqGBjYSRJaorOustTRLS7dZESJ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HM9AKRoKfSfRGazDVWKMB6T2NDUKs9/EKkIlbsQJ7Uc=;
        b=w79g3Uv0v/n4b7IIT6b69dCpuFkQIaXIr/7mYwFwtN5eqSSQGZGO9+UjCWRkV8U3g9
         QWp3w81DentxNDiTO+60O8qNjRsQOdixoc3uH0T1wCWOYCYJ71GaSEZfpQgwvWi+/PcK
         VcGEw6vu01+azcjJNhXivGGorfJMMlZ9sKV25llIW94z9nCfw+KoIqHH9+NqP/byEkOr
         e5T53sNcpsfSZG/C9EaWHCJoZGt7vBM/cu/pmPVb3LMaUV3tvfu/H+YdiMg4EbRUWeGK
         pL45fu0jx1YQf1LEToO7a3C5Bwj6kX4SvN1eYbd9IHtgaMDteuMxx/iEQhDHfEt44YdD
         cn0w==
X-Gm-Message-State: AOAM532UCZB95WERt1UP01HTqlFcGYCVx+kGSoBLmoRskXgK6lHfSGzm
        7BhVlZSL001BANjR+PKUpfCNBW9NqQdMju94oXw2Ew==
X-Google-Smtp-Source: ABdhPJzJJ+HXbYNN/0PInzD9aks0RVdXOwP76gs0t7dexNr22OnKSIuKOElaNBTiySCY6petac/kNlvfEKGPvQvxg2Q=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr11052955otn.239.1631560983868;
 Mon, 13 Sep 2021 12:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org> <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org> <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
 <20210908111804.GX1200268@ziepe.ca> <1c0356f5-19cf-e883-3d96-82a87d0cffcb@amd.com>
 <CAKMK7uE=mQwgcSaTcT8U3GgCeeKOmPqS=YOqkn+SEnbbUNM1=A@mail.gmail.com>
 <20210908233354.GB3544071@ziepe.ca> <CAKMK7uHx+bDEkbg3RcwdGr9wbUgt2wx8zfx4N7G-K6d4HSY7XA@mail.gmail.com>
 <CANXvt5rYxr0xBrdbmqqKAV8ctCZaJrxEM7F0Hpt2k98wBvah7Q@mail.gmail.com>
In-Reply-To: <CANXvt5rYxr0xBrdbmqqKAV8ctCZaJrxEM7F0Hpt2k98wBvah7Q@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 13 Sep 2021 21:22:52 +0200
Message-ID: <CAKMK7uE8Nzq05aGcZ9kwRwwxRbgnzk=wkWNJix5WEy6pNBYQtg@mail.gmail.com>
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

On Fri, Sep 10, 2021 at 3:46 AM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> 2021=E5=B9=B49=E6=9C=889=E6=97=A5(=E6=9C=A8) 18:26 Daniel Vetter <daniel.=
vetter@ffwll.ch>:
> >
> > On Thu, Sep 9, 2021 at 1:33 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Wed, Sep 08, 2021 at 09:22:37PM +0200, Daniel Vetter wrote:
> > > > On Wed, Sep 8, 2021 at 3:33 PM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
> > > > > Am 08.09.21 um 13:18 schrieb Jason Gunthorpe:
> > > > > > On Wed, Sep 08, 2021 at 05:41:39PM +0900, Shunsuke Mie wrote:
> > > > > >> 2021=E5=B9=B49=E6=9C=888=E6=97=A5(=E6=B0=B4) 16:20 Christoph H=
ellwig <hch@infradead.org>:
> > > > > >>> On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wrote:
> > > > > >>>> Thank you for your comment.
> > > > > >>>>> On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrot=
e:
> > > > > >>>>>> To share memory space using dma-buf, a API of the dma-buf =
requires dma
> > > > > >>>>>> device, but devices such as rxe do not have a dma device. =
For those case,
> > > > > >>>>>> change to specify a device of struct ib instead of the dma=
 device.
> > > > > >>>>> So if dma-buf doesn't actually need a device to dma map why=
 do we ever
> > > > > >>>>> pass the dma_device here?  Something does not add up.
> > > > > >>>> As described in the dma-buf api guide [1], the dma_device is=
 used by dma-buf
> > > > > >>>> exporter to know the device buffer constraints of importer.
> > > > > >>>> [1] https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flwn.net%2FArticles%2F489703%2F&amp;data=3D04%7C01%7Cchristian.k=
oenig%40amd.com%7C4d18470a94df4ed24c8108d972ba5591%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637666967356417448%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3D=
ARwQyo%2BCjMohaNbyREofToHIj2bndL5L0HaU9cOrYq4%3D&amp;reserved=3D0
> > > > > >>> Which means for rxe you'd also have to pass the one for the u=
nderlying
> > > > > >>> net device.
> > > > > >> I thought of that way too. In that case, the memory region is =
constrained by the
> > > > > >> net device, but rxe driver copies data using CPU. To avoid the=
 constraints, I
> > > > > >> decided to use the ib device.
> > > > > > Well, that is the whole problem.
> > > > > >
> > > > > > We can't mix the dmabuf stuff people are doing that doesn't fil=
l in
> > > > > > the CPU pages in the SGL with RXE - it is simply impossible as =
things
> > > > > > currently are for RXE to acess this non-struct page memory.
> > > > >
> > > > > Yeah, agree that doesn't make much sense.
> > > > >
> > > > > When you want to access the data with the CPU then why do you wan=
t to
> > > > > use DMA-buf in the first place?
> > > > >
> > > > > Please keep in mind that there is work ongoing to replace the sg =
table
> > > > > with an DMA address array and so make the underlying struct page
> > > > > inaccessible for importers.
> > > >
> > > > Also if you do have a dma-buf, you can just dma_buf_vmap() the buff=
er
> > > > for cpu access. Which intentionally does not require any device. No
> > > > idea why there's a dma_buf_attach involved. Now not all exporters
> > > > support this, but that's fixable, and you must call
> > > > dma_buf_begin/end_cpu_access for cache management if the allocation
> > > > isn't cpu coherent. But it's all there, no need to apply hacks of
> > > > allowing a wrong device or other fun things.
> > >
> > > Can rxe leave the vmap in place potentially forever?
> >
> > Yeah, it's like perma-pinning the buffer into system memory for
> > non-p2p dma-buf sharing. We just squint and pretend that can't be
> > abused too badly :-) On 32bit you'll run out of vmap space rather
> > quickly, but that's not something anyone cares about here either. We
> > have a bunch of more sw modesetting drivers in drm which use
> > dma_buf_vmap() like this, so it's all fine.
> > -Daniel
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
> Thanks for your comments.
>
> In the first place, the CMA region cannot be used for RDMA because the
> region has no struct page. In addition, some GPU drivers use CMA and shar=
e
> the region as dma-buf. As a result, RDMA cannot transfer for the region. =
To
> solve this problem, rxe dma-buf support is better I thought.
>
> I'll consider and redesign the rxe dma-buf support using the dma_buf_vmap=
()
> instead of the dma_buf_dynamic_attach().

btw for next version please cc dri-devel. get_maintainers.pl should
pick it up for these patches.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
