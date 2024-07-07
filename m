Return-Path: <linux-rdma+bounces-3688-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6387E92973A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 11:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B54B20E76
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963CCA40;
	Sun,  7 Jul 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgdZw3K6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A56FBE
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720343470; cv=none; b=QgE82ATEuvH2VTIf/Baqxpb9SC2Cjlvbmmf/GuXyCylV3WmcLQHLV/mINpVuSKjUugTRUsoltM43kvdprwmMVppvlb99WBO1i0NFBzP0jP4dnh5TQfY0jnOcMNk9bbRWHA41XZMCkfBzMyA0JFJBmdkgkNDbS5Rd96LyxUxmfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720343470; c=relaxed/simple;
	bh=6dgoW+To+ceJuoSsYT0lmRxZBOOavdNeMJtf8MbF+Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J725PDjz9+BFTqThZ1Vrztn6LCmWghxgXB0Ye9G8L08UkUMBt7Q54xnVoglnRL/JBiRaQSzm6XIgRZB4aXL9fh1eZOJ0NpWFDTSU1/gezQsMg6TF88DYh9153gT1D946h2lt/fA+0RyIiAQZj1mLouagNYGdzoBbSqmRJyRWdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgdZw3K6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9593AC3277B;
	Sun,  7 Jul 2024 09:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720343470;
	bh=6dgoW+To+ceJuoSsYT0lmRxZBOOavdNeMJtf8MbF+Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgdZw3K6k0zP5YjLlcu3VUQQ5EmUNXZf7JxQQRMPP7UtFR0XXm00OmcehSYks13yW
	 U3sjpgtAWLhmz0oodYdn4UKfwPSFBc6WxjK5k5LJD+2fszbUB3GVLTAeDyqEIgEej/
	 yi+5zQuweMhyEKjEYPAp4WaiRM0C/eeEVu2LLc2ETE7irccFc9V9WRVsDdyDTM8NQu
	 TCh0FuVmqHslndvk9mReJgBmxfmOAJb2DgjnGslx6oP3nfi31kUrt4LWW/x5IwMvkG
	 1OYTPN4pj6uWbSF1rrFAzgaOSLP3CbIda+w6vHbEXDUCQ1PAy1wabvFym7e6BFh2hu
	 doZ8uW40w/gVg==
Date: Sun, 7 Jul 2024 12:11:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH for-next] RDMA/cxgb4: use dma_mmap_coherent() for mapping
 non-contiguous memory
Message-ID: <20240707091105.GG6695@unreal>
References: <20240705131753.15550-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705131753.15550-1-anumula@chelsio.com>

