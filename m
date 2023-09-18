Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475097A494B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbjIRMKM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 08:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbjIRMKA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 08:10:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E1DC6
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 05:09:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A04C433C9;
        Mon, 18 Sep 2023 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695038976;
        bh=oTjfXWfAH+/78G1wH3Dn9sVYxdch78sst78fJFHSLeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HblJTSQLIwEx27PCvBSvpEyIngNhyGcCJBrr2GGyqLSyCl5sFgzzYTesnS5nUE8Iu
         W6prOpdXg9NevaHMG3PzJFg9GJqDhKd/jbLRqdIcovaL0amlwbbcIgdcNrfOarxRNo
         /ILVCY/HRlhrn/7oLpZZ6k+K7upvhWgG0F+ZUH7QM/kM7uh3hqfkPFAtoUaID6vDT9
         uUDrjaItPkeC8mTY31ykkvaoaeAsuvmq4CDr7c8prfG47Uy0ZEM2aEvGeKbAIX2J9y
         XOPXzHRmLtzXVm5HGbbzRbLVWreu9TsfzS22skKmvr0MPNcmcM8QtunrAcFaqG+EoK
         1yF1XJT/ADg9Q==
Date:   Mon, 18 Sep 2023 15:09:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Maxim Samoylov <max7255@meta.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH] IB: fix memlock limit handling code
Message-ID: <20230918120932.GC103601@unreal>
References: <20230915200353.1238097-1-max7255@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915200353.1238097-1-max7255@meta.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 15, 2023 at 01:03:53PM -0700, Maxim Samoylov wrote:
> This patch fixes handling for RLIM_INFINITY value uniformly across
> the infiniband/rdma subsystem.
> 
> Currently infinity constant is treated as actual limit
> value, which can trigger unexpected ENOMEM errors in
> corner-case configurations

Can you please provide an example and why these corner cases are
important?

BTW, The patch looks good to me, just need more information in commit message.

Thanks


