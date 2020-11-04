Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C732A6C79
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 19:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgKDSJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 13:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgKDSJP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 13:09:15 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F568C0613D3
        for <linux-rdma@vger.kernel.org>; Wed,  4 Nov 2020 10:09:15 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 13so1142319qvr.5
        for <linux-rdma@vger.kernel.org>; Wed, 04 Nov 2020 10:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0hFi0TEBVUSWGO2K4tDK2RPW445ZDJNwZmLCkfQ4ceE=;
        b=RqlA8/w8ym+NosWRlENpZb00PKxQzhlipgpDQ2x8wUWKEek/AaN2hYf4xdsfgqzMyq
         r6fYqYkfOM2drdwoz5B8kBZ+Hb8ZWFL3KeINycNR3uCZjKB5d6GXpFfwE4l1nipygSBc
         7EqHGf7gtTdNprcR54xYK2b9Nx7s5Ksr2st0F37UXbn/V/F+H4Rm+vM5STjsbsINQJyA
         RNaNmXK7laH55H95YDJYikIvRIqPBPCCy8w5+UwY9CXescabd3RyPyHtIpPOe0LXlF+g
         8w7NUZ03Q9nSZYo9O1de6pJDDkfC3mThACnhX9a3cJSt47dHaUuAidpnSIAr8J6bY1SV
         g1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0hFi0TEBVUSWGO2K4tDK2RPW445ZDJNwZmLCkfQ4ceE=;
        b=b1SeroCsq1ivthVCm7qvEXVGVBOXb+AyvPZ3WbE63dFoyL/gYLQ6vuIYyaeXWNGFiL
         2ROWvhwi7mrFmyP3kDywgwcxGOdM0W52V8k1LhNi341GZYTbMPcPItdtD63Huk/Xd3AM
         atXHCdQ+yK9NjT8j5iwSoX36FdJM4/xQhw5M825ApKrHBRYORX7qzw04PMAOq18hGpWL
         hmtK6PBSSrCb+49JZH0WxHnujAM9PkBPvyloDJyQeRmdekn7G662bo1RkeIU7I0/JhiD
         70nWAxUjdakgyCHh2nLVLIt320me/dMEvRZi9ycnA5efDNPQJFKfVDvVjNAuh3PgFec7
         JizQ==
X-Gm-Message-State: AOAM533tbQz/Li80IRx0cpUY31Nto07uNpChhY6c5oljw3amtUcR1EZj
        RqNnklKRHtrF59SHyJ8T0VXJaQ==
X-Google-Smtp-Source: ABdhPJxPtfpuqqR8Rgm5jnzH160bIvcPShzueThP7abrgMAJGk2GTeyjhaFDKSLyJP0qsl8DAr8c7Q==
X-Received: by 2002:a05:6214:1249:: with SMTP id q9mr16729490qvv.0.1604513354401;
        Wed, 04 Nov 2020 10:09:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 19sm3090113qkj.69.2020.11.04.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:09:13 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kaNDc-00GaJ8-KP; Wed, 04 Nov 2020 14:09:12 -0400
Date:   Wed, 4 Nov 2020 14:09:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104180912.GS36674@ziepe.ca>
References: <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de>
 <20201104134241.GP36674@ziepe.ca>
 <20201104140108.GA5674@lst.de>
 <20201104155255.GR36674@ziepe.ca>
 <20201104163135.GA15840@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104163135.GA15840@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 04, 2020 at 11:52:55AM -0400, Jason Gunthorpe wrote:
> > It could work, I think a resonable ULP API would be to have some
> > 
> >  rdma_fill_ib_sge_from_sgl()
> >  rdma_map_sge_single()
> >  etc etc
> > 
> > ie instead of wrappering the DMA API as-is we have a new API that
> > directly builds the ib_sge. It always fills the local_dma_lkey from
> > the pd, so it knows it is doing DMA from local kernel memory.
> 
> Yeah.
> 
> > Logically SW devices then have a local_dma_lkey MR that has an IOVA of
> > the CPU physical address space, not the DMA address space as HW
> > devices have. The ib_sge builders can know this detail and fill in
> > addr from either a cpu phyical or a dma map.
> 
> I don't think the builders are the right place to do it - it really
> should to be in the low-level drivers for a bunch of reasons:

At this point we have little choice, the ULP is responsible for
map/unmap because the ULP owns the CQ and (batch) unmap is triggered
by some CQE.

Reworking all drivers to somehow keep track of unmaps a CQEs triggers
feels so hard at this point as to be impossible. It is why the
rdma_rw_ctx basically exists.

So we have to keep the current arrangment, when the ib_sge is built
the dma map must be conditionally done.

>  1) this avoids doing the dma_map when no DMA is performed, e.g. for
>     mlx5 when send data is in the extended WQE

At least in the kernel, the ULP has to be involved today in
IB_SEND_INLINE. Userspace does an auto-copy, but that is because it
doesn't have dma map/unmap. 

Without unmap tracking as above the caller must supply a specially
formed ib_sge when using IB_SEND_INLINE that specifies the CPU vaddr
so memcpy works.

But this all looks like dead code, no ULP sets IB_SEND_INLINE ??

>  2) to deal with the fact that dma mapping reduces the number of SGEs.
>     When the system uses a modern IOMMU we'll always end up with a
>     single IOVA range no matter how many pages were mapped originally.
>     This means any MR process can actually be consolidated to use
>     a single SGE with the local lkey.

Any place like rdma_rw_ctx_init() that decides dynamically between SGE
and MR becomes a mess. It would be manageable if rdma_rw_ctx_init()
was the only place doing this..

I haven't looked lately, but I wonder if it is feasible that all the
MR users would use this API?

Jason