On Fri, Jul 05, 2024 at 06:47:53PM +0530, Anumula Murali Mohan Reddy wrote:
> dma_alloc_coherent() allocates contiguous memory irrespective of
> iommu mode, but after commit f5ff79fddf0e ("dma-mapping: remove
> CONFIG_DMA_REMAP") if iommu is enabled in translate mode,
> dma_alloc_coherent() may allocate non-contiguous memory.
> Attempt to map this memory results in panic.
> This patch fixes the issue by using dma_mmap_coherent() to map each page
> to user space.

It is perfect time to move to use rdma_user_mmap_io(), instead of
open-code it in the driver.

> 
> Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")

+ authors of the commit mentioned in Fixes.

Thanks

> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cq.c       |  4 +++
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  2 ++
>  drivers/infiniband/hw/cxgb4/provider.c | 48 +++++++++++++++++++++-----
>  drivers/infiniband/hw/cxgb4/qp.c       | 14 ++++++++
>  4 files changed, 59 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
> index 5111421f9473..81cfc876fa89 100644
> --- a/drivers/infiniband/hw/cxgb4/cq.c
> +++ b/drivers/infiniband/hw/cxgb4/cq.c
> @@ -1127,12 +1127,16 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  
>  		mm->key = uresp.key;
>  		mm->addr = virt_to_phys(chp->cq.queue);
> +		mm->vaddr = chp->cq.queue;
> +		mm->dma_addr = chp->cq.dma_addr;
>  		mm->len = chp->cq.memsize;
>  		insert_mmap(ucontext, mm);
>  
>  		mm2->key = uresp.gts_key;
>  		mm2->addr = chp->cq.bar2_pa;
>  		mm2->len = PAGE_SIZE;
> +		mm2->vaddr = NULL;
> +		mm2->dma_addr = 0;
>  		insert_mmap(ucontext, mm2);
>  	}
>  
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> index f838bb6718af..5eedc6cf0f8c 100644
> --- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -536,6 +536,8 @@ struct c4iw_mm_entry {
>  	struct list_head entry;
>  	u64 addr;
>  	u32 key;
> +	void *vaddr;
> +	dma_addr_t dma_addr;
>  	unsigned len;
>  };
>  
> diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
> index 246b739ddb2b..6227775970c9 100644
> --- a/drivers/infiniband/hw/cxgb4/provider.c
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -131,6 +131,10 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  	struct c4iw_mm_entry *mm;
>  	struct c4iw_ucontext *ucontext;
>  	u64 addr;
> +	size_t size;
> +	void *vaddr;
> +	unsigned long vm_pgoff;
> +	dma_addr_t dma_addr;
>  
>  	pr_debug("pgoff 0x%lx key 0x%x len %d\n", vma->vm_pgoff,
>  		 key, len);
> @@ -145,6 +149,9 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  	if (!mm)
>  		return -EINVAL;
>  	addr = mm->addr;
> +	vaddr = mm->vaddr;
> +	dma_addr = mm->dma_addr;
> +	size = mm->len;
>  	kfree(mm);
>  
>  	if ((addr >= pci_resource_start(rdev->lldi.pdev, 0)) &&
> @@ -155,9 +162,17 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  		 * MA_SYNC register...
>  		 */
>  		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -		ret = io_remap_pfn_range(vma, vma->vm_start,
> -					 addr >> PAGE_SHIFT,
> -					 len, vma->vm_page_prot);
> +		if (vaddr && is_vmalloc_addr(vaddr)) {
> +			vm_pgoff = vma->vm_pgoff;
> +			vma->vm_pgoff = 0;
> +			ret = dma_mmap_coherent(&rdev->lldi.pdev->dev, vma,
> +						vaddr, dma_addr, size);
> +			vma->vm_pgoff = vm_pgoff;
> +		} else {
> +			ret = io_remap_pfn_range(vma, vma->vm_start,
> +						 addr >> PAGE_SHIFT,
> +						 len, vma->vm_page_prot);
> +		}
>  	} else if ((addr >= pci_resource_start(rdev->lldi.pdev, 2)) &&
>  		   (addr < (pci_resource_start(rdev->lldi.pdev, 2) +
>  		    pci_resource_len(rdev->lldi.pdev, 2)))) {
> @@ -175,17 +190,32 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  				vma->vm_page_prot =
>  					pgprot_noncached(vma->vm_page_prot);
>  		}
> -		ret = io_remap_pfn_range(vma, vma->vm_start,
> -					 addr >> PAGE_SHIFT,
> -					 len, vma->vm_page_prot);
> +		if (vaddr && is_vmalloc_addr(vaddr)) {
> +			vm_pgoff = vma->vm_pgoff;
> +			vma->vm_pgoff = 0;
> +			ret = dma_mmap_coherent(&rdev->lldi.pdev->dev, vma,
> +						vaddr, dma_addr, size);
> +			vma->vm_pgoff = vm_pgoff;
> +		} else {
> +			ret = io_remap_pfn_range(vma, vma->vm_start,
> +						 addr >> PAGE_SHIFT,
> +						 len, vma->vm_page_prot);
> +		}
>  	} else {
>  
>  		/*
>  		 * Map WQ or CQ contig dma memory...
>  		 */
> -		ret = remap_pfn_range(vma, vma->vm_start,
> -				      addr >> PAGE_SHIFT,
> -				      len, vma->vm_page_prot);
> +		if (vaddr && is_vmalloc_addr(vaddr)) {
> +			vm_pgoff = vma->vm_pgoff;
> +			vma->vm_pgoff = 0;
> +			ret = dma_mmap_coherent(&rdev->lldi.pdev->dev, vma,
> +						vaddr, dma_addr, size);
> +		} else {
> +			ret = remap_pfn_range(vma, vma->vm_start,
> +					      addr >> PAGE_SHIFT,
> +					      len, vma->vm_page_prot);
> +		}
>  	}
>  
>  	return ret;
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index d16d8eaa1415..3f6fb4b34d5a 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -2282,16 +2282,22 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
>  			goto err_free_ma_sync_key;
>  		sq_key_mm->key = uresp.sq_key;
>  		sq_key_mm->addr = qhp->wq.sq.phys_addr;
> +		sq_key_mm->vaddr = qhp->wq.sq.queue;
> +		sq_key_mm->dma_addr = qhp->wq.sq.dma_addr;
>  		sq_key_mm->len = PAGE_ALIGN(qhp->wq.sq.memsize);
>  		insert_mmap(ucontext, sq_key_mm);
>  		if (!attrs->srq) {
>  			rq_key_mm->key = uresp.rq_key;
>  			rq_key_mm->addr = virt_to_phys(qhp->wq.rq.queue);
> +			rq_key_mm->vaddr = qhp->wq.rq.queue;
> +			rq_key_mm->dma_addr = qhp->wq.rq.dma_addr;
>  			rq_key_mm->len = PAGE_ALIGN(qhp->wq.rq.memsize);
>  			insert_mmap(ucontext, rq_key_mm);
>  		}
>  		sq_db_key_mm->key = uresp.sq_db_gts_key;
>  		sq_db_key_mm->addr = (u64)(unsigned long)qhp->wq.sq.bar2_pa;
> +		sq_db_key_mm->vaddr = NULL;
> +		sq_db_key_mm->dma_addr = 0;
>  		sq_db_key_mm->len = PAGE_SIZE;
>  		insert_mmap(ucontext, sq_db_key_mm);
>  		if (!attrs->srq) {
> @@ -2299,6 +2305,8 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
>  			rq_db_key_mm->addr =
>  				(u64)(unsigned long)qhp->wq.rq.bar2_pa;
>  			rq_db_key_mm->len = PAGE_SIZE;
> +			rq_db_key_mm->vaddr = NULL;
> +			rq_db_key_mm->dma_addr = 0;
>  			insert_mmap(ucontext, rq_db_key_mm);
>  		}
>  		if (ma_sync_key_mm) {
> @@ -2307,6 +2315,8 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
>  				(pci_resource_start(rhp->rdev.lldi.pdev, 0) +
>  				PCIE_MA_SYNC_A) & PAGE_MASK;
>  			ma_sync_key_mm->len = PAGE_SIZE;
> +			ma_sync_key_mm->vaddr = NULL;
> +			ma_sync_key_mm->dma_addr = 0;
>  			insert_mmap(ucontext, ma_sync_key_mm);
>  		}
>  
> @@ -2763,10 +2773,14 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
>  		srq_key_mm->key = uresp.srq_key;
>  		srq_key_mm->addr = virt_to_phys(srq->wq.queue);
>  		srq_key_mm->len = PAGE_ALIGN(srq->wq.memsize);
> +		srq_key_mm->vaddr = srq->wq.queue;
> +		srq_key_mm->dma_addr = srq->wq.dma_addr;
>  		insert_mmap(ucontext, srq_key_mm);
>  		srq_db_key_mm->key = uresp.srq_db_gts_key;
>  		srq_db_key_mm->addr = (u64)(unsigned long)srq->wq.bar2_pa;
>  		srq_db_key_mm->len = PAGE_SIZE;
> +		srq_db_key_mm->vaddr = NULL;
> +		srq_db_key_mm->dma_addr = 0;
>  		insert_mmap(ucontext, srq_db_key_mm);
>  	}
>  
> -- 
> 2.39.3
> 
> 

