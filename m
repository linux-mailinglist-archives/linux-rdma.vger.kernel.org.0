Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC325BAAD
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 07:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgICF6R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 01:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgICF6R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 01:58:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A0C061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 22:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OLK17jT/X07dwKpD+dvlugET8UGIHQdA1/2KFZnem/A=; b=c31gugrTOwXjZwRVC9imR7FUQY
        lY5wv0YCdwboTP1FrJFPC+/X0Kx6jruJt983TKfG94/F9zkzr/HlLEv2xv4jbOyaHJyPZBcQK2UAJ
        /uNNkcExR7DWgu+x5fVy8haiTdE6WF99CP+lFwWNHBJSQMvNPK6nQRwKs7mGia8IhZrAGwY/Fqv1K
        KLmEJPqGfsH625bbIb1q+3h379srcDRKQECS+orJHb+x0zDY69twCxReJL7adSZhQFwjHcixj8zSf
        eR2B9j18xoVis/lOnJMnjLjzIsPfNS8a4xKw9zJkDS7QQrhIZ7py53SVGNUi7HJtc07YBRd01X8Gr
        0Z5ZaIzw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDiGE-0008Mb-W6; Thu, 03 Sep 2020 05:58:15 +0000
Date:   Thu, 3 Sep 2020 06:58:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
Subject: Re: [PATCH v2] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200903055814.GB31262@infradead.org>
References: <20200901030826.140880-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901030826.140880-1-sagi@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 31, 2020 at 08:08:26PM -0700, Sagi Grimberg wrote:
> Currently we allocate rx buffers in a single contiguous buffers for
> headers (iser and iscsi) and data trailer. This means that most likely
> the data starting offset is aligned to 76 bytes (size of both headers).
> 
> This worked fine for years, but at some point this broke, resulting in
> data corruptions in isert when a command comes with immediate data
> and the underlying backend device assumes 512 bytes buffer alignment.
> 
> We assume a hard-requirement for all direct I/O buffers to be 512 bytes
> aligned. To fix this, we should avoid passing unaligned buffers for I/O.
> 
> Instead, we allocate our recv buffers with some extra space such that we
> can have the data portion align to 512 byte boundary. This also means
> that we cannot reference headers or data using structure but rather
> accessors (as they may move based on alignment). Also, get rid of the
> wrong __packed annotation from iser_rx_desc as this has only harmful
> effects (not aligned to anything).
> 
> This affects the rx descriptors for iscsi login and data plane.
> 
> Reported-by: Stephen Rust <srust@blockbridge.com>
> Tested-by: Doug Dumitru <doug@dumitru.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - revised change log
> 
>  drivers/infiniband/ulp/isert/ib_isert.c | 93 +++++++++++++------------
>  drivers/infiniband/ulp/isert/ib_isert.h | 41 ++++++++---
>  2 files changed, 79 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index 61e2f7fc513d..5b6a0ad9faaa 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -140,15 +140,16 @@ isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
>  	rx_desc = isert_conn->rx_descs;
>  
>  	for (i = 0; i < ISERT_QP_MAX_RECV_DTOS; i++, rx_desc++)  {
> -		dma_addr = ib_dma_map_single(ib_dev, (void *)rx_desc,
> -					ISER_RX_PAYLOAD_SIZE, DMA_FROM_DEVICE);
> +		dma_addr = ib_dma_map_single(ib_dev,
> +					rx_desc->buf,

Nit: no real need to the line break here.

> +	ib_dma_unmap_single(ib_dev, isert_conn->login_desc->dma_addr,
> +			    ISER_RX_SIZE,
>  			    DMA_FROM_DEVICE);

Same here.

> + * RX size is default of 8k plus headers, but data needs to align to
> + * 512 boundary, so use 1024 to have the extra space for alignment.
> + */
> +#define ISER_RX_SIZE		(ISCSI_DEF_MAX_RECV_SEG_LEN + 1024)

A 512 byte alignment is not the correct for e.g. the 4k Xen block
device case.  Any reason we don't just separate allocations for headers
vs the data and use another ib_sge?
