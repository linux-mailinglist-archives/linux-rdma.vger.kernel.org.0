Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0792B0B12
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 18:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgKLROq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 12:14:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:4462 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgKLROq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 12:14:46 -0500
IronPort-SDR: zEMomXZLojK3rrHIJxTSHotE4U4NGfsJgRgI8McN46fxXgOBuB0rkwV3GNjNwBuvUyUvEYg6Ff
 tr0kbHE/KcjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="234505281"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="234505281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:14:40 -0800
IronPort-SDR: yonP+hrFZAY/LUTPl5fiwwNEt9QG+8cgE7tsuxVyMo4UhY2SslySSXM2gYg+QvUjHw1SGrWhyG
 goRLNujHn+fg==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="542331259"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:14:39 -0800
Date:   Thu, 12 Nov 2020 09:14:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH for-rc v2] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
References: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 11, 2020 at 09:58:37PM -0500, Dennis Dalessandro wrote:
> Two earlier bug fixes have created a security problem in the hfi1
> driver. One fix aimed to solve an issue where current->mm was not valid
> when closing the hfi1 cdev. It attempted to do this by saving a cached
> value of the current->mm pointer at file open time. This is a problem if
> another process with access to the FD calls in via write() or ioctl() to
> pin pages via the hfi driver. The other fix tried to solve a use after
> free by taking a reference on the mm. This was just wrong because its
> possible for a race condition between one process with an mm that opened
> the cdev if it was accessing via an IOCTL, and another process
> attempting to close the cdev with a different current->mm.

Again I'm still not seeing the race here.  It is entirely possible that the fix
I was trying to do way back was mistaken too...  ;-)  I would just delete the
last 2 sentences...  and/or reference the commit of those fixes and help
explain this more.

> 
> To fix this correctly we move the cached value of the mm into the mmu
> handler struct for the driver.

Looking at this closer I don't think you need the mm member of mmu_rb_handler
any longer.  See below.

> Now we can check in the insert, evict,
> etc. routines that current->mm matched what the handler was registered
> for. If not, then don't allow access. The register of the mmu notifier
> will save the mm pointer.
> 
> Note the check in the unregister is not needed in the event that
> current->mm is empty. This means the tear down is happening due to a
> SigKill or OOM Killer, something along those lines. If current->mm has a
> value then it must be checked and only the task that did the register
> can do the unregister.
> 
> Since in do_exit() the exit_mm() is called before exit_files(), which
> would call our close routine a reference is needed on the mm. We rely on
> the mmgrab done by the registration of the notifier, whereas before it
> was explicit.
> 
> Also of note is we do not do any explicit work to protect the interval
> tree notifier. It doesn't seem that this is going to be needed since we
> aren't actually doing anything with current->mm. The interval tree
> notifier stuff still has a FIXME noted from a previous commit that will
> be addressed in a follow on patch.

This is a bit confusing ...

Is this the FIXME you are refering to?

hfi1/user_exp_rcv.c:
...
764                 /*
765                  * FIXME: This is in the wrong order, the notifier should be
766                  * established before the pages are pinned by pin_rcv_pages.
767                  */
...

