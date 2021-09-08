Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0909C40389C
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbhIHLTQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 07:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhIHLTP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 07:19:15 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8B6C061757
        for <linux-rdma@vger.kernel.org>; Wed,  8 Sep 2021 04:18:07 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w78so2048177qkb.4
        for <linux-rdma@vger.kernel.org>; Wed, 08 Sep 2021 04:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CHtrF75xmvvEALOjOIBKc7M8qJeQRUqeJb5BJfh1H4g=;
        b=QwWkF/R3UC+GHKapNtWpRxWl/VBHK/V/UAWmNV1TX2ReNuoWYDlPfVmhk7ycJ2ZgEr
         eP6E445pnO2fEW4QvORpGXLiHfBMuciQoRlf8NJwAlmjAA4lLWzteHP8/ouuu/Eg6w9+
         5rdFVGRoOPnkZaw7jr9hfKktATeAaRa1FCgbadxs/B3nWy4f+Ob8w2IchLAroxIPujDX
         TIMVVjir6GhXD4xUXta877YZTKcgpziP60ScneZjCqPH6ElP9CBcsD73ihkYEHUwnSRN
         nPV2lYKJfwMAe0gKeJ3iS78FUXrS4KcBJz3suqmZewccRERLeiyCGG8bxmqFX4a094l1
         hJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CHtrF75xmvvEALOjOIBKc7M8qJeQRUqeJb5BJfh1H4g=;
        b=LVJuk20o2UHG8kRxvBa+A1BL4niX/waN6JBfCcu6JRqYWp0V7jcNuNIuHGnk7Vk2O2
         0ngg+Oi5ibxaZDXw2yqQYGz6Sw/D5IZ26ZwFNUfHHzJmqBPfm9/tl/6JtItmy86lwmQo
         HpRzZ5Z+EyMyDdIi2bIkzpYDncvggS/FPjwQGByEYOBYiyuh1kZ69w4cujF9lkQV5qSg
         e7EkzjZaNRhZ+lMaRtm7yC8i4ZyPDY3M2ZiBzhuR3W60mEX31523sSmN12GrWx0+/ZG1
         uji11h6kk/wLO3CNEO6LtAOzc74ei804Jxesja5bOJi7vZErD2f/iFyfWRJj5U16oFRh
         r/pg==
X-Gm-Message-State: AOAM530hwZXEm7fwiHUpUeikPrLwvRAwJPGXue0kaVgt59sRkRd6Qp7U
        fsgC8rwqfGOszV3a3gb3KbXrgA==
X-Google-Smtp-Source: ABdhPJzPhQc44k95z7g/Ovdwb7RZfgbO3AipmHf6dYNxBmJ53UrhPVZGIOwAnRupfaxBLUARxuSiIQ==
X-Received: by 2002:a37:f90c:: with SMTP id l12mr2768510qkj.514.1631099887068;
        Wed, 08 Sep 2021 04:18:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h12sm1277051qth.1.2021.09.08.04.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:18:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mNvae-00DFol-Ol; Wed, 08 Sep 2021 08:18:04 -0300
Date:   Wed, 8 Sep 2021 08:18:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Christian K??nig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma
 device
Message-ID: <20210908111804.GX1200268@ziepe.ca>
References: <20210908061611.69823-1-mie@igel.co.jp>
 <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org>
 <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org>
 <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 08, 2021 at 05:41:39PM +0900, Shunsuke Mie wrote:
> 2021年9月8日(水) 16:20 Christoph Hellwig <hch@infradead.org>:
> >
> > On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wrote:
> > > Thank you for your comment.
> > > >
> > > > On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
> > > > > To share memory space using dma-buf, a API of the dma-buf requires dma
> > > > > device, but devices such as rxe do not have a dma device. For those case,
> > > > > change to specify a device of struct ib instead of the dma device.
> > > >
> > > > So if dma-buf doesn't actually need a device to dma map why do we ever
> > > > pass the dma_device here?  Something does not add up.
> > > As described in the dma-buf api guide [1], the dma_device is used by dma-buf
> > > exporter to know the device buffer constraints of importer.
> > > [1] https://lwn.net/Articles/489703/
> >
> > Which means for rxe you'd also have to pass the one for the underlying
> > net device.
> I thought of that way too. In that case, the memory region is constrained by the
> net device, but rxe driver copies data using CPU. To avoid the constraints, I
> decided to use the ib device.

Well, that is the whole problem.

We can't mix the dmabuf stuff people are doing that doesn't fill in
the CPU pages in the SGL with RXE - it is simply impossible as things
currently are for RXE to acess this non-struct page memory.

Jason
