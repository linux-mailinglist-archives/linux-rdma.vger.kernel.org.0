Return-Path: <linux-rdma+bounces-3678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641BD928FAE
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jul 2024 02:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020C5284027
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jul 2024 00:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02410819;
	Sat,  6 Jul 2024 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wdpt0JKL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87572595
	for <linux-rdma@vger.kernel.org>; Sat,  6 Jul 2024 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720225012; cv=none; b=MKLzNVRVOoz0XhsAu5Loi4s6hlTKezuB0AxupHKUCYQDZBmUU8JDBS5oSWTgk5PU9pKm9vREjpNY0ipUr8noao5aV4EAOVto/RRx9v2KRPIqj4rSaZl+fyuBY9TDAbn5FaMkr+0GJ079Uils1l/Wps6mt/xpKXFC6NxoOW3W/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720225012; c=relaxed/simple;
	bh=izqY4Tu9n5GG7hK7dFDDvVo+38YCXlXOHko1OKYuvcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8pHdEUpYm5n2H1amFtZHRE3CnZ4Jax/lNRD+byczl1FutDVjLywVbUF3G+7nN9bpp2CR7SsAH00ALx5DwbziZ5/Gz8bMUCm2lw8NUmlO+puTRT/940f8WfPtRclixgN9FWToqRfxQOkNhZcmMq0o7ixs/Wt3s0shF63wY7foP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wdpt0JKL; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: anumula@chelsio.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720225006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkdIw0urR+OykNZ7ebQ1OpK8yAKeHHf5BZ61+76IsCY=;
	b=Wdpt0JKLyGzOMpSSYE7d0v0lAz2cMHY2Toe7/dauQCCTppCSB36XM6/v7Qv8YxQHpKgs+P
	ZCn8EM2mdGHTGcXfx/Rhl5eE9B/0KpFztpUnLTHr0srXLFtjy2tCH/9U8GKXG5qjPHUBpr
	2WCeZfjMRsQAPvTjYBej/AQJ7/MQvPc=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: leonro@nvidia.com
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: bharat@chelsio.com
X-Envelope-To: linux-mm@kvack.org
Message-ID: <91a12ee0-d30e-42f0-82fc-e06f6ffd5700@linux.dev>
Date: Sat, 6 Jul 2024 08:16:35 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/cxgb4: use dma_mmap_coherent() for mapping
 non-contiguous memory
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>, jgg@nvidia.com,
 leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <20240705131753.15550-1-anumula@chelsio.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240705131753.15550-1-anumula@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/5 21:17, Anumula Murali Mohan Reddy 写道:
