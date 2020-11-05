Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4968E2A8481
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgKERNb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:13:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:23064 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKERNb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 12:13:31 -0500
IronPort-SDR: P0zp3HKjzno+l6Ko5joCc8AJlU9T+ihM16wD8LWtJEhGqMaHX12lvX9/NqvR7O3NnT+XQRMK1k
 sMFVcEP3PIsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="254128054"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="254128054"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 09:13:29 -0800
IronPort-SDR: yxOOd8AAUACOH7vlQJoUS6vCtX/bC5lQNRazeNqYXHVtJq4tVjCX+4+SgilVXn3Buj4F5qujHR
 an2VNlQplLZw==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="471728862"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.200.81]) ([10.254.200.81])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 09:13:28 -0800
Subject: Re: [PATCH for-rc v1] IB/hfi1: Move cached value of mm into handler
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20201029012243.115730.93867.stgit@awfm-01.aw.intel.com>
 <20201105001245.GG1531489@iweiny-DESK2.sc.intel.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <a9be20e5-f350-0e25-f757-4c9fee9d2df3@cornelisnetworks.com>
Date:   Thu, 5 Nov 2020 12:13:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105001245.GG1531489@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/4/2020 7:12 PM, Ira Weiny wrote:
> On Wed, Oct 28, 2020 at 09:22:43PM -0400, Dennis Dalessandro wrote:
>> Two earlier bug fixes have created a security problem in the hfi1
>> driver. One fix aimed to solve an issue where current->mm was not valid
>> when closing the hfi1 cdev. It attempted to do this by saving a cached
>> value of the current->mm pointer at file open time. This is a problem if
>> another process with access to the FD calls in via write() or ioctl() to
>> pin pages via the hfi driver. The other fix tried to solve a use after
>> free by taking a reference on the mm. This was just wrong because its
>> possible for a race condition between one process with an mm that opened
>> the cdev if it was accessing via an IOCTL, and another process
>> attempting to close the cdev with a different current->mm.
> 
> I'm not clear on the issue in this last sentence.  If process A is accessing
> the FD via ioctl then process B closes the fd release should not be called
> until process A calls close as well?

Is that the case. If proc A opened the FD then forked. Won't a call by B 
to close the fd end up doing the release?

> I don't think it really matters much the code is wrong for other reasons.  I'm
> just trying to understand what you are saying here.
> 
>>
>> To fix this correctly we move the cached value of the mm into the mmu
>> handler struct for the driver. Now we can check in the insert, evict,
>> etc. routines that current->mm matched what the handler was registered
>> for. If not, then don't allow access. The register of the mmu notifier
>> will save the mm pointer.
>>
>> Note the check in the unregister is not needed in the event that
>> current->mm is empty. This means the tear down is happening due to a
>> SigKill or OOM Killer, something along those lines. If current->mm has a
>> value then it must be checked and only the task that did the register
>> can do the unregister.
> 
> I'm not seeing this bit of logic below...  Sorry.

Hmm. Maybe I goofed on a merge or something. Will fix up for a v2.

>> Since in do_exit() the exit_mm() is called before exit_files(), which
>> would call our close routine a reference is needed on the mm. This is
>> taken when the notifier is registered and dropped in the file close
>> routine.
> 
> This should be moved below as a comment for why you need the mmget/put()

I can do that.

>> Also of note is we do not do any explicit work to protect the interval
>> tree notifier. It doesn't seem that this is going to be needed since we
>> aren't actually doing anything with current->mm. The interval tree
>> notifier stuff still has a FIXME noted from a previous commit that will
>> be addressed in a follow on patch.
>>
>> Fixes: e0cf75deab81 ("IB/hfi1: Fix mm_struct use after free")
>> Fixes: 3faa3d9a308e ("IB/hfi1: Make use of mm consistent")
>> Reported-by: Jann Horn <jannh@google.com>
>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>>
>> ---
>>
>> Will add a Cc for stable once the patch is finalized. I'd like to get
>> some more feedback on this patch especially in the mmu_interval_notifier
>> stuff. I expect to be able to get a Reviewed-by from Ira as well but
>> I've made changes he hasn't yet seen so going with a Cc for this round.
>>
>> This is sort of a v1 as the patch was sent to security folks at first
>> which included a few others as well. This is the first public posting.
> 
> Is this really a security issue or a correctness issue?  Is there really any
> way that a user can corrupt another users data?  Or is this just going to
> scribble all over the wrong process or send the wrong data on the wire?

