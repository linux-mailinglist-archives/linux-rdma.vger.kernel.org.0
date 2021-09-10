Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEAD40655F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Sep 2021 03:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhIJBrl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 21:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhIJBrk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 21:47:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF1C061574
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 18:46:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t19so742550lfe.13
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 18:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oI/LTBnGx8tsMH92BXl9TylxJCNSHKhi0QiJerVLXGo=;
        b=sXsCND7EDImjW5ay/AxrcG6JlKNdyzLJuZwVRKq9BSVweWds9UvhXX2cxxA6kHdqvp
         rvIrL75fRp7S65LlOLpYuAV3A+4XK0cGkKfnDK3fdmK7+9LrYBsMU5/WG3qQlipl/JHD
         EBmpCHISNVj+keaUstyu/nJcrz06FdMeKmL1VYQxCwUigGK1OuSfvmCxtD+MtkKkYEhF
         I/7xIaxoY7rLUXecG3amxOoxaLeir7kME+KiQKSW5ruG9d3R1XJRc3R9lOnioUtoxeQE
         fDGHrjY/GfPwnsGC1p9iUryioErkLFiyM5GzFmimU+wPYpMwg0S8FafaqMETXrfahT9g
         2gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oI/LTBnGx8tsMH92BXl9TylxJCNSHKhi0QiJerVLXGo=;
        b=gZxGQff1exYC8kTypx2yi+3Z34n1ngPXESn6+Mk2RPopSbzfTU4Q77kx+S5Qq2lFzd
         xEbUB5A4DUTbXk778HJmbo9JDBDK7QT7WP1R5/ZWTN1cj595f7roNbgIRsf9QLMvziIv
         ZWn312HAZkRwfwFO5rYgXUjZ2BM4H2BKW9Qa2l+5NN9DUd9+/9leUwavN5sVlBoIGUP9
         8TDduE6sEObVhazF2ffz/yvUueJaNtVO9z6yMrn4gzPkY1UvTp7ql/YwzrSrkmenWBXn
         ZHQYf+IcDFp/Wvn5odhnxTKsobpq3DQxugozj1hiobKko1IVw0xiFkisDLgOhvvz23ug
         iXrw==
X-Gm-Message-State: AOAM532Ycq8BlVZAE1NYSApAL9mN9hKSS1jrQTf3HeDIGNH3HxuRTVL5
        48ah1FCqyJ48cedxwmLVDyLqZMH0OvBe3Tii6mr0cA==
X-Google-Smtp-Source: ABdhPJzfWNILKvqGRz6A+aK+XomjFnWM6XD9pcwhNUW5BHAhGL426BL0qOlVh0kOMVK5La3a+IkBBe9QSXZ8Gm+lKh8=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr1883625lfa.523.1631238386987;
 Thu, 09 Sep 2021 18:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org> <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org> <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
 <20210908111804.GX1200268@ziepe.ca> <1c0356f5-19cf-e883-3d96-82a87d0cffcb@amd.com>
 <CAKMK7uE=mQwgcSaTcT8U3GgCeeKOmPqS=YOqkn+SEnbbUNM1=A@mail.gmail.com>
 <20210908233354.GB3544071@ziepe.ca> <CAKMK7uHx+bDEkbg3RcwdGr9wbUgt2wx8zfx4N7G-K6d4HSY7XA@mail.gmail.com>
In-Reply-To: <CAKMK7uHx+bDEkbg3RcwdGr9wbUgt2wx8zfx4N7G-K6d4HSY7XA@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Fri, 10 Sep 2021 10:46:15 +0900
Message-ID: <CANXvt5rYxr0xBrdbmqqKAV8ctCZaJrxEM7F0Hpt2k98wBvah7Q@mail.gmail.com>
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