> 
> Let's also provide the single helper to check against process
> MEMLOCK limit while registering user memory region mappings.
> 
> Signed-off-by: Maxim Samoylov <max7255@meta.com>
> ---
>  drivers/infiniband/core/umem.c             |  7 ++-----
>  drivers/infiniband/hw/qib/qib_user_pages.c |  7 +++----
>  drivers/infiniband/hw/usnic/usnic_uiom.c   |  6 ++----
>  drivers/infiniband/sw/siw/siw_mem.c        |  6 +++---
>  drivers/infiniband/sw/siw/siw_verbs.c      | 23 ++++++++++------------
>  include/rdma/ib_umem.h                     | 11 +++++++++++
>  6 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index f9ab671c8eda..3b197bdc21bf 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -35,12 +35,12 @@
>  
>  #include <linux/mm.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/pagemap.h>
>  #include <linux/count_zeros.h>
> +#include <rdma/ib_umem.h>
>  #include <rdma/ib_umem_odp.h>
>  
>  #include "uverbs.h"
> @@ -150,7 +150,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>  {
>  	struct ib_umem *umem;
>  	struct page **page_list;
> -	unsigned long lock_limit;
>  	unsigned long new_pinned;
>  	unsigned long cur_base;
>  	unsigned long dma_attr = 0;
> @@ -200,10 +199,8 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>  		goto out;
>  	}
>  
> -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -
>  	new_pinned = atomic64_add_return(npages, &mm->pinned_vm);
> -	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
> +	if (!ib_umem_check_rlimit_memlock(new_pinned)) {
>  		atomic64_sub(npages, &mm->pinned_vm);
>  		ret = -ENOMEM;
>  		goto out;
> diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
> index 1bb7507325bc..3889aefdfc6b 100644
> --- a/drivers/infiniband/hw/qib/qib_user_pages.c
> +++ b/drivers/infiniband/hw/qib/qib_user_pages.c
> @@ -32,8 +32,8 @@
>   */
>  
>  #include <linux/mm.h>
> -#include <linux/sched/signal.h>
>  #include <linux/device.h>
> +#include <rdma/ib_umem.h>
>  
>  #include "qib.h"
>  
> @@ -94,14 +94,13 @@ int qib_map_page(struct pci_dev *hwdev, struct page *page, dma_addr_t *daddr)
>  int qib_get_user_pages(unsigned long start_page, size_t num_pages,
>  		       struct page **p)
>  {
> -	unsigned long locked, lock_limit;
> +	unsigned long locked;
>  	size_t got;
>  	int ret;
>  
> -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  	locked = atomic64_add_return(num_pages, &current->mm->pinned_vm);
>  
> -	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> +	if (!ib_umem_check_rlimit_memlock(locked)) {
>  		ret = -ENOMEM;
>  		goto bail;
>  	}
> diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
> index 84e0f41e7dfa..fdbb9737c7f0 100644
> --- a/drivers/infiniband/hw/usnic/usnic_uiom.c
> +++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
> @@ -34,13 +34,13 @@
>  
>  #include <linux/mm.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/hugetlb.h>
>  #include <linux/iommu.h>
>  #include <linux/workqueue.h>
>  #include <linux/list.h>
>  #include <rdma/ib_verbs.h>
> +#include <rdma/ib_umem.h>
>  
>  #include "usnic_log.h"
>  #include "usnic_uiom.h"
> @@ -90,7 +90,6 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
>  	struct scatterlist *sg;
>  	struct usnic_uiom_chunk *chunk;
>  	unsigned long locked;
> -	unsigned long lock_limit;
>  	unsigned long cur_base;
>  	unsigned long npages;
>  	int ret;
> @@ -124,9 +123,8 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
>  	mmap_read_lock(mm);
>  
>  	locked = atomic64_add_return(npages, &current->mm->pinned_vm);
> -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  
> -	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
> +	if (!ib_umem_check_rlimit_memlock(locked)) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index e6e25f15567d..54991ddeabc7 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/gfp.h>
>  #include <rdma/ib_verbs.h>
> +#include <rdma/ib_umem.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/sched/mm.h>
> @@ -367,7 +368,6 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  	struct siw_umem *umem;
>  	struct mm_struct *mm_s;
>  	u64 first_page_va;
> -	unsigned long mlock_limit;
>  	unsigned int foll_flags = FOLL_LONGTERM;
>  	int num_pages, num_chunks, i, rv = 0;
>  
> @@ -396,9 +396,9 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  
>  	mmap_read_lock(mm_s);
>  
> -	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  
> -	if (atomic64_add_return(num_pages, &mm_s->pinned_vm) > mlock_limit) {
> +	if (!ib_umem_check_rlimit_memlock(
> +		atomic64_add_return(num_pages, &mm_s->pinned_vm))) {
>  		rv = -ENOMEM;
>  		goto out_sem_up;
>  	}
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index fdbef3254e30..ad63a8db5502 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -12,6 +12,7 @@
>  
>  #include <rdma/iw_cm.h>
>  #include <rdma/ib_verbs.h>
> +#include <rdma/ib_umem.h>
>  #include <rdma/ib_user_verbs.h>
>  #include <rdma/uverbs_ioctl.h>
>  
> @@ -1321,8 +1322,8 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  	struct siw_umem *umem = NULL;
>  	struct siw_ureq_reg_mr ureq;
>  	struct siw_device *sdev = to_siw_dev(pd->device);
> -
> -	unsigned long mem_limit = rlimit(RLIMIT_MEMLOCK);
> +	unsigned long num_pages =
> +		(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
>  	int rv;
>  
>  	siw_dbg_pd(pd, "start: 0x%pK, va: 0x%pK, len: %llu\n",
> @@ -1338,19 +1339,15 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  		rv = -EINVAL;
>  		goto err_out;
>  	}
> -	if (mem_limit != RLIM_INFINITY) {
> -		unsigned long num_pages =
> -			(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
> -		mem_limit >>= PAGE_SHIFT;
>  
> -		if (num_pages > mem_limit - current->mm->locked_vm) {
> -			siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
> -				   num_pages, mem_limit,
> -				   current->mm->locked_vm);
> -			rv = -ENOMEM;
> -			goto err_out;
> -		}
> +	if (!ib_umem_check_rlimit_memlock(num_pages + current->mm->locked_vm)) {
> +		siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
> +				num_pages, rlimit(RLIMIT_MEMLOCK),
> +				current->mm->locked_vm);
> +		rv = -ENOMEM;
> +		goto err_out;
>  	}
> +
>  	umem = siw_umem_get(start, len, ib_access_writable(rights));
>  	if (IS_ERR(umem)) {
>  		rv = PTR_ERR(umem);
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index 95896472a82b..3970da64b01e 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -11,6 +11,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/workqueue.h>
>  #include <rdma/ib_verbs.h>
> +#include <linux/sched/signal.h>
>  
>  struct ib_ucontext;
>  struct ib_umem_odp;
> @@ -71,6 +72,16 @@ static inline size_t ib_umem_num_pages(struct ib_umem *umem)
>  	return ib_umem_num_dma_blocks(umem, PAGE_SIZE);
>  }
>  
> +static inline bool ib_umem_check_rlimit_memlock(unsigned long value)
> +{
> +	unsigned long lock_limit = rlimit(RLIMIT_MEMLOCK);
> +
> +	if (lock_limit == RLIM_INFINITY || capable(CAP_IPC_LOCK))
> +		return true;
> +
> +	return value <= PFN_DOWN(lock_limit);
> +}
> +
>  static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
>  						struct ib_umem *umem,
>  						unsigned long pgsz)
> -- 
> 2.39.3
> 