I guess it depends on your viewpoint. It's a security issue in the sense 
that we are currently letting one process operate while using a pointer 
to another's mm pointer. Could someone exploit it to do somethign bad, I 
don't know. I'd rather not take the chance. Due to the nature of the bug 
we thought it prudent to not take chances here.

>>
>> Changes since v0: Removed the checking of the pid and limitation that
>> whatever task opens the dev is the only one that can do write() or
>> ioctl(). While this limitation is OK it doesn't appear to be strictly
>> necessary.
>>
>> Rebased on top of 5.10-rc1. Testing has been done on 5.9 due to a bug in
>> 5.10 that is being worked (separate issue).
>> ---
>>   drivers/infiniband/hw/hfi1/file_ops.c     |    3 --
>>   drivers/infiniband/hw/hfi1/hfi.h          |    1 -
>>   drivers/infiniband/hw/hfi1/mmu_rb.c       |   40 +++++++++++++++++------------
>>   drivers/infiniband/hw/hfi1/mmu_rb.h       |   16 +++++++++++-
>>   drivers/infiniband/hw/hfi1/user_exp_rcv.c |   12 ++++++---
>>   drivers/infiniband/hw/hfi1/user_sdma.c    |   12 ++++-----
>>   drivers/infiniband/hw/hfi1/user_sdma.h    |   11 +++++++-
>>   7 files changed, 62 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
>> index 8ca51e4..bc15498 100644
>> --- a/drivers/infiniband/hw/hfi1/file_ops.c
>> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
>> @@ -206,8 +206,6 @@ static int hfi1_file_open(struct inode *inode, struct file *fp)
>>   	spin_lock_init(&fd->tid_lock);
>>   	spin_lock_init(&fd->invalid_lock);
>>   	fd->rec_cpu_num = -1; /* no cpu affinity by default */
>> -	fd->mm = current->mm;
>> -	mmgrab(fd->mm);
>>   	fd->dd = dd;
>>   	fp->private_data = fd;
>>   	return 0;
>> @@ -711,7 +709,6 @@ static int hfi1_file_close(struct inode *inode, struct file *fp)
>>   
>>   	deallocate_ctxt(uctxt);
>>   done:
>> -	mmdrop(fdata->mm);
>>   
>>   	if (atomic_dec_and_test(&dd->user_refcount))
>>   		complete(&dd->user_comp);
>> diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
>> index b4c6bff..bc59e61 100644
>> --- a/drivers/infiniband/hw/hfi1/hfi.h
>> +++ b/drivers/infiniband/hw/hfi1/hfi.h
>> @@ -1451,7 +1451,6 @@ struct hfi1_filedata {
>>   	u32 invalid_tid_idx;
>>   	/* protect invalid_tids array and invalid_tid_idx */
>>   	spinlock_t invalid_lock;
>> -	struct mm_struct *mm;
>>   };
>>   
>>   extern struct xarray hfi1_dev_table;
>> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
>> index 24ca17b..2b04942 100644
>> --- a/drivers/infiniband/hw/hfi1/mmu_rb.c
>> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
>> @@ -48,23 +48,11 @@
>>   #include <linux/rculist.h>
>>   #include <linux/mmu_notifier.h>
>>   #include <linux/interval_tree_generic.h>
>> +#include <linux/sched/mm.h>
>>   
>>   #include "mmu_rb.h"
>>   #include "trace.h"
>>   
>> -struct mmu_rb_handler {
>> -	struct mmu_notifier mn;
>> -	struct rb_root_cached root;
>> -	void *ops_arg;
>> -	spinlock_t lock;        /* protect the RB tree */
>> -	struct mmu_rb_ops *ops;
>> -	struct mm_struct *mm;
>> -	struct list_head lru_list;
>> -	struct work_struct del_work;
>> -	struct list_head del_list;
>> -	struct workqueue_struct *wq;
>> -};
>> -
>>   static unsigned long mmu_node_start(struct mmu_rb_node *);
>>   static unsigned long mmu_node_last(struct mmu_rb_node *);
>>   static int mmu_notifier_range_start(struct mmu_notifier *,
>> @@ -92,7 +80,7 @@ static unsigned long mmu_node_last(struct mmu_rb_node *node)
>>   	return PAGE_ALIGN(node->addr + node->len) - 1;
>>   }
>>   
>> -int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
>> +int hfi1_mmu_rb_register(void *ops_arg,
>>   			 struct mmu_rb_ops *ops,
>>   			 struct workqueue_struct *wq,
>>   			 struct mmu_rb_handler **handler)
>> @@ -110,18 +98,20 @@ int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
>>   	INIT_HLIST_NODE(&handlr->mn.hlist);
>>   	spin_lock_init(&handlr->lock);
>>   	handlr->mn.ops = &mn_opts;
>> -	handlr->mm = mm;
>>   	INIT_WORK(&handlr->del_work, handle_remove);
>>   	INIT_LIST_HEAD(&handlr->del_list);
>>   	INIT_LIST_HEAD(&handlr->lru_list);
>>   	handlr->wq = wq;
>>   
>> -	ret = mmu_notifier_register(&handlr->mn, handlr->mm);
>> +	ret = mmu_notifier_register(&handlr->mn, current->mm);
>>   	if (ret) {
>>   		kfree(handlr);
>>   		return ret;
>>   	}
>>   
>> +	mmget(current->mm);
> 
> I flagged this initially but then reviewed the commit message for why you need
> this reference.  I think it is worth a comment here as well as below.
> Specifically mentioning the order of calls in do_exit().