2021=E5=B9=B49=E6=9C=889=E6=97=A5(=E6=9C=A8) 18:26 Daniel Vetter <daniel.ve=
tter@ffwll.ch>:
>
> On Thu, Sep 9, 2021 at 1:33 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Wed, Sep 08, 2021 at 09:22:37PM +0200, Daniel Vetter wrote:
> > > On Wed, Sep 8, 2021 at 3:33 PM Christian K=C3=B6nig <christian.koenig=
@amd.com> wrote:
> > > > Am 08.09.21 um 13:18 schrieb Jason Gunthorpe:
> > > > > On Wed, Sep 08, 2021 at 05:41:39PM +0900, Shunsuke Mie wrote:
> > > > >> 2021=E5=B9=B49=E6=9C=888=E6=97=A5(=E6=B0=B4) 16:20 Christoph Hel=
lwig <hch@infradead.org>:
> > > > >>> On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wrote:
> > > > >>>> Thank you for your comment.
> > > > >>>>> On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
> > > > >>>>>> To share memory space using dma-buf, a API of the dma-buf re=
quires dma
> > > > >>>>>> device, but devices such as rxe do not have a dma device. Fo=
r those case,
> > > > >>>>>> change to specify a device of struct ib instead of the dma d=
evice.
> > > > >>>>> So if dma-buf doesn't actually need a device to dma map why d=
o we ever
> > > > >>>>> pass the dma_device here?  Something does not add up.
> > > > >>>> As described in the dma-buf api guide [1], the dma_device is u=
sed by dma-buf
> > > > >>>> exporter to know the device buffer constraints of importer.
> > > > >>>> [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flwn.net%2FArticles%2F489703%2F&amp;data=3D04%7C01%7Cchristian.koe=
nig%40amd.com%7C4d18470a94df4ed24c8108d972ba5591%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637666967356417448%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3DAR=
wQyo%2BCjMohaNbyREofToHIj2bndL5L0HaU9cOrYq4%3D&amp;reserved=3D0
> > > > >>> Which means for rxe you'd also have to pass the one for the und=
erlying
> > > > >>> net device.
> > > > >> I thought of that way too. In that case, the memory region is co=
nstrained by the
> > > > >> net device, but rxe driver copies data using CPU. To avoid the c=
onstraints, I
> > > > >> decided to use the ib device.
> > > > > Well, that is the whole problem.
> > > > >
> > > > > We can't mix the dmabuf stuff people are doing that doesn't fill =
in
> > > > > the CPU pages in the SGL with RXE - it is simply impossible as th=
ings
> > > > > currently are for RXE to acess this non-struct page memory.
> > > >
> > > > Yeah, agree that doesn't make much sense.
> > > >
> > > > When you want to access the data with the CPU then why do you want =
to
> > > > use DMA-buf in the first place?
> > > >
> > > > Please keep in mind that there is work ongoing to replace the sg ta=
ble
> > > > with an DMA address array and so make the underlying struct page
> > > > inaccessible for importers.
> > >
> > > Also if you do have a dma-buf, you can just dma_buf_vmap() the buffer
> > > for cpu access. Which intentionally does not require any device. No
> > > idea why there's a dma_buf_attach involved. Now not all exporters
> > > support this, but that's fixable, and you must call
> > > dma_buf_begin/end_cpu_access for cache management if the allocation
> > > isn't cpu coherent. But it's all there, no need to apply hacks of
> > > allowing a wrong device or other fun things.
> >
> > Can rxe leave the vmap in place potentially forever?
>
> Yeah, it's like perma-pinning the buffer into system memory for
> non-p2p dma-buf sharing. We just squint and pretend that can't be
> abused too badly :-) On 32bit you'll run out of vmap space rather
> quickly, but that's not something anyone cares about here either. We
> have a bunch of more sw modesetting drivers in drm which use
> dma_buf_vmap() like this, so it's all fine.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

Thanks for your comments.

In the first place, the CMA region cannot be used for RDMA because the
region has no struct page. In addition, some GPU drivers use CMA and share
the region as dma-buf. As a result, RDMA cannot transfer for the region. To
solve this problem, rxe dma-buf support is better I thought.

I'll consider and redesign the rxe dma-buf support using the dma_buf_vmap()
instead of the dma_buf_dynamic_attach().

Regards,
Shunsuke
