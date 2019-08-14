Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167428DFB1
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 23:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfHNVUg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 17:20:36 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9449 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHNVUf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Aug 2019 17:20:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d547b230000>; Wed, 14 Aug 2019 14:20:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 14 Aug 2019 14:20:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 14 Aug 2019 14:20:33 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Aug
 2019 21:20:32 +0000
Subject: Re: [PATCH v3 hmm 03/11] mm/mmu_notifiers: add a get/put scheme for
 the registration
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <intel-gfx@lists.freedesktop.org>,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20190806231548.25242-1-jgg@ziepe.ca>
 <20190806231548.25242-4-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <0a23adb8-b827-cd90-503e-bfa84166c67e@nvidia.com>
Date:   Wed, 14 Aug 2019 14:20:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806231548.25242-4-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565817635; bh=7OCMNAz4kjek+/81HtdyqfLdRerNt7gJqZQ4Qne52lg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EOIv4DTJn8jZudgokayR+GYl1EOeCIQHooKpkbcgJB4vkLSxjQ9d39IX4h5BMVwUf
         bFZ5snH5CJPHtTh6SSbZNce/7dp38DijAM/U8YN+14Gjt0lYd3DfvZwwugYwBOfpPH
         GheFSPyNDYdEhXVjhKs0jmNTTFEbuEZJ3IdefBAsE+ZmNH9oFHxaANX1QENpP7KoD3
         MYeAGog5Dt8ukXxAD+HZb68jVptbfXU7Lu1DdGqad07hnpZe7H+H5BlqK5LPsDBEtU
         46lWIb9BOL0o16abMvl7UQ/p6YNYoBKJ7tid+FXzvvPNXay4uIjcAXB28zI0zkOoiX
         MFFYiDmIotyvA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/6/19 4:15 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Many places in the kernel have a flow where userspace will create some
> object and that object will need to connect to the subsystem's
> mmu_notifier subscription for the duration of its lifetime.
> 
> In this case the subsystem is usually tracking multiple mm_structs and it
> is difficult to keep track of what struct mmu_notifier's have been
> allocated for what mm's.
> 
> Since this has been open coded in a variety of exciting ways, provide core
> functionality to do this safely.
> 
> This approach uses the strct mmu_notifier_ops * as a key to determine if

s/strct/struct

