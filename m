Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31926C8B8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgIPS4d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgIPRyS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Sep 2020 13:54:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE278C0A8894
        for <linux-rdma@vger.kernel.org>; Wed, 16 Sep 2020 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3CHtfZDaxWEuMcO840xucd5DgR0D556QzSuFJuencHE=; b=FIKMPLuIc6fA0ZUm9AZML6Zu65
        V1Od54y58JmMoa2ySTXN0Me/Qy2FIknxX0MvNHfGHWGiAUdP4YVp4HCV7so44/gbB7PmG6hY6lLy5
        /kxBcDUAoykzaMz5sSc1bwhRmIWRh4s5DGtNQEcLJ3jnsntU3vFiNjBFU77kV6QX4ptEbnkXkUoCm
        B0hgyzhNUx7/tk8eXpDUH+vuXgPQ3K0g0qbaU+mSpcHmlJtlyC8NNspYngWm3EU3wCj6U4P1gQh1s
        AbBTzVnzu8J4RpCa34fgpMQheB39JNNDf/GAauQe0DctZeHbNWGaWDPffbM0r8lRcbV5x+YKLSxgD
        g8uFg2Pg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIaYW-00046Z-Hk; Wed, 16 Sep 2020 16:45:16 +0000
Date:   Wed, 16 Sep 2020 17:45:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200916164516.GA11582@infradead.org>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914113949.346562-2-leon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> In addition,
> Moving to use the HMM enables to reduce page faults in the system as it
> exposes the snapshot mode, this will be introduced in next patches from
> this series.
> 
> As part of this cleanup some flows and use the required data structures
> to work with HMM.

Just saying HMM here seems weird.  The function is hmm_range_fault.
And it really needs to grow a better name eventually..

>  		unsigned long start;
>  		unsigned long end;
> -		size_t pages;
> +		size_t ndmas, npfns;
>  
>  		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
>  		if (check_add_overflow(umem_odp->umem.address,
> @@ -71,20 +72,21 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>  		if (unlikely(end < page_size))
>  			return -EOVERFLOW;
>  
> -		pages = (end - start) >> umem_odp->page_shift;
> -		if (!pages)
> +		ndmas = (end - start) >> umem_odp->page_shift;
> +		if (!ndmas)
>  			return -EINVAL;
>  
> -		umem_odp->page_list = kvcalloc(
> -			pages, sizeof(*umem_odp->page_list), GFP_KERNEL);
> -		if (!umem_odp->page_list)
> +		npfns = (end - start) >> PAGE_SHIFT;
> +		umem_odp->pfn_list = kvcalloc(
> +			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
> +		if (!umem_odp->pfn_list)
>  			return -ENOMEM;
>  
>  		umem_odp->dma_list = kvcalloc(
> -			pages, sizeof(*umem_odp->dma_list), GFP_KERNEL);
> +			ndmas, sizeof(*umem_odp->dma_list), GFP_KERNEL);
>  		if (!umem_odp->dma_list) {
>  			ret = -ENOMEM;
> -			goto out_page_list;
> +			goto out_pfn_list;

Why do you rename these variables?  We're still mapping pages.

>  static int ib_umem_odp_map_dma_single_page(
>  		struct ib_umem_odp *umem_odp,
> +		unsigned int dma_index,
>  		struct page *page,
> +		u64 access_mask)
>  {
>  	struct ib_device *dev = umem_odp->umem.ibdev;
>  	dma_addr_t dma_addr;
>  
> +	if (umem_odp->dma_list[dma_index]) {

Note that 0 is a valid DMA address.  I think due the access bit this
works, but it is a little subtle..

> +		umem_odp->dma_list[dma_index] &= ODP_DMA_ADDR_MASK;
> +		umem_odp->dma_list[dma_index] |= access_mask;

This looks a little weird.  Instead of &= ODP_DMA_ADDR_MASK I'd do a
&= ~ACCESS_MASK as that makes the code a lot more logical.

But more importantly except for (dma_addr_t)-1 (DMA_MAPPING_ERROR)
all dma_addr_t values are valid, so taking more than a single bit
from a dma_addr_t is not strictly speaking correct.

> +		return 0;
>  	}
>  
> +	dma_addr =
> +		ib_dma_map_page(dev, page, 0, BIT(umem_odp->page_shift),
> +				DMA_BIDIRECTIONAL);

The use of the BIT macro which is already obsfucating in its intended
place is really out of place here.

> +	if (ib_dma_mapping_error(dev, dma_addr))
> +		return -EFAULT;
> +
> +	umem_odp->dma_list[dma_index] = dma_addr | access_mask;
> +	umem_odp->npages++;
> +	return 0;

I'd change the calling conventions and write the whole thing as:

static int ib_umem_odp_map_dma_single_page(struct ib_umem_odp *umem_odp
		unsigned int dma_index, struct page *page, u64 access_mask)
{
 	struct ib_device *dev = umem_odp->umem.ibdev;
	dma_addr_t *dma_addr = &umem_odp->dma_list[dma_index];

	if (!dma_addr) {
		*dma_addr = ib_dma_map_page(dev, page, 0,
				1 << umem_odp->page_shift,
				DMA_BIDIRECTIONAL);
		if (ib_dma_mapping_error(dev, *dma_addr))
			return -EFAULT;
		umem_odp->npages++;
	}
	*dma_addr &= ~ODP_ACCESS_MASK;
	*dma_addr |= access_mask;
	return 0;
}

> +	/*
> +	 * No need to check whether the MTTs really belong to
> +	 * this MR, since ib_umem_odp_map_dma_and_lock already
> +	 * checks this.
> +	 */

You could easily squeeze the three lines into two while still staying
under 80 characters for each line.
