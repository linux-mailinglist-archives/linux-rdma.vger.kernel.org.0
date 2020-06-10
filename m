Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FCA1F541E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2020 14:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgFJMB6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jun 2020 08:01:58 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:59736 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgFJMB4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jun 2020 08:01:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 967603F52B;
        Wed, 10 Jun 2020 14:01:52 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=rokWsKZx;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wfACO79HRCQ6; Wed, 10 Jun 2020 14:01:47 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 2047D3F528;
        Wed, 10 Jun 2020 14:01:45 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 5ACD2360060;
        Wed, 10 Jun 2020 14:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1591790505; bh=6BrG2kMCY685Tdd83env55bWNJRACBkBovg8ct8pWp4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rokWsKZxKkDgXfW/zCjExrZ/Wf48SuLt5jmfXPdF8I//Ks1S/DSsalOXTxB+RnGqN
         7AUkrIFcDWrYmNoRA55rX7lJ9nbff9qCcXgrbW/1/6le9B1jDAq3Wt9iq3BP2PV8m3
         ynGopja1IvhqW2W/OVlh6jQ1HPb2lL2N2MDeWpQ4=
Subject: Re: [PATCH 01/18] mm: Track mmu notifiers in
 fs_reclaim_acquire/release
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-2-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <15bcdddd-b560-e98b-eaec-62277b5ab4af@shipmail.org>
Date:   Wed, 10 Jun 2020 14:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604081224.863494-2-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Daniel,

Please see below.

On 6/4/20 10:12 AM, Daniel Vetter wrote:
> fs_reclaim_acquire/release nicely catch recursion issues when
> allocating GFP_KERNEL memory against shrinkers (which gpu drivers tend
> to use to keep the excessive caches in check). For mmu notifier
> recursions we do have lockdep annotations since 23b68395c7c7
> ("mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end").
>
> But these only fire if a path actually results in some pte
> invalidation - for most small allocations that's very rarely the case.
> The other trouble is that pte invalidation can happen any time when
> __GFP_RECLAIM is set. Which means only really GFP_ATOMIC is a safe
> choice, GFP_NOIO isn't good enough to avoid potential mmu notifier
> recursion.
>
> I was pondering whether we should just do the general annotation, but
> there's always the risk for false positives. Plus I'm assuming that
> the core fs and io code is a lot better reviewed and tested than
> random mmu notifier code in drivers. Hence why I decide to only
> annotate for that specific case.
>
> Furthermore even if we'd create a lockdep map for direct reclaim, we'd
> still need to explicit pull in the mmu notifier map - there's a lot
> more places that do pte invalidation than just direct reclaim, these
> two contexts arent the same.
>
> Note that the mmu notifiers needing their own independent lockdep map
> is also the reason we can't hold them from fs_reclaim_acquire to
> fs_reclaim_release - it would nest with the acquistion in the pte
> invalidation code, causing a lockdep splat. And we can't remove the
> annotations from pte invalidation and all the other places since
> they're called from many other places than page reclaim. Hence we can
> only do the equivalent of might_lock, but on the raw lockdep map.
>
> With this we can also remove the lockdep priming added in 66204f1d2d1b
> ("mm/mmu_notifiers: prime lockdep") since the new annotations are
> strictly more powerful.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: linux-mm@kvack.org
> Cc: linux-rdma@vger.kernel.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
> This is part of a gpu lockdep annotation series simply because it
> really helps to catch issues where gpu subsystem locks and primitives
> can deadlock with themselves through allocations and mmu notifiers.
> But aside from that motivation it should be completely free-standing,
> and can land through -mm/-rdma/-hmm or any other tree really whenever.
> -Daniel
> ---
>   mm/mmu_notifier.c |  7 -------
>   mm/page_alloc.c   | 23 ++++++++++++++---------
>   2 files changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 06852b896fa6..5d578b9122f8 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -612,13 +612,6 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
>   	lockdep_assert_held_write(&mm->mmap_sem);
>   	BUG_ON(atomic_read(&mm->mm_users) <= 0);
>   
> -	if (IS_ENABLED(CONFIG_LOCKDEP)) {
> -		fs_reclaim_acquire(GFP_KERNEL);
> -		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
> -		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> -		fs_reclaim_release(GFP_KERNEL);
> -	}
> -
>   	if (!mm->notifier_subscriptions) {
>   		/*
>   		 * kmalloc cannot be called under mm_take_all_locks(), but we
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 13cc653122b7..f8a222db4a53 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -57,6 +57,7 @@
>   #include <trace/events/oom.h>
>   #include <linux/prefetch.h>
>   #include <linux/mm_inline.h>
> +#include <linux/mmu_notifier.h>
>   #include <linux/migrate.h>
>   #include <linux/hugetlb.h>
>   #include <linux/sched/rt.h>
> @@ -4124,7 +4125,7 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
>   static struct lockdep_map __fs_reclaim_map =
>   	STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);
>   
> -static bool __need_fs_reclaim(gfp_t gfp_mask)
> +static bool __need_reclaim(gfp_t gfp_mask)
>   {
>   	gfp_mask = current_gfp_context(gfp_mask);
>   
> @@ -4136,10 +4137,6 @@ static bool __need_fs_reclaim(gfp_t gfp_mask)
>   	if (current->flags & PF_MEMALLOC)
>   		return false;
>   
> -	/* We're only interested __GFP_FS allocations for now */
> -	if (!(gfp_mask & __GFP_FS))
> -		return false;
> -
>   	if (gfp_mask & __GFP_NOLOCKDEP)
>   		return false;
>   
> @@ -4158,15 +4155,23 @@ void __fs_reclaim_release(void)
>   
>   void fs_reclaim_acquire(gfp_t gfp_mask)
>   {
> -	if (__need_fs_reclaim(gfp_mask))
> -		__fs_reclaim_acquire();
> +	if (__need_reclaim(gfp_mask)) {
> +		if (!(gfp_mask & __GFP_FS))
Hmm. Shouldn't this be "if (gfp_mask & __GFP_FS)" or am I misunderstanding?
> +			__fs_reclaim_acquire();


#ifdef CONFIG_MMU_NOTIFIER?

> +
> +		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
> +		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> +
> +	}
>   }
>   EXPORT_SYMBOL_GPL(fs_reclaim_acquire);
>   
>   void fs_reclaim_release(gfp_t gfp_mask)
>   {
> -	if (__need_fs_reclaim(gfp_mask))
> -		__fs_reclaim_release();
> +	if (__need_reclaim(gfp_mask)) {
> +		if (!(gfp_mask & __GFP_FS))
Same here?
> +			__fs_reclaim_release();
> +	}
>   }
>   EXPORT_SYMBOL_GPL(fs_reclaim_release);
>   #endif

One suggested test case would perhaps be to call madvise(madv_dontneed) 
on a subpart of a transhuge page. That would IIRC trigger a page split 
and interesting mmu notifier calls....

Thanks,
Thomas


