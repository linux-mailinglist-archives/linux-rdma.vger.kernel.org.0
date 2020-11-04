Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03732A68A0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 16:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgKDPxF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 10:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbgKDPw6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 10:52:58 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7819DC0613D4
        for <linux-rdma@vger.kernel.org>; Wed,  4 Nov 2020 07:52:57 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id da2so7909799qvb.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Nov 2020 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ep7j19TFsqDMxPD3eWS2/2sPns1mbbjfPZKNVE69Xzw=;
        b=AUuOlw0KLAwiVQOesE52nchcwhD+3eTZAOQ2AgXJOWJ3XMaOIef+M5UvRSDII07R0g
         LA67cShD36nAgQV8XflNylXVuiA9sN1sxapH5hcvQBg8BMC7oJSDqlj0n+QWuYrsrnUO
         eYTDqWcZiNmGe8ZSYPR7o+mtkhMR+Am5r4Q5ogWcrniQAQcqWctDeHsw4sQs+XVqbj9W
         uy62bb+5tgNsFxaIO8R99eExOitp2+auF/LVKl/FJMf9gQLPgmbI+98DbDFpME61i+zO
         jScwkquASavS/MyIkGqJ+gnyoRkmEoldBWapXzelMv/l/RVZ2eoDAumCUlXO8B4T2AnK
         N0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ep7j19TFsqDMxPD3eWS2/2sPns1mbbjfPZKNVE69Xzw=;
        b=DFKQ7Isc93GVzLURhkUemcU6oUScJr6aiA6AcBRaACTX4xBy+Vm5Qk8GYy2SUasDYW
         isPEtRpLwBIG3tsmXxFiiHZJPbbOeo+Bs+AXKfb5v7p0v8I2D8UKdCYv5MqpVUofxqxp
         EvBRXJBzQp+rFQcYr1lUcbiUP1hhwS35bumFM6FE9FSHsyGZnRyjdlmNyIeAajlSxQ8A
         wVMa35qztdAouQjQRSUoWX5meRKQ9iLMhUZAzRV4TlDiS0kEQqW5fJXrDQ/mC9KAGsnI
         /oTUIznR0tQ61YEdRbzgtznvktcHnlPSWQGwFjmeHbHO7IqztbkCiwL1IS3hu9hQEu8e
         YfLA==
X-Gm-Message-State: AOAM531XjRvEY1MuuaCUJrDS9RkynC5Sk8LN9Sv4PwugGtxrhhZW+D2F
        jIsoDr20V6x/6hySB3NLkTSL3w==
X-Google-Smtp-Source: ABdhPJzi13d279sLLPCgu3bz4PAOPkGt+vfZ6Vorvp9mdCFZYQThEQ6fs7tjNSin4TOsVJDc3qddIA==
X-Received: by 2002:a0c:d68d:: with SMTP id k13mr444150qvi.62.1604505176734;
        Wed, 04 Nov 2020 07:52:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w25sm2821725qkj.85.2020.11.04.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:52:55 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kaL5j-00GY3P-95; Wed, 04 Nov 2020 11:52:55 -0400
Date:   Wed, 4 Nov 2020 11:52:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104155255.GR36674@ziepe.ca>
References: <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de>
 <20201104134241.GP36674@ziepe.ca>
 <20201104140108.GA5674@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104140108.GA5674@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 03:01:08PM +0100, Christoph Hellwig wrote:

> > Sigh. I think the proper fix is to replace addr/length with a
> > scatterlist pointer in the struct ib_sge, then have SW drivers
> > directly use the page pointer properly.
> 
> The proper fix is to move the DMA mapping into the RDMA core, yes.
> And as you said it will be hard.  But I don't think scatterlists
> are the right interface.  IMHO we can keep re-use the existing
> struct ib_sge:
> 
> struct ib_ge {
> 	u64     addr;
> 	u32     length;
> 	u32     lkey;
> };

Gah, right, this is all about local_dma_lkey..
 
> with the difference that if lkey is not a MR, addr is the physical
> address of the memory, not a dma_addr_t or virtual address.

It could work, I think a resonable ULP API would be to have some

 rdma_fill_ib_sge_from_sgl()
 rdma_map_sge_single()
 etc etc

ie instead of wrappering the DMA API as-is we have a new API that
directly builds the ib_sge. It always fills the local_dma_lkey from
the pd, so it knows it is doing DMA from local kernel memory.

Logically SW devices then have a local_dma_lkey MR that has an IOVA of
the CPU physical address space, not the DMA address space as HW
devices have. The ib_sge builders can know this detail and fill in
addr from either a cpu phyical or a dma map.

The SW device has to translate the addr/length in CPU space to
something else. It actually makes reasonable sense architecturally.

This is actually much less horrible than I thought..

Convert all ULPs to one of these new APIs, searching for
local_dma_lkey will find all places. This will replace a whole lot of
calls to ib DMA API wrapper functions. Searching for local_dma_lkey
will find all users. Drivers already work with sge.addr == CPU
address, so no driver change

Then to kill the dma_ops wrappers the remaining users should all be
connected to map_mr_sg. In this case we want a no-op dma map and fix
the three map_mr_sg's to use the page side of the sgl, not the DMA
side

Not as horrible as I imagined at first, actually..

Jason