> 
> Fixes: e0cf75deab81 ("IB/hfi1: Fix mm_struct use after free")
> Fixes: 3faa3d9a308e ("IB/hfi1: Make use of mm consistent")
> Reported-by: Jann Horn <jannh@google.com>
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> 
> ---
> 
> Changes since v0:
> ----------------
> Removed the checking of the pid and limitation that
> whatever task opens the dev is the only one that can do write() or
> ioctl(). While this limitation is OK it doesn't appear to be strictly
> necessary.
> 
> Rebased on top of 5.10-rc1. Testing has been done on 5.9 due to a bug in
> 5.10 that is being worked (separate issue).
> 
> Changes since v1:
> ----------------
> Remove explicit mmget/put to rely on the notifier register's mmgrab
> instead.
> 
> Fixed missing check in rb_unregister to only check current->mm if its
> actually valid.
> 
> Moved mm_from_tid_node to exp_rcv header and use it
> ---
>  drivers/infiniband/hw/hfi1/file_ops.c     |    4 +--
>  drivers/infiniband/hw/hfi1/hfi.h          |    2 +
>  drivers/infiniband/hw/hfi1/mmu_rb.c       |   41 +++++++++++++++++------------
>  drivers/infiniband/hw/hfi1/mmu_rb.h       |   17 +++++++++++-
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c |   12 ++++++--
>  drivers/infiniband/hw/hfi1/user_exp_rcv.h |    6 ++++
>  drivers/infiniband/hw/hfi1/user_sdma.c    |   13 +++++----
>  drivers/infiniband/hw/hfi1/user_sdma.h    |    7 ++++-
>  8 files changed, 69 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
> index 8ca51e4..329ee4f 100644
> --- a/drivers/infiniband/hw/hfi1/file_ops.c
> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> @@ -1,4 +1,5 @@
>  /*
> + * Copyright(c) 2020 Cornelis Networks, Inc.
>   * Copyright(c) 2015-2020 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
> @@ -206,8 +207,6 @@ static int hfi1_file_open(struct inode *inode, struct file *fp)
>  	spin_lock_init(&fd->tid_lock);
>  	spin_lock_init(&fd->invalid_lock);
>  	fd->rec_cpu_num = -1; /* no cpu affinity by default */
> -	fd->mm = current->mm;
> -	mmgrab(fd->mm);
>  	fd->dd = dd;
>  	fp->private_data = fd;
>  	return 0;
> @@ -711,7 +710,6 @@ static int hfi1_file_close(struct inode *inode, struct file *fp)
>  
>  	deallocate_ctxt(uctxt);
>  done:
> -	mmdrop(fdata->mm);
>  
>  	if (atomic_dec_and_test(&dd->user_refcount))
>  		complete(&dd->user_comp);
> diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
> index b4c6bff..e09e824 100644
> --- a/drivers/infiniband/hw/hfi1/hfi.h
> +++ b/drivers/infiniband/hw/hfi1/hfi.h
> @@ -1,6 +1,7 @@
>  #ifndef _HFI1_KERNEL_H
>  #define _HFI1_KERNEL_H
>  /*
> + * Copyright(c) 2020 Cornelis Networks, Inc.
>   * Copyright(c) 2015-2020 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
> @@ -1451,7 +1452,6 @@ struct hfi1_filedata {
>  	u32 invalid_tid_idx;
>  	/* protect invalid_tids array and invalid_tid_idx */
>  	spinlock_t invalid_lock;
> -	struct mm_struct *mm;
>  };
>  
>  extern struct xarray hfi1_dev_table;
> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
> index 24ca17b..6be4e79 100644
> --- a/drivers/infiniband/hw/hfi1/mmu_rb.c
> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
> @@ -1,4 +1,5 @@
>  /*
> + * Copyright(c) 2020 Cornelis Networks, Inc.
>   * Copyright(c) 2016 - 2017 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
> @@ -48,23 +49,11 @@
>  #include <linux/rculist.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/interval_tree_generic.h>
> +#include <linux/sched/mm.h>
>  
>  #include "mmu_rb.h"
>  #include "trace.h"
>  
> -struct mmu_rb_handler {
> -	struct mmu_notifier mn;
> -	struct rb_root_cached root;
> -	void *ops_arg;
> -	spinlock_t lock;        /* protect the RB tree */
> -	struct mmu_rb_ops *ops;
> -	struct mm_struct *mm;
> -	struct list_head lru_list;
> -	struct work_struct del_work;
> -	struct list_head del_list;
> -	struct workqueue_struct *wq;
> -};
> -
>  static unsigned long mmu_node_start(struct mmu_rb_node *);
>  static unsigned long mmu_node_last(struct mmu_rb_node *);
>  static int mmu_notifier_range_start(struct mmu_notifier *,
> @@ -92,7 +81,7 @@ static unsigned long mmu_node_last(struct mmu_rb_node *node)
>  	return PAGE_ALIGN(node->addr + node->len) - 1;
>  }
>  
> -int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
> +int hfi1_mmu_rb_register(void *ops_arg,
>  			 struct mmu_rb_ops *ops,
>  			 struct workqueue_struct *wq,
>  			 struct mmu_rb_handler **handler)
> @@ -110,18 +99,19 @@ int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
>  	INIT_HLIST_NODE(&handlr->mn.hlist);
>  	spin_lock_init(&handlr->lock);
>  	handlr->mn.ops = &mn_opts;
> -	handlr->mm = mm;

