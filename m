Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC87EF26E
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Nov 2023 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjKQMOD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Nov 2023 07:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKQMOC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Nov 2023 07:14:02 -0500
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA808E
        for <linux-rdma@vger.kernel.org>; Fri, 17 Nov 2023 04:13:58 -0800 (PST)
Message-ID: <093f16a6-2948-4103-8d27-ea349aa6909c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700223237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asjkVDdwWhmdLNY4MUxyBFhvSyZT8OS6vZWZOv/z/sw=;
        b=dPu+oqv4MDUCNPiEOlkDU/x5azT1pveEH+yGCCRbHx4OEFwJhWxZnOIeNYy4Wl/c2zQUNG
        60IlxoXSNblRziTrMRXoMk1/qRb3Fcqx0LccZZs7heCZah6V0r9HvVFne4QHCn0eRFb28X
        AXeOYAioascei6/2yDvJsgWtMMj55+s=
Date:   Fri, 17 Nov 2023 20:13:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE is
 greater then HCA pgsz
To:     Shiraz Saleem <shiraz.saleem@intel.com>, jgg@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>
References: <20231115191752.266-1-shiraz.saleem@intel.com>
 <20231115191752.266-2-shiraz.saleem@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231115191752.266-2-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/11/16 3:17, Shiraz Saleem 写道:
> From: Mike Marciniszyn <mike.marciniszyn@intel.com>
> 
> 64k pages introduce the situation in this diagram when the HCA

Only ARM64 architecture supports 64K page size?
Is it possible that x86_64 also supports 64K page size?

Zhu Yanjun

> 4k page size is being used:
> 
>   +-------------------------------------------+ <--- 64k aligned VA
>   |                                           |
>   |              HCA 4k page                  |
>   |                                           |
>   +-------------------------------------------+
>   |                   o                       |
>   |                                           |
>   |                   o                       |
>   |                                           |
>   |                   o                       |
>   +-------------------------------------------+
>   |                                           |
>   |              HCA 4k page                  |
>   |                                           |
>   +-------------------------------------------+ <--- Live HCA page
>   |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO| <--- offset
>   |                                           | <--- VA
>   |                MR data                    |
>   +-------------------------------------------+
>   |                                           |
>   |              HCA 4k page                  |
>   |                                           |
>   +-------------------------------------------+
>   |                   o                       |
>   |                                           |
>   |                   o                       |
>   |                                           |
>   |                   o                       |
>   +-------------------------------------------+
>   |                                           |
>   |              HCA 4k page                  |
>   |                                           |
>   +-------------------------------------------+
> 
> The VA addresses are coming from rdma-core in this diagram can
> be arbitrary, but for 64k pages, the VA may be offset by some
> number of HCA 4k pages and followed by some number of HCA 4k
> pages.
> 
> The current iterator doesn't account for either the preceding
> 4k pages or the following 4k pages.
> 
> Fix the issue by extending the ib_block_iter to contain
> the number of DMA pages like comment [1] says and
> by augmenting the macro limit test to downcount that value.
> 
> This prevents the extra pages following the user MR data.
> 
> Fix the preceding pages by using the __sq_advance field to start
> at the first 4k page containing MR data.
> 
> This fix allows for the elimination of the small page crutch noted
> in the Fixes.
> 
> Fixes: 10c75ccb54e4 ("RDMA/umem: Prevent small pages from being returned by ib_umem_find_best_pgsz()")
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/rdma/ib_umem.h#n91 [1]
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>   drivers/infiniband/core/umem.c | 6 ------
>   include/rdma/ib_umem.h         | 4 +++-
>   include/rdma/ib_verbs.h        | 1 +
>   3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index f9ab671c8eda..07c571c7b699 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -96,12 +96,6 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>   		return page_size;
>   	}
>   
> -	/* rdma_for_each_block() has a bug if the page size is smaller than the
> -	 * page size used to build the umem. For now prevent smaller page sizes
> -	 * from being returned.
> -	 */
> -	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
> -
>   	/* The best result is the smallest page size that results in the minimum
>   	 * number of required pages. Compute the largest page size that could
>   	 * work based on VA address bits that don't change.
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index 95896472a82b..e775d1b4910c 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -77,6 +77,8 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
>   {
>   	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
>   				umem->sgt_append.sgt.nents, pgsz);
> +	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
> +	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
>   }
>   
>   /**
> @@ -92,7 +94,7 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
>    */
>   #define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
>   	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
> -	     __rdma_block_iter_next(biter);)
> +	     __rdma_block_iter_next(biter) && (biter)->__sg_numblocks--;)
>   
>   #ifdef CONFIG_INFINIBAND_USER_MEM
>   
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index fb1a2d6b1969..b7b6b58dd348 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2850,6 +2850,7 @@ struct ib_block_iter {
>   	/* internal states */
>   	struct scatterlist *__sg;	/* sg holding the current aligned block */
>   	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
> +	size_t __sg_numblocks;		/* ib_umem_num_dma_blocks() */
>   	unsigned int __sg_nents;	/* number of SG entries */
>   	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
>   	unsigned int __pg_bit;		/* alignment of current block */