> the subsystem has a notifier registered on the mm or not. If there is a
> registration then the existing notifier struct is returned, otherwise the
> ops->alloc_notifiers() is used to create a new per-subsystem notifier for
> the mm.
> 
> The destroy side incorporates an async call_srcu based destruction which
> will avoid bugs in the callers such as commit 6d7c3cde93c1 ("mm/hmm: fix
> use after free with struct hmm in the mmu notifiers").
> 
> Since we are inside the mmu notifier core locking is fairly simple, the
> allocation uses the same approach as for mmu_notifier_mm, the write side
> of the mmap_sem makes everything deterministic and we only need to do
> hlist_add_head_rcu() under the mm_take_all_locks(). The new users count
> and the discoverability in the hlist is fully serialized by the
> mmu_notifier_mm->lock.
> 
> Co-developed-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   include/linux/mmu_notifier.h |  35 ++++++++
>   mm/mmu_notifier.c            | 156 +++++++++++++++++++++++++++++++++--
>   2 files changed, 185 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index b6c004bd9f6ad9..31aa971315a142 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -211,6 +211,19 @@ struct mmu_notifier_ops {
>   	 */
>   	void (*invalidate_range)(struct mmu_notifier *mn, struct mm_struct *mm,
>   				 unsigned long start, unsigned long end);
> +
> +	/*
> +	 * These callbacks are used with the get/put interface to manage the
> +	 * lifetime of the mmu_notifier memory. alloc_notifier() returns a new
> +	 * notifier for use with the mm.
> +	 *
> +	 * free_notifier() is only called after the mmu_notifier has been
> +	 * fully put, calls to any ops callback are prevented and no ops
> +	 * callbacks are currently running. It is called from a SRCU callback
> +	 * and cannot sleep.
> +	 */
> +	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm);
> +	void (*free_notifier)(struct mmu_notifier *mn);
>   };
>   
>   /*
> @@ -227,6 +240,9 @@ struct mmu_notifier_ops {
>   struct mmu_notifier {
>   	struct hlist_node hlist;
>   	const struct mmu_notifier_ops *ops;
> +	struct mm_struct *mm;
> +	struct rcu_head rcu;
> +	unsigned int users;
>   };
>   
>   static inline int mm_has_notifiers(struct mm_struct *mm)
> @@ -234,6 +250,21 @@ static inline int mm_has_notifiers(struct mm_struct *mm)
>   	return unlikely(mm->mmu_notifier_mm);
>   }
>   
> +struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
> +					     struct mm_struct *mm);
> +static inline struct mmu_notifier *
> +mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm)
> +{
> +	struct mmu_notifier *ret;
> +
> +	down_write(&mm->mmap_sem);
> +	ret = mmu_notifier_get_locked(ops, mm);
> +	up_write(&mm->mmap_sem);
> +	return ret;
> +}
> +void mmu_notifier_put(struct mmu_notifier *mn);
> +void mmu_notifier_synchronize(void);
> +
>   extern int mmu_notifier_register(struct mmu_notifier *mn,
>   				 struct mm_struct *mm);
>   extern int __mmu_notifier_register(struct mmu_notifier *mn,
> @@ -581,6 +612,10 @@ static inline void mmu_notifier_mm_destroy(struct mm_struct *mm)
>   #define pudp_huge_clear_flush_notify pudp_huge_clear_flush
>   #define set_pte_at_notify set_pte_at
>   
> +static inline void mmu_notifier_synchronize(void)
> +{
> +}
> +
>   #endif /* CONFIG_MMU_NOTIFIER */
>   
>   #endif /* _LINUX_MMU_NOTIFIER_H */
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 696810f632ade1..4a770b5211b71d 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -248,6 +248,9 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
>   	lockdep_assert_held_write(&mm->mmap_sem);
>   	BUG_ON(atomic_read(&mm->mm_users) <= 0);
>   
> +	mn->mm = mm;
> +	mn->users = 1;
> +
>   	if (!mm->mmu_notifier_mm) {
>   		/*
>   		 * kmalloc cannot be called under mm_take_all_locks(), but we
> @@ -295,18 +298,24 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
>   }
>   EXPORT_SYMBOL_GPL(__mmu_notifier_register);
>   
> -/*
> +/**
> + * mmu_notifier_register - Register a notifier on a mm
> + * @mn: The notifier to attach
> + * @mm : The mm to attach the notifier to

Why the space before the colon?
I know, super tiny nit.

> + *
>    * Must not hold mmap_sem nor any other VM related lock when calling
>    * this registration function. Must also ensure mm_users can't go down
>    * to zero while this runs to avoid races with mmu_notifier_release,
>    * so mm has to be current->mm or the mm should be pinned safely such
>    * as with get_task_mm(). If the mm is not current->mm, the mm_users
>    * pin should be released by calling mmput after mmu_notifier_register
> - * returns. mmu_notifier_unregister must be always called to
> - * unregister the notifier. mm_count is automatically pinned to allow
> - * mmu_notifier_unregister to safely run at any time later, before or
> - * after exit_mmap. ->release will always be called before exit_mmap
> - * frees the pages.
> + * returns.
> + *
> + * mmu_notifier_unregister() or mmu_notifier_put() must be always called to
> + * unregister the notifier.
> + *
> + * While the caller has a mmu_notifer get the mm pointer will remain valid,

s/mmu_notifer/mmu_notifier
Maybe "While the caller has a mmu_notifier, the mn->mm pointer will 
remain valid,"

> + * and can be converted to an active mm pointer via mmget_not_zero().
>    */
>   int mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
>   {
> @@ -319,6 +328,72 @@ int mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
>   }
>   EXPORT_SYMBOL_GPL(mmu_notifier_register);
>   
> +static struct mmu_notifier *
> +find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
> +{
> +	struct mmu_notifier *mn;
> +
> +	spin_lock(&mm->mmu_notifier_mm->lock);
> +	hlist_for_each_entry_rcu (mn, &mm->mmu_notifier_mm->list, hlist) {
> +		if (mn->ops != ops)
> +			continue;
> +
> +		if (likely(mn->users != UINT_MAX))
> +			mn->users++;
> +		else
> +			mn = ERR_PTR(-EOVERFLOW);
> +		spin_unlock(&mm->mmu_notifier_mm->lock);
> +		return mn;
> +	}
> +	spin_unlock(&mm->mmu_notifier_mm->lock);
> +	return NULL;
> +}
> +
> +/**
> + * mmu_notifier_get_locked - Return the single struct mmu_notifier for
> + *                           the mm & ops
> + * @ops: The operations struct being subscribe with
> + * @mm : The mm to attach notifiers too
> + *
> + * This function either allocates a new mmu_notifier via
> + * ops->alloc_notifier(), or returns an already existing notifier on the
> + * list. The value of the ops pointer is used to determine when two notifiers
> + * are the same.
> + *
> + * Each call to mmu_notifier_get() must be paired with a caller to

s/caller/call

> + * mmu_notifier_put(). The caller must hold the write side of mm->mmap_sem.
> + *
> + * While the caller has a mmu_notifer get the mm pointer will remain valid,

same as "mmu_notifer" above.

> + * and can be converted to an active mm pointer via mmget_not_zero().
> + */
> +struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
> +					     struct mm_struct *mm)
> +{
> +	struct mmu_notifier *mn;
> +	int ret;
> +
> +	lockdep_assert_held_write(&mm->mmap_sem);
> +
> +	if (mm->mmu_notifier_mm) {
> +		mn = find_get_mmu_notifier(mm, ops);
> +		if (mn)
> +			return mn;
> +	}
> +
> +	mn = ops->alloc_notifier(mm);
> +	if (IS_ERR(mn))
> +		return mn;
> +	mn->ops = ops;
> +	ret = __mmu_notifier_register(mn, mm);
> +	if (ret)
> +		goto out_free;
> +	return mn;
> +out_free:
> +	mn->ops->free_notifier(mn);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(mmu_notifier_get_locked);
> +
>   /* this is called after the last mmu_notifier_unregister() returned */
>   void __mmu_notifier_mm_destroy(struct mm_struct *mm)
>   {
> @@ -397,6 +472,75 @@ void mmu_notifier_unregister_no_release(struct mmu_notifier *mn,
>   }
>   EXPORT_SYMBOL_GPL(mmu_notifier_unregister_no_release);
>   
> +static void mmu_notifier_free_rcu(struct rcu_head *rcu)
> +{
> +	struct mmu_notifier *mn = container_of(rcu, struct mmu_notifier, rcu);
> +	struct mm_struct *mm = mn->mm;
> +
> +	mn->ops->free_notifier(mn);
> +	/* Pairs with the get in __mmu_notifier_register() */
> +	mmdrop(mm);
> +}
> +
> +/**
> + * mmu_notifier_put - Release the reference on the notifier
> + * @mn: The notifier to act on
> + *
> + * This function must be paired with each mmu_notifier_get(), it releases the
> + * reference obtained by the get. If this is the last reference then process
> + * to free the notifier will be run asynchronously.
> + *
> + * Unlike mmu_notifier_unregister() the get/put flow only calls ops->release
> + * when the mm_struct is destroyed. Instead free_notifier is always called to
> + * release any resources held by the user.
> + *
> + * As ops->release is not guaranteed to be called, the user must ensure that
> + * all sptes are dropped, and no new sptes can be established before
> + * mmu_notifier_put() is called.
> + *
> + * This function can be called from the ops->release callback, however the
> + * caller must still ensure it is called pairwise with mmu_notifier_get().
> + *
> + * Modules calling this function must call mmu_notifier_module_unload() in

I think you mean mmu_notifier_synchronize().

> + * their __exit functions to ensure the async work is completed.
> + */
> +void mmu_notifier_put(struct mmu_notifier *mn)
> +{
> +	struct mm_struct *mm = mn->mm;
> +
> +	spin_lock(&mm->mmu_notifier_mm->lock);
> +	if (WARN_ON(!mn->users) || --mn->users)
> +		goto out_unlock;
> +	hlist_del_init_rcu(&mn->hlist);
> +	spin_unlock(&mm->mmu_notifier_mm->lock);
> +
> +	call_srcu(&srcu, &mn->rcu, mmu_notifier_free_rcu);
> +	return;
> +
> +out_unlock:
> +	spin_unlock(&mm->mmu_notifier_mm->lock);
> +}
> +EXPORT_SYMBOL_GPL(mmu_notifier_put);
> +
> +/**
> + * mmu_notifier_synchronize - Ensure all mmu_notifiers are freed
> + *
> + * This function ensures that all outsanding async SRU work from

s/outsanding/outstanding

> + * mmu_notifier_put() is completed. After it returns any mmu_notifier_ops
> + * associated with an unused mmu_notifier will no longer be called.
> + *
> + * Before using the caller must ensure that all of its mmu_notifiers have been
> + * fully released via mmu_notifier_put().
> + *
> + * Modules using the mmu_notifier_put() API should call this in their __exit
> + * function to avoid module unloading races.
> + */
> +void mmu_notifier_synchronize(void)
> +{
> +	synchronize_srcu(&srcu);
> +}
> +EXPORT_SYMBOL_GPL(mmu_notifier_synchronize);
> +
>   bool
>   mmu_notifier_range_update_to_read_only(const struct mmu_notifier_range *range)
>   {
> 