NIT: I really think you should follow up with a spelling fix patch...  Sorry
just got frustrated greping for 'handler' and not finding this!  ;-)

>  	INIT_WORK(&handlr->del_work, handle_remove);
>  	INIT_LIST_HEAD(&handlr->del_list);
>  	INIT_LIST_HEAD(&handlr->lru_list);
>  	handlr->wq = wq;
>  
> -	ret = mmu_notifier_register(&handlr->mn, handlr->mm);
> +	ret = mmu_notifier_register(&handlr->mn, current->mm);
>  	if (ret) {
>  		kfree(handlr);
>  		return ret;
>  	}
>  
> +	handlr->mm = current->mm;

Sorry I did not catch this before but do you need to store this pointer?  Is it
not enough to check the ->mn.mm? ...

I think that would also make it clear you are relying on the mmget() within the
mmu_notifier_register()  Because that is the reference you are using rather
than having another reference here which could potentially be used wrongly in
the future.

> +
>  	*handler = handlr;
>  	return 0;
>  }
> @@ -133,8 +123,11 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler)
>  	unsigned long flags;
>  	struct list_head del_list;
>  
> +	if (current->mm && (handler->mm != current->mm))
                            ^^^^^^^^^^^
                            handler->mn.mm?
... Like this?

> +		return;
> +
>  	/* Unregister first so we don't get any more notifications. */
> -	mmu_notifier_unregister(&handler->mn, handler->mm);
> +	mmu_notifier_unregister(&handler->mn, handler->mn.mm);

Here you use the mn.mm.

It is the same right?

>  
>  	/*
>  	 * Make sure the wq delete handler is finished running.  It will not
> @@ -166,6 +159,10 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
>  	int ret = 0;
>  
>  	trace_hfi1_mmu_rb_insert(mnode->addr, mnode->len);
> +
> +	if (current->mm != handler->mm)

Ditto.

> +		return -EPERM;
> +
>  	spin_lock_irqsave(&handler->lock, flags);
>  	node = __mmu_rb_search(handler, mnode->addr, mnode->len);
>  	if (node) {
> @@ -180,6 +177,7 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
>  		__mmu_int_rb_remove(mnode, &handler->root);
>  		list_del(&mnode->list); /* remove from LRU list */
>  	}
> +	mnode->handler = handler;
>  unlock:
>  	spin_unlock_irqrestore(&handler->lock, flags);
>  	return ret;
> @@ -217,6 +215,9 @@ bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
>  	unsigned long flags;
>  	bool ret = false;
>  
> +	if (current->mm != handler->mm)

Ditto.