> dma_alloc_coherent() allocates contiguous memory irrespective of
> iommu mode, but after commit f5ff79fddf0e ("dma-mapping: remove
> CONFIG_DMA_REMAP") if iommu is enabled in translate mode,

CC linux-mm@kvack.org

Zhu Yanjun

> dma_alloc_coherent() may allocate non-contiguous memory.
> Attempt to map this memory results in panic.
> This patch fixes the issue by using dma_mmap_coherent() to map each page
> to user space.
> 
> Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>   drivers/infiniband/hw/cxgb4/cq.c       |  4 +++
>   drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  2 ++
>   drivers/infiniband/hw/cxgb4/provider.c | 48 +++++++++++++++++++++-----
>   drivers/infiniband/hw/cxgb4/qp.c       | 14 ++++++++
>   4 files changed, 59 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
> index 5111421f9473..81cfc876fa89 100644
> --- a/drivers/infiniband/hw/cxgb4/cq.c
> +++ b/drivers/infiniband/hw/cxgb4/cq.c
> @@ -1127,12 +1127,16 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   
>   		mm->key = uresp.key;
>   		mm->addr = virt_to_phys(chp->cq.queue);
> +		mm->vaddr = chp->cq.queue;
> +		mm->dma_addr = chp->cq.dma_addr;
>   		mm->len = chp->cq.memsize;
>   		insert_mmap(ucontext, mm);
>   
>   		mm2->key = uresp.gts_key;
>   		mm2->addr = chp->cq.bar2_pa;
>   		mm2->len = PAGE_SIZE;
> +		mm2->vaddr = NULL;
> +		mm2->dma_addr = 0;
>   		insert_mmap(ucontext, mm2);
>   	}
>   
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> index f838bb6718af..5eedc6cf0f8c 100644
> --- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -536,6 +536,8 @@ struct c4iw_mm_entry {
>   	struct list_head entry;
>   	u64 addr;
>   	u32 key;
> +	void *vaddr;
> +	dma_addr_t dma_addr;
>   	unsigned len;
>   };
>   
> diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
> index 246b739ddb2b..6227775970c9 100644
> --- a/drivers/infiniband/hw/cxgb4/provider.c
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -131,6 +131,10 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>   	struct c4iw_mm_entry *mm;
>   	struct c4iw_ucontext *ucontext;
>   	u64 addr;
> +	size_t size;
> +	void *vaddr;
> +	unsigned long vm_pgoff;
> +	dma_addr_t dma_addr;
>   
>   	pr_debug("pgoff 0x%lx key 0x%x len %d\n", vma->vm_pgoff,
>   		 key, len);
> @@ -145,6 +149,9 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>   	if (!mm)
>   		return -EINVAL;
>   	addr = mm->addr;
> +	vaddr = mm->vaddr;
> +	dma_addr = mm->dma_addr;
> +	size = mm->len;
>   	kfree(mm);
>   
>   	if ((addr >= pci_resource_start(rdev->lldi.pdev, 0)) &&
> @@ -155,9 +162,17 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>   		 * MA_SYNC register...
>   		 */
>   		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
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
>   	} else if ((addr >= pci_resource_start(rdev->lldi.pdev, 2)) &&
>   		   (addr < (pci_resource_start(rdev->lldi.pdev, 2) +
>   		    pci_resource_len(rdev->lldi.pdev, 2)))) {
> @@ -175,17 +190,32 @@ static int c4iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>   				vma->vm_page_prot =
>   					pgprot_noncached(vma->vm_page_prot);
>   		}
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
>   	} else {
>   
>   		/*
>   		 * Map WQ or CQ contig dma memory...
>   		 */
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
>   	}
>   
>   	return ret;
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index d16d8eaa1415..3f6fb4b34d5a 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -2282,16 +2282,22 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
>   			goto err_free_ma_sync_key;
>   		sq_key_mm->key = uresp.sq_key;
>   		sq_key_mm->addr = qhp->wq.sq.phys_addr;
> +		sq_key_mm->vaddr = qhp->wq.sq.queue;
> +		sq_key_mm->dma_addr = qhp->wq.sq.dma_addr;
>   		sq_key_mm->len = PAGE_ALIGN(qhp->wq.sq.memsize);
>   		insert_mmap(ucontext, sq_key_mm);
>   		if (!attrs->srq) {
>   			rq_key_mm->key = uresp.rq_key;
>   			rq_key_mm->addr = virt_to_phys(qhp->wq.rq.queue);
> +			rq_key_mm->vaddr = qhp->wq.rq.queue;
> +			rq_key_mm->dma_addr = qhp->wq.rq.dma_addr;
>   			rq_key_mm->len = PAGE_ALIGN(qhp->wq.rq.memsize);
>   			insert_mmap(ucontext, rq_key_mm);
>   		}
>   		sq_db_key_mm->key = uresp.sq_db_gts_key;
>   		sq_db_key_mm->addr = (u64)(unsigned long)qhp->wq.sq.bar2_pa;
> +		sq_db_key_mm->vaddr = NULL;
> +		sq_db_key_mm->dma_addr = 0;
>   		sq_db_key_mm->len = PAGE_SIZE;
>   		insert_mmap(ucontext, sq_db_key_mm);
>   		if (!attrs->srq) {
> @@ -2299,6 +2305,8 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
>   			rq_db_key_mm->addr =
>   				(u64)(unsigned long)qhp->wq.rq.bar2_pa;
>   			rq_db_key_mm->len = PAGE_SIZE;
> +			rq_db_key_mm->vaddr = NULL;
> +			rq_db_key_mm->dma_addr = 0;
>   			insert_mmap(ucontext, rq_db_key_mm);
>   		}
>   		if (ma_sync_key_mm) {
> @@ -2307,6 +2315,8 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
>   				(pci_resource_start(rhp->rdev.lldi.pdev, 0) +
>   				PCIE_MA_SYNC_A) & PAGE_MASK;
>   			ma_sync_key_mm->len = PAGE_SIZE;
> +			ma_sync_key_mm->vaddr = NULL;
> +			ma_sync_key_mm->dma_addr = 0;
>   			insert_mmap(ucontext, ma_sync_key_mm);
>   		}
>   
> @@ -2763,10 +2773,14 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
>   		srq_key_mm->key = uresp.srq_key;
>   		srq_key_mm->addr = virt_to_phys(srq->wq.queue);
>   		srq_key_mm->len = PAGE_ALIGN(srq->wq.memsize);
> +		srq_key_mm->vaddr = srq->wq.queue;
> +		srq_key_mm->dma_addr = srq->wq.dma_addr;
>   		insert_mmap(ucontext, srq_key_mm);
>   		srq_db_key_mm->key = uresp.srq_db_gts_key;
>   		srq_db_key_mm->addr = (u64)(unsigned long)srq->wq.bar2_pa;
>   		srq_db_key_mm->len = PAGE_SIZE;
> +		srq_db_key_mm->vaddr = NULL;
> +		srq_db_key_mm->dma_addr = 0;
>   		insert_mmap(ucontext, srq_db_key_mm);
>   	}
>   


