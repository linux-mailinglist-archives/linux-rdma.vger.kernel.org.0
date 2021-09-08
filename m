Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3F84041D4
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 01:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbhIHXfH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 19:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbhIHXfF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 19:35:05 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09901C061757
        for <linux-rdma@vger.kernel.org>; Wed,  8 Sep 2021 16:33:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id w8so97335qvt.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 Sep 2021 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gwQYHck7BMUKkGamYdSoRVg09azr+jdJw6rIsi6S+vk=;
        b=DrMOX6OWFsDUPMEr61rWc//+OocHVa+BlQarE2QJLAroD7R834CN2CdA60vYdbScf+
         06N2f9l0l9yQsJMNqKiXWFC8qRCdSHEkL0z7qpPDEx2pcy/iqghV3mhf+lT96tT8KR5c
         zKrOn5qw5MuX0+8xUDY53Hs1qmEQMNm72cW0DnCRjzHATsLp7ee9UPFA7Y5M+ZdvICfi
         m38Zys2Ll4OFtUhgbn2gBw4pYwgDQeXhHOEqOQ3jEUZ/VGKaj4JVHQaoa42ay/2by832
         SQU9JPiK8z3x26iLy2h3TE5rJAI+j+sxvKNfhOItDU2bg8Eu2rR8tMqXnlIyS03xfjsy
         Vbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gwQYHck7BMUKkGamYdSoRVg09azr+jdJw6rIsi6S+vk=;
        b=ZXQ9Opra0tv4jvzY8XEHO9uoS+frinH+DCXGw5+Qsqu97F6Dky04Uz8nTeG16/kWGo
         pdCncvhYImRi83qtUP8MecFrUda27XrEtHPcYFG+yHWeto0SV3/0+9zztOLkI1xYNmBH
         KoFKJh1n3JKe20YsyITqi6dHCBgJnMUEOCh4EO5PvxMK1Yt7pWX0Z55nR8nnWNHruJD1
         1JB+eNgK9a1XRP7uc61dnrZ1V9F3tqWYVi5qUg9laB+w2+9zfXtQMLyI/WLZ+NE4TfcX
         3jYHbM/8fygll8sj8s4trYrOm49WrDpyqQvMwSKnTLmSD9b7VchWXR3CmYVlSVfHpV+I
         NwZg==
X-Gm-Message-State: AOAM5311LmlZg9qaLOUhtehC8tdP0nZBrD9/fQjMEULA7GaNBPOamFNb
        bYD1/mVbAMkekU16JTHdLXHB2g==
X-Google-Smtp-Source: ABdhPJwNA/77xtIMS3uTVLRdtquJh/PSHYWAq5zpTf6KOpMK4j8ysc8NRWaKQIZlIxbLoD95rKXBXg==
X-Received: by 2002:a05:6214:104d:: with SMTP id l13mr69910qvr.13.1631144036203;
        Wed, 08 Sep 2021 16:33:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id x3sm78338qkx.62.2021.09.08.16.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 16:33:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mO74k-00EsBp-Ob; Wed, 08 Sep 2021 20:33:54 -0300
Date:   Wed, 8 Sep 2021 20:33:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma
 device
Message-ID: <20210908233354.GB3544071@ziepe.ca>
References: <20210908061611.69823-1-mie@igel.co.jp>
 <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org>
 <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org>
 <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
 <20210908111804.GX1200268@ziepe.ca>
 <1c0356f5-19cf-e883-3d96-82a87d0cffcb@amd.com>
 <CAKMK7uE=mQwgcSaTcT8U3GgCeeKOmPqS=YOqkn+SEnbbUNM1=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uE=mQwgcSaTcT8U3GgCeeKOmPqS=YOqkn+SEnbbUNM1=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 08, 2021 at 09:22:37PM +0200, Daniel Vetter wrote:
> On Wed, Sep 8, 2021 at 3:33 PM Christian König <christian.koenig@amd.com> wrote:
> > Am 08.09.21 um 13:18 schrieb Jason Gunthorpe:
> > > On Wed, Sep 08, 2021 at 05:41:39PM +0900, Shunsuke Mie wrote:
> > >> 2021年9月8日(水) 16:20 Christoph Hellwig <hch@infradead.org>:
> > >>> On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wrote:
> > >>>> Thank you for your comment.
> > >>>>> On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
> > >>>>>> To share memory space using dma-buf, a API of the dma-buf requires dma
> > >>>>>> device, but devices such as rxe do not have a dma device. For those case,
> > >>>>>> change to specify a device of struct ib instead of the dma device.
> > >>>>> So if dma-buf doesn't actually need a device to dma map why do we ever
> > >>>>> pass the dma_device here?  Something does not add up.
> > >>>> As described in the dma-buf api guide [1], the dma_device is used by dma-buf
> > >>>> exporter to know the device buffer constraints of importer.
> > >>>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flwn.net%2FArticles%2F489703%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C4d18470a94df4ed24c8108d972ba5591%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637666967356417448%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=ARwQyo%2BCjMohaNbyREofToHIj2bndL5L0HaU9cOrYq4%3D&amp;reserved=0
> > >>> Which means for rxe you'd also have to pass the one for the underlying
> > >>> net device.
> > >> I thought of that way too. In that case, the memory region is constrained by the
> > >> net device, but rxe driver copies data using CPU. To avoid the constraints, I
> > >> decided to use the ib device.
> > > Well, that is the whole problem.
> > >
> > > We can't mix the dmabuf stuff people are doing that doesn't fill in
> > > the CPU pages in the SGL with RXE - it is simply impossible as things
> > > currently are for RXE to acess this non-struct page memory.
> >
> > Yeah, agree that doesn't make much sense.
> >
> > When you want to access the data with the CPU then why do you want to
> > use DMA-buf in the first place?
> >
> > Please keep in mind that there is work ongoing to replace the sg table
> > with an DMA address array and so make the underlying struct page
> > inaccessible for importers.
> 
> Also if you do have a dma-buf, you can just dma_buf_vmap() the buffer
> for cpu access. Which intentionally does not require any device. No
> idea why there's a dma_buf_attach involved. Now not all exporters
> support this, but that's fixable, and you must call
> dma_buf_begin/end_cpu_access for cache management if the allocation
> isn't cpu coherent. But it's all there, no need to apply hacks of
> allowing a wrong device or other fun things.

Can rxe leave the vmap in place potentially forever?

Jason