> +		return ret;
> +
>  	spin_lock_irqsave(&handler->lock, flags);
>  	node = __mmu_rb_search(handler, addr, len);
>  	if (node) {
> @@ -239,6 +240,9 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
>  	unsigned long flags;
>  	bool stop = false;
>  
> +	if (current->mm != handler->mm)

Ditto.

> +		return;
> +
>  	INIT_LIST_HEAD(&del_list);
>  
>  	spin_lock_irqsave(&handler->lock, flags);
> @@ -272,6 +276,9 @@ void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
>  {
>  	unsigned long flags;
>  
> +	if (current->mm != handler->mm)

Ditto.

> +		return;
> +
>  	/* Validity of handler and node pointers has been checked by caller. */
>  	trace_hfi1_mmu_rb_remove(node->addr, node->len);
>  	spin_lock_irqsave(&handler->lock, flags);
> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
> index f04cec1..e208618 100644
> --- a/drivers/infiniband/hw/hfi1/mmu_rb.h
> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
> @@ -1,4 +1,5 @@
>  /*
> + * Copyright(c) 2020 Cornelis Networks, Inc.
>   * Copyright(c) 2016 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
> @@ -54,6 +55,7 @@ struct mmu_rb_node {
>  	unsigned long len;
>  	unsigned long __last;
>  	struct rb_node node;
> +	struct mmu_rb_handler *handler;
>  	struct list_head list;
>  };
>  
> @@ -71,7 +73,20 @@ struct mmu_rb_ops {
>  		     void *evict_arg, bool *stop);
>  };
>  
> -int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
> +struct mmu_rb_handler {
> +	struct mmu_notifier mn;
> +	struct rb_root_cached root;
> +	void *ops_arg;
> +	spinlock_t lock;        /* protect the RB tree */
> +	struct mmu_rb_ops *ops;
> +	struct list_head lru_list;
> +	struct work_struct del_work;
> +	struct list_head del_list;
> +	struct workqueue_struct *wq;
> +	struct mm_struct *mm;

And remove this?

Ira

> +};
> +
> +int hfi1_mmu_rb_register(void *ops_arg,
>  			 struct mmu_rb_ops *ops,
>  			 struct workqueue_struct *wq,
>  			 struct mmu_rb_handler **handler);
> diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
> index f81ca20..b94fc7f 100644
> --- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
> +++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
> @@ -1,4 +1,5 @@
>  /*
> + * Copyright(c) 2020 Cornelis Networks, Inc.
>   * Copyright(c) 2015-2018 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
> @@ -173,15 +174,18 @@ static void unpin_rcv_pages(struct hfi1_filedata *fd,
>  {
>  	struct page **pages;
>  	struct hfi1_devdata *dd = fd->uctxt->dd;
> +	struct mm_struct *mm;
>  
>  	if (mapped) {
>  		pci_unmap_single(dd->pcidev, node->dma_addr,
>  				 node->npages * PAGE_SIZE, PCI_DMA_FROMDEVICE);
>  		pages = &node->pages[idx];
> +		mm = mm_from_tid_node(node);
>  	} else {
>  		pages = &tidbuf->pages[idx];
> +		mm = current->mm;
>  	}
> -	hfi1_release_user_pages(fd->mm, pages, npages, mapped);
> +	hfi1_release_user_pages(mm, pages, npages, mapped);
>  	fd->tid_n_pinned -= npages;
>  }
>  
> @@ -216,12 +220,12 @@ static int pin_rcv_pages(struct hfi1_filedata *fd, struct tid_user_buf *tidbuf)
>  	 * pages, accept the amount pinned so far and program only that.
>  	 * User space knows how to deal with partially programmed buffers.
>  	 */
> -	if (!hfi1_can_pin_pages(dd, fd->mm, fd->tid_n_pinned, npages)) {
> +	if (!hfi1_can_pin_pages(dd, current->mm, fd->tid_n_pinned, npages)) {
>  		kfree(pages);
>  		return -ENOMEM;
>  	}
>  
> -	pinned = hfi1_acquire_user_pages(fd->mm, vaddr, npages, true, pages);
> +	pinned = hfi1_acquire_user_pages(current->mm, vaddr, npages, true, pages);
>  	if (pinned <= 0) {
>  		kfree(pages);
>  		return pinned;
> @@ -756,7 +760,7 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
>  
>  	if (fd->use_mn) {
>  		ret = mmu_interval_notifier_insert(
> -			&node->notifier, fd->mm,
> +			&node->notifier, current->mm,
>  			tbuf->vaddr + (pageidx * PAGE_SIZE), npages * PAGE_SIZE,
>  			&tid_mn_ops);
>  		if (ret)
> diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
> index 332abb4..d45c7b6 100644
> --- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
> +++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
> @@ -1,6 +1,7 @@
>  #ifndef _HFI1_USER_EXP_RCV_H
>  #define _HFI1_USER_EXP_RCV_H
>  /*
> + * Copyright(c) 2020 - Cornelis Networks, Inc.
>   * Copyright(c) 2015 - 2017 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
> @@ -95,4 +96,9 @@ int hfi1_user_exp_rcv_clear(struct hfi1_filedata *fd,
>  int hfi1_user_exp_rcv_invalid(struct hfi1_filedata *fd,
>  			      struct hfi1_tid_info *tinfo);
>  
> +static inline struct mm_struct *mm_from_tid_node(struct tid_rb_node *node)
> +{
> +	return node->notifier.mm;
> +}
> +
>  #endif /* _HFI1_USER_EXP_RCV_H */
> diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
> index a92346e..4a4956f9 100644
> --- a/drivers/infiniband/hw/hfi1/user_sdma.c
> +++ b/drivers/infiniband/hw/hfi1/user_sdma.c
> @@ -1,4 +1,5 @@
>  /*
> + * Copyright(c) 2020 - Cornelis Networks, Inc.
>   * Copyright(c) 2015 - 2018 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
> @@ -188,7 +189,6 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
>  	atomic_set(&pq->n_reqs, 0);
>  	init_waitqueue_head(&pq->wait);
>  	atomic_set(&pq->n_locked, 0);
> -	pq->mm = fd->mm;
>  
>  	iowait_init(&pq->busy, 0, NULL, NULL, defer_packet_queue,
>  		    activate_packet_queue, NULL, NULL);
> @@ -230,7 +230,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
>  
>  	cq->nentries = hfi1_sdma_comp_ring_size;
>  
> -	ret = hfi1_mmu_rb_register(pq, pq->mm, &sdma_rb_ops, dd->pport->hfi1_wq,
> +	ret = hfi1_mmu_rb_register(pq, &sdma_rb_ops, dd->pport->hfi1_wq,
>  				   &pq->handler);
>  	if (ret) {
>  		dd_dev_err(dd, "Failed to register with MMU %d", ret);
> @@ -980,13 +980,13 @@ static int pin_sdma_pages(struct user_sdma_request *req,
>  
>  	npages -= node->npages;
>  retry:
> -	if (!hfi1_can_pin_pages(pq->dd, pq->mm,
> +	if (!hfi1_can_pin_pages(pq->dd, current->mm,
>  				atomic_read(&pq->n_locked), npages)) {
>  		cleared = sdma_cache_evict(pq, npages);
>  		if (cleared >= npages)
>  			goto retry;
>  	}
> -	pinned = hfi1_acquire_user_pages(pq->mm,
> +	pinned = hfi1_acquire_user_pages(current->mm,
>  					 ((unsigned long)iovec->iov.iov_base +
>  					 (node->npages * PAGE_SIZE)), npages, 0,
>  					 pages + node->npages);
> @@ -995,7 +995,7 @@ static int pin_sdma_pages(struct user_sdma_request *req,
>  		return pinned;
>  	}
>  	if (pinned != npages) {
> -		unpin_vector_pages(pq->mm, pages, node->npages, pinned);
> +		unpin_vector_pages(current->mm, pages, node->npages, pinned);
>  		return -EFAULT;
>  	}
>  	kfree(node->pages);
> @@ -1008,7 +1008,8 @@ static int pin_sdma_pages(struct user_sdma_request *req,
>  static void unpin_sdma_pages(struct sdma_mmu_node *node)
>  {
>  	if (node->npages) {
> -		unpin_vector_pages(node->pq->mm, node->pages, 0, node->npages);
> +		unpin_vector_pages(mm_from_sdma_node(node), node->pages, 0,
> +				   node->npages);
>  		atomic_sub(node->npages, &node->pq->n_locked);
>  	}
>  }
> diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
> index 9972e0e..1e8c02f 100644
> --- a/drivers/infiniband/hw/hfi1/user_sdma.h
> +++ b/drivers/infiniband/hw/hfi1/user_sdma.h
> @@ -1,6 +1,7 @@
>  #ifndef _HFI1_USER_SDMA_H
>  #define _HFI1_USER_SDMA_H
>  /*
> + * Copyright(c) 2020 - Cornelis Networks, Inc.
>   * Copyright(c) 2015 - 2018 Intel Corporation.
>   *
>   * This file is provided under a dual BSD/GPLv2 license.  When using or
> @@ -133,7 +134,6 @@ struct hfi1_user_sdma_pkt_q {
>  	unsigned long unpinned;
>  	struct mmu_rb_handler *handler;
>  	atomic_t n_locked;
> -	struct mm_struct *mm;
>  };
>  
>  struct hfi1_user_sdma_comp_q {
> @@ -250,4 +250,9 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
>  				   struct iovec *iovec, unsigned long dim,
>  				   unsigned long *count);
>  
> +static inline struct mm_struct *mm_from_sdma_node(struct sdma_mmu_node *node)
> +{
> +	return node->rb.handler->mn.mm;
> +}
> +
>  #endif /* _HFI1_USER_SDMA_H */
> 