Sure.

>> +	handlr->mm = current->mm;
>> +
>>   	*handler = handlr;
>>   	return 0;
>>   }
>> @@ -134,7 +124,9 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler)
>>   	struct list_head del_list;
>>   
>>   	/* Unregister first so we don't get any more notifications. */
>> -	mmu_notifier_unregister(&handler->mn, handler->mm);
>> +	mmu_notifier_unregister(&handler->mn, handler->mn.mm);
>> +
>> +	mmput(handler->mm); /* We don't need to touch the mm anymore it can go away */
> 
> Better to put this comment on the previous line...

Will do.

> 
>>   
>>   	/*
>>   	 * Make sure the wq delete handler is finished running.  It will not
>> @@ -166,6 +158,10 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
>>   	int ret = 0;
>>   
>>   	trace_hfi1_mmu_rb_insert(mnode->addr, mnode->len);
>> +
>> +	if (current->mm != handler->mm)
>> +		return -EPERM;
>> +
>>   	spin_lock_irqsave(&handler->lock, flags);
>>   	node = __mmu_rb_search(handler, mnode->addr, mnode->len);
>>   	if (node) {
>> @@ -180,6 +176,7 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
>>   		__mmu_int_rb_remove(mnode, &handler->root);
>>   		list_del(&mnode->list); /* remove from LRU list */
>>   	}
>> +	mnode->handler = handler;
>>   unlock:
>>   	spin_unlock_irqrestore(&handler->lock, flags);
>>   	return ret;
>> @@ -217,6 +214,9 @@ bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
>>   	unsigned long flags;
>>   	bool ret = false;
>>   
>> +	if (current->mm != handler->mm)
>> +		return ret;
>> +
>>   	spin_lock_irqsave(&handler->lock, flags);
>>   	node = __mmu_rb_search(handler, addr, len);
>>   	if (node) {
>> @@ -239,6 +239,9 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
>>   	unsigned long flags;
>>   	bool stop = false;
>>   
>> +	if (current->mm != handler->mm)
>> +		return;
>> +
>>   	INIT_LIST_HEAD(&del_list);
>>   
>>   	spin_lock_irqsave(&handler->lock, flags);
>> @@ -272,6 +275,9 @@ void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
>>   {
>>   	unsigned long flags;
>>   
>> +	if (current->mm != handler->mm)
>> +		return;
>> +
>>   	/* Validity of handler and node pointers has been checked by caller. */
>>   	trace_hfi1_mmu_rb_remove(node->addr, node->len);
>>   	spin_lock_irqsave(&handler->lock, flags);
>> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
>> index f04cec1..8493a2d 100644
>> --- a/drivers/infiniband/hw/hfi1/mmu_rb.h
>> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
>> @@ -54,6 +54,7 @@ struct mmu_rb_node {
>>   	unsigned long len;
>>   	unsigned long __last;
>>   	struct rb_node node;
>> +	struct mmu_rb_handler *handler;
>>   	struct list_head list;
>>   };
>>   
>> @@ -71,7 +72,20 @@ struct mmu_rb_ops {
>>   		     void *evict_arg, bool *stop);
>>   };
>>   
>> -int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
>> +struct mmu_rb_handler {
>> +	struct mmu_notifier mn;
>> +	struct rb_root_cached root;
>> +	void *ops_arg;
>> +	spinlock_t lock;        /* protect the RB tree */
>> +	struct mmu_rb_ops *ops;
>> +	struct list_head lru_list;
>> +	struct work_struct del_work;
>> +	struct list_head del_list;
>> +	struct workqueue_struct *wq;
>> +	struct mm_struct *mm;
>> +};
>> +
>> +int hfi1_mmu_rb_register(void *ops_arg,
>>   			 struct mmu_rb_ops *ops,
>>   			 struct workqueue_struct *wq,
>>   			 struct mmu_rb_handler **handler);
>> diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
>> index f81ca20..fb72a3c 100644
>> --- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
>> +++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
>> @@ -49,6 +49,7 @@
>>   
>>   #include "mmu_rb.h"
>>   #include "user_exp_rcv.h"
>> +
> 
> NIT: white space

Sorry about that, got it.

> 
>>   #include "trace.h"
>>   
>>   static void unlock_exp_tids(struct hfi1_ctxtdata *uctxt,
>> @@ -173,15 +174,18 @@ static void unpin_rcv_pages(struct hfi1_filedata *fd,
>>   {
>>   	struct page **pages;
>>   	struct hfi1_devdata *dd = fd->uctxt->dd;
>> +	struct mm_struct *mm;
>>   
>>   	if (mapped) {
>>   		pci_unmap_single(dd->pcidev, node->dma_addr,
>>   				 node->npages * PAGE_SIZE, PCI_DMA_FROMDEVICE);
>>   		pages = &node->pages[idx];
>> +		mm = node->notifier.mm;
>>   	} else {
>>   		pages = &tidbuf->pages[idx];
>> +		mm = current->mm;
>>   	}
>> -	hfi1_release_user_pages(fd->mm, pages, npages, mapped);
>> +	hfi1_release_user_pages(mm, pages, npages, mapped);
>>   	fd->tid_n_pinned -= npages;
>>   }
>>   
>> @@ -216,12 +220,12 @@ static int pin_rcv_pages(struct hfi1_filedata *fd, struct tid_user_buf *tidbuf)
>>   	 * pages, accept the amount pinned so far and program only that.
>>   	 * User space knows how to deal with partially programmed buffers.
>>   	 */
>> -	if (!hfi1_can_pin_pages(dd, fd->mm, fd->tid_n_pinned, npages)) {
>> +	if (!hfi1_can_pin_pages(dd, current->mm, fd->tid_n_pinned, npages)) {
>>   		kfree(pages);
>>   		return -ENOMEM;
>>   	}
>>   
>> -	pinned = hfi1_acquire_user_pages(fd->mm, vaddr, npages, true, pages);
>> +	pinned = hfi1_acquire_user_pages(current->mm, vaddr, npages, true, pages);
>>   	if (pinned <= 0) {
>>   		kfree(pages);
>>   		return pinned;
>> @@ -756,7 +760,7 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
>>   
>>   	if (fd->use_mn) {
>>   		ret = mmu_interval_notifier_insert(
>> -			&node->notifier, fd->mm,
>> +			&node->notifier, current->mm,
>>   			tbuf->vaddr + (pageidx * PAGE_SIZE), npages * PAGE_SIZE,
>>   			&tid_mn_ops);
>>   		if (ret)
>> diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
>> index a92346e..058c83c 100644
>> --- a/drivers/infiniband/hw/hfi1/user_sdma.c
>> +++ b/drivers/infiniband/hw/hfi1/user_sdma.c
>> @@ -188,7 +188,6 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
>>   	atomic_set(&pq->n_reqs, 0);
>>   	init_waitqueue_head(&pq->wait);
>>   	atomic_set(&pq->n_locked, 0);
>> -	pq->mm = fd->mm;
>>   
>>   	iowait_init(&pq->busy, 0, NULL, NULL, defer_packet_queue,
>>   		    activate_packet_queue, NULL, NULL);
>> @@ -230,7 +229,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
>>   
>>   	cq->nentries = hfi1_sdma_comp_ring_size;
>>   
>> -	ret = hfi1_mmu_rb_register(pq, pq->mm, &sdma_rb_ops, dd->pport->hfi1_wq,
>> +	ret = hfi1_mmu_rb_register(pq, &sdma_rb_ops, dd->pport->hfi1_wq,
>>   				   &pq->handler);
>>   	if (ret) {
>>   		dd_dev_err(dd, "Failed to register with MMU %d", ret);
>> @@ -980,13 +979,13 @@ static int pin_sdma_pages(struct user_sdma_request *req,
>>   
>>   	npages -= node->npages;
>>   retry:
>> -	if (!hfi1_can_pin_pages(pq->dd, pq->mm,
>> +	if (!hfi1_can_pin_pages(pq->dd, current->mm,
>>   				atomic_read(&pq->n_locked), npages)) {
>>   		cleared = sdma_cache_evict(pq, npages);
>>   		if (cleared >= npages)
>>   			goto retry;
>>   	}
>> -	pinned = hfi1_acquire_user_pages(pq->mm,
>> +	pinned = hfi1_acquire_user_pages(current->mm,
>>   					 ((unsigned long)iovec->iov.iov_base +
>>   					 (node->npages * PAGE_SIZE)), npages, 0,
>>   					 pages + node->npages);
>> @@ -995,7 +994,7 @@ static int pin_sdma_pages(struct user_sdma_request *req,
>>   		return pinned;
>>   	}
>>   	if (pinned != npages) {
>> -		unpin_vector_pages(pq->mm, pages, node->npages, pinned);
>> +		unpin_vector_pages(current->mm, pages, node->npages, pinned);
>>   		return -EFAULT;
>>   	}
>>   	kfree(node->pages);
>> @@ -1008,7 +1007,8 @@ static int pin_sdma_pages(struct user_sdma_request *req,
>>   static void unpin_sdma_pages(struct sdma_mmu_node *node)
>>   {
>>   	if (node->npages) {
>> -		unpin_vector_pages(node->pq->mm, node->pages, 0, node->npages);
>> +		unpin_vector_pages(mm_from_sdma_node(node), node->pages, 0,
>> +				   node->npages);
>>   		atomic_sub(node->npages, &node->pq->n_locked);
>>   	}
>>   }
>> diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
>> index 9972e0e..7126d61 100644
>> --- a/drivers/infiniband/hw/hfi1/user_sdma.h
>> +++ b/drivers/infiniband/hw/hfi1/user_sdma.h
>> @@ -133,7 +133,6 @@ struct hfi1_user_sdma_pkt_q {
>>   	unsigned long unpinned;
>>   	struct mmu_rb_handler *handler;
>>   	atomic_t n_locked;
>> -	struct mm_struct *mm;
>>   };
>>   
>>   struct hfi1_user_sdma_comp_q {
>> @@ -250,4 +249,14 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
>>   				   struct iovec *iovec, unsigned long dim,
>>   				   unsigned long *count);
>>   
>> +static inline struct mm_struct *mm_from_tid_node(struct tid_rb_node *node)
> 
> Where is mm_from_tid_node() used?

Will fix.

> 
> Ira
> 
>> +{
>> +	return node->notifier.mm;
>> +}
>> +
>> +static inline struct mm_struct *mm_from_sdma_node(struct sdma_mmu_node *node)
>> +{
>> +	return node->rb.handler->mn.mm;
>> +}
>> +
>>   #endif /* _HFI1_USER_SDMA_H */
>>

-Denny
