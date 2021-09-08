Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB5E403FC1
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350001AbhIHTX6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349847AbhIHTX5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 15:23:57 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BCC061757
        for <linux-rdma@vger.kernel.org>; Wed,  8 Sep 2021 12:22:49 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c79so4423911oib.11
        for <linux-rdma@vger.kernel.org>; Wed, 08 Sep 2021 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=61wtExygeBHNU8JF1VKoq8GwGXMXla9fnLJNWz4U874=;
        b=Qkoyhe9Z1+0BPnng/Vdy7xf4dQsH7MUTBdaZI9INIgnp8jPW8UvHsIV+/SLr1kumRx
         RWELex1z74aqpLUB/5ap0BCWYE7chvPYDFixzzTLhO1/caJZVbqPV/Cr4ScDuKdBaYJR
         p9T25XKOTz/tFO5XYp6qAa8sIqTdSRnSz0prs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=61wtExygeBHNU8JF1VKoq8GwGXMXla9fnLJNWz4U874=;
        b=8QZe6Qv+wnwVvkAiL6XekjBCbymGm3WK5Yn2EC8VxFIPO6F0PlcNrlouNvkNMRSahS
         T6xOs6DnPUfux6G9tIEZ4y1PkXlt6SLcgSWg/oQ2Y857/sCUdTBD9u2J2DDlZCxeG8AV
         gCW/OV5Zs4pAkqK5QF/rSgsbKTlU6v7E10thgg2FGVedLQ4Xx9EQnpwhdUlmieQs9i6c
         kgaDjyzGai5VKDNuiqBy1VsLGJ3eRhBG/bwDV+fqLcZOc4PbUNCD16x1bI7yihbm/73n
         JzX5hmvC56SHVXwPCkIld5aPrTwShlTOmAFk3s6PIOyVFcCcDx44f3FfLuyfCLeOmWOS
         1NxA==
X-Gm-Message-State: AOAM5308hH42DQ6beQAvmvsdhh5IK2/BRWj8Rj4ABnpHpeBu6zt+O8N2
        6Y1DlOMYYVhRSqW263cALOBDiqwEE8kO25gP1IwR8w==
X-Google-Smtp-Source: ABdhPJyMVPWZq+0eN5wIDIK73pjGaAgZfNF+FmxkWJEtyh6JhBRuT7h/4z4PCJffVzSDmSs53y0p5S0M6Urst1ZzTQc=
X-Received: by 2002:aca:3954:: with SMTP id g81mr3572533oia.101.1631128969002;
 Wed, 08 Sep 2021 12:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org> <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org> <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
 <20210908111804.GX1200268@ziepe.ca> <1c0356f5-19cf-e883-3d96-82a87d0cffcb@amd.com>
In-Reply-To: <1c0356f5-19cf-e883-3d96-82a87d0cffcb@amd.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 8 Sep 2021 21:22:37 +0200
Message-ID: <CAKMK7uE=mQwgcSaTcT8U3GgCeeKOmPqS=YOqkn+SEnbbUNM1=A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma device
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Shunsuke Mie <mie@igel.co.jp>,
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

On Wed, Sep 8, 2021 at 3:33 PM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
> Am 08.09.21 um 13:18 schrieb Jason Gunthorpe:
> > On Wed, Sep 08, 2021 at 05:41:39PM +0900, Shunsuke Mie wrote:
> >> 2021=E5=B9=B49=E6=9C=888=E6=97=A5(=E6=B0=B4) 16:20 Christoph Hellwig <=
hch@infradead.org>:
> >>> On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wrote:
> >>>> Thank you for your comment.
> >>>>> On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
> >>>>>> To share memory space using dma-buf, a API of the dma-buf requires=
 dma
> >>>>>> device, but devices such as rxe do not have a dma device. For thos=
e case,
> >>>>>> change to specify a device of struct ib instead of the dma device.
> >>>>> So if dma-buf doesn't actually need a device to dma map why do we e=
ver
> >>>>> pass the dma_device here?  Something does not add up.
> >>>> As described in the dma-buf api guide [1], the dma_device is used by=
 dma-buf
> >>>> exporter to know the device buffer constraints of importer.
> >>>> [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flwn.net%2FArticles%2F489703%2F&amp;data=3D04%7C01%7Cchristian.koenig%40=
amd.com%7C4d18470a94df4ed24c8108d972ba5591%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637666967356417448%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3DARwQyo%2=
BCjMohaNbyREofToHIj2bndL5L0HaU9cOrYq4%3D&amp;reserved=3D0
> >>> Which means for rxe you'd also have to pass the one for the underlyin=
g
> >>> net device.
> >> I thought of that way too. In that case, the memory region is constrai=
ned by the
> >> net device, but rxe driver copies data using CPU. To avoid the constra=
ints, I
> >> decided to use the ib device.
> > Well, that is the whole problem.
> >
> > We can't mix the dmabuf stuff people are doing that doesn't fill in
> > the CPU pages in the SGL with RXE - it is simply impossible as things
> > currently are for RXE to acess this non-struct page memory.
>
> Yeah, agree that doesn't make much sense.
>
> When you want to access the data with the CPU then why do you want to
> use DMA-buf in the first place?
>
> Please keep in mind that there is work ongoing to replace the sg table
> with an DMA address array and so make the underlying struct page
> inaccessible for importers.

Also if you do have a dma-buf, you can just dma_buf_vmap() the buffer
for cpu access. Which intentionally does not require any device. No
idea why there's a dma_buf_attach involved. Now not all exporters
support this, but that's fixable, and you must call
dma_buf_begin/end_cpu_access for cache management if the allocation
isn't cpu coherent. But it's all there, no need to apply hacks of
allowing a wrong device or other fun things.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
