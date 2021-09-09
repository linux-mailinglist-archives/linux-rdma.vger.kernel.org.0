Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EDE4047B5
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhIIJ2H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 05:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhIIJ2H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 05:28:07 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449D8C061757
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 02:26:58 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id y3-20020a4ab403000000b00290e2a52c71so367270oon.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d6F+Zj7MjB0XsuFv8vC0jvK+3NOF2gE3rZxZ5a2W05s=;
        b=J/X/N7UJ24d0X+MJB3iWpT8oP9ex27IKpiWfr/Jx27AavQSVoRfCNadiY8Tceml6bm
         HI2WYBgWX2XM3wHo57eMTlDym4BPrzY5TLENrL55Qc9/n3olMQTJMShp4hz7bFUJf20L
         ah6eLcPl8rzddCItE/alxwf+7ve/nf4jaQP/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d6F+Zj7MjB0XsuFv8vC0jvK+3NOF2gE3rZxZ5a2W05s=;
        b=Or1qcLvvWAZQsSLZsfV/7NFBucU0DDfpCq5/fV4xLcXyO1F9eKAuQy+W+paRSgG3J1
         37nV8GGtCeYrmbilJtQ1I2dmDt9UVCdNLfFEhiHUC0U3la6BbuD5dRQw/240LyY8kl2n
         jLWHMgCrcSqr511tIVCmlmbURr8Ezq230WbzjKWwNHvqoYMs/mMeZ7ucRXnZfgWmRSSG
         CfRAk+1AcHPHyAKco+HacLLyDzbPEoxUcnZR28p3uFdWljRaRnKjMPgv5CUMY9k6vtHq
         WZfwgLjebz1hZ5CO/XtOmQfG6btr4HWwBMasGOaaVhfx5pO4+Lqe33AUN1X8HRue734z
         fxCA==
X-Gm-Message-State: AOAM531wjAb3ACp4NYS3go3TCtUZNgHtOXPCprjmg7nDPKQH1mmVhrtb
        xWv5/t9x/iO+vrXrAIiBk+iDrd5cvhFQQeLKijZeTA==
X-Google-Smtp-Source: ABdhPJwptKVSDdb5MZuH2gAMae7SYaRhDjB7Yn7WTC2WufiW9ywCDqWj/hKzIPZ+IZhrS2BkldbXBFyfZg3QfJHHPmw=
X-Received: by 2002:a4a:dc51:: with SMTP id q17mr1630242oov.10.1631179617509;
 Thu, 09 Sep 2021 02:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org> <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org> <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
 <20210908111804.GX1200268@ziepe.ca> <1c0356f5-19cf-e883-3d96-82a87d0cffcb@amd.com>
 <CAKMK7uE=mQwgcSaTcT8U3GgCeeKOmPqS=YOqkn+SEnbbUNM1=A@mail.gmail.com> <20210908233354.GB3544071@ziepe.ca>
In-Reply-To: <20210908233354.GB3544071@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 9 Sep 2021 11:26:46 +0200
Message-ID: <CAKMK7uHx+bDEkbg3RcwdGr9wbUgt2wx8zfx4N7G-K6d4HSY7XA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma device
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shunsuke Mie <mie@igel.co.jp>,
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

On Thu, Sep 9, 2021 at 1:33 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Sep 08, 2021 at 09:22:37PM +0200, Daniel Vetter wrote:
> > On Wed, Sep 8, 2021 at 3:33 PM Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> > > Am 08.09.21 um 13:18 schrieb Jason Gunthorpe:
> > > > On Wed, Sep 08, 2021 at 05:41:39PM +0900, Shunsuke Mie wrote:
> > > >> 2021=E5=B9=B49=E6=9C=888=E6=97=A5(=E6=B0=B4) 16:20 Christoph Hellw=
ig <hch@infradead.org>:
> > > >>> On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wrote:
> > > >>>> Thank you for your comment.
> > > >>>>> On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
> > > >>>>>> To share memory space using dma-buf, a API of the dma-buf requ=
ires dma
> > > >>>>>> device, but devices such as rxe do not have a dma device. For =
those case,
> > > >>>>>> change to specify a device of struct ib instead of the dma dev=
ice.
> > > >>>>> So if dma-buf doesn't actually need a device to dma map why do =
we ever
> > > >>>>> pass the dma_device here?  Something does not add up.
> > > >>>> As described in the dma-buf api guide [1], the dma_device is use=
d by dma-buf
> > > >>>> exporter to know the device buffer constraints of importer.
> > > >>>> [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flwn.net%2FArticles%2F489703%2F&amp;data=3D04%7C01%7Cchristian.koeni=
g%40amd.com%7C4d18470a94df4ed24c8108d972ba5591%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637666967356417448%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3DARwQ=
yo%2BCjMohaNbyREofToHIj2bndL5L0HaU9cOrYq4%3D&amp;reserved=3D0
> > > >>> Which means for rxe you'd also have to pass the one for the under=
lying
> > > >>> net device.
> > > >> I thought of that way too. In that case, the memory region is cons=
trained by the
> > > >> net device, but rxe driver copies data using CPU. To avoid the con=
straints, I
> > > >> decided to use the ib device.
> > > > Well, that is the whole problem.
> > > >
> > > > We can't mix the dmabuf stuff people are doing that doesn't fill in
> > > > the CPU pages in the SGL with RXE - it is simply impossible as thin=
gs
> > > > currently are for RXE to acess this non-struct page memory.
> > >
> > > Yeah, agree that doesn't make much sense.
> > >
> > > When you want to access the data with the CPU then why do you want to
> > > use DMA-buf in the first place?
> > >
> > > Please keep in mind that there is work ongoing to replace the sg tabl=
e
> > > with an DMA address array and so make the underlying struct page
> > > inaccessible for importers.
> >
> > Also if you do have a dma-buf, you can just dma_buf_vmap() the buffer
> > for cpu access. Which intentionally does not require any device. No
> > idea why there's a dma_buf_attach involved. Now not all exporters
> > support this, but that's fixable, and you must call
> > dma_buf_begin/end_cpu_access for cache management if the allocation
> > isn't cpu coherent. But it's all there, no need to apply hacks of
> > allowing a wrong device or other fun things.
>
> Can rxe leave the vmap in place potentially forever?

Yeah, it's like perma-pinning the buffer into system memory for
non-p2p dma-buf sharing. We just squint and pretend that can't be
abused too badly :-) On 32bit you'll run out of vmap space rather
quickly, but that's not something anyone cares about here either. We
have a bunch of more sw modesetting drivers in drm which use
dma_buf_vmap() like this, so it's all fine.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
