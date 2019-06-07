Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03711396D3
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfFGU3f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:29:35 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17839 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfFGU3f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:29:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfac91e0000>; Fri, 07 Jun 2019 13:29:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 13:29:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 13:29:33 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 20:29:33 +0000
Subject: Re: [PATCH v2 hmm 06/11] mm/hmm: Hold on to the mmget for the
 lifetime of the range
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-7-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <0991d7e3-091f-67d0-25a6-3d1f491db0a8@nvidia.com>
Date:   Fri, 7 Jun 2019 13:29:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-7-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559939358; bh=yYVtcUZ4S+/W6zepHFlsNYbywsPo3R3lOZVdolpu61Y=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HdsYw5tumz5N98qHW3VtBIlaGYNQK46DtmRgGWkNRA6wGhIbKibst+Ukddk1jUBXg
         gyWB6VF5Ewdl29IycHsMEmwo932SoEbNqMQaKcnN5Ox0CLqhC+u8H/ydXoVptu0pBx
         XxqXRfcEpgVIe8yOrEXNjReO8UFV+G4b9OaTRX4eo8KBLJXwPpuogaGtVqs2Co2Pg7
         7PNBtkd/s1t02WrR3iuWzUq5HYM6uBUlnFXZ323M9EUnVfO9TCVyE2a1GhvV1y1n4M
         US0lBSHQXdKy1QZ1Z2mSYzLFEEFZF9txVxIg5mnFkpYJA0c6azkArozVtq7crCF6zh
         pUY9hER+RrHqQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Range functions like hmm_range_snapshot() and hmm_range_fault() call
> find_vma, which requires hodling the mmget() and the mmap_sem for the mm.
> 
> Make this simpler for the callers by holding the mmget() inside the range
> for the lifetime of the range. Other functions that accept a range should
> only be called if the range is registered.
> 
> This has the side effect of directly preventing hmm_release() from
> happening while a range is registered. That means range->dead cannot be
> false during the lifetime of the range, so remove dead and
> hmm_mirror_mm_is_alive() entirely.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Looks good to me.
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
> v2:
>   - Use Jerome's idea of just holding the mmget() for the range lifetime,
>     rework the patch to use that as as simplification to remove dead in
>     one step
> ---
>   include/linux/hmm.h | 26 --------------------------
>   mm/hmm.c            | 28 ++++++++++------------------
>   2 files changed, 10 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 2ab35b40992b24..0e20566802967a 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -91,7 +91,6 @@
>    * @mirrors_sem: read/write semaphore protecting the mirrors list
>    * @wq: wait queue for user waiting on a range invalidation
>    * @notifiers: count of active mmu notifiers
> - * @dead: is the mm dead ?
>    */
>   struct hmm {
>   	struct mm_struct	*mm;
> @@ -104,7 +103,6 @@ struct hmm {
>   	wait_queue_head_t	wq;
>   	struct rcu_head		rcu;
>   	long			notifiers;
> -	bool			dead;
>   };
>   
>   /*
> @@ -469,30 +467,6 @@ struct hmm_mirror {
>   int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
>   void hmm_mirror_unregister(struct hmm_mirror *mirror);
>   
> -/*
> - * hmm_mirror_mm_is_alive() - test if mm is still alive
> - * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
> - * Return: false if the mm is dead, true otherwise
> - *
> - * This is an optimization, it will not always accurately return false if the
> - * mm is dead; i.e., there can be false negatives (process is being killed but
> - * HMM is not yet informed of that). It is only intended to be used to optimize
> - * out cases where the driver is about to do something time consuming and it
> - * would be better to skip it if the mm is dead.
> - */
> -static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
> -{
> -	struct mm_struct *mm;
> -
> -	if (!mirror || !mirror->hmm)
> -		return false;
> -	mm = READ_ONCE(mirror->hmm->mm);
> -	if (mirror->hmm->dead || !mm)
> -		return false;
> -
> -	return true;
> -}
> -
>   /*
>    * Please see Documentation/vm/hmm.rst for how to use the range API.
>    */
> diff --git a/mm/hmm.c b/mm/hmm.c
> index dc30edad9a8a02..f67ba32983d9f1 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -80,7 +80,6 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>   	mutex_init(&hmm->lock);
>   	kref_init(&hmm->kref);
>   	hmm->notifiers = 0;
> -	hmm->dead = false;
>   	hmm->mm = mm;
>   
>   	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
> @@ -124,20 +123,17 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   {
>   	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>   	struct hmm_mirror *mirror;
> -	struct hmm_range *range;
>   
>   	/* hmm is in progress to free */
>   	if (!kref_get_unless_zero(&hmm->kref))
>   		return;
>   
> -	/* Report this HMM as dying. */
> -	hmm->dead = true;
> -
> -	/* Wake-up everyone waiting on any range. */
>   	mutex_lock(&hmm->lock);
> -	list_for_each_entry(range, &hmm->ranges, list)
> -		range->valid = false;
> -	wake_up_all(&hmm->wq);
> +	/*
> +	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
> +	 * prevented as long as a range exists.
> +	 */
> +	WARN_ON(!list_empty(&hmm->ranges));
>   	mutex_unlock(&hmm->lock);
>   
>   	down_write(&hmm->mirrors_sem);
> @@ -909,8 +905,8 @@ int hmm_range_register(struct hmm_range *range,
>   	range->start = start;
>   	range->end = end;
>   
> -	/* Check if hmm_mm_destroy() was call. */
> -	if (hmm->mm == NULL || hmm->dead)
> +	/* Prevent hmm_release() from running while the range is valid */
> +	if (!mmget_not_zero(hmm->mm))
>   		return -EFAULT;
>   
>   	range->hmm = hmm;
> @@ -955,6 +951,7 @@ void hmm_range_unregister(struct hmm_range *range)
>   
>   	/* Drop reference taken by hmm_range_register() */
>   	range->valid = false;
> +	mmput(hmm->mm);
>   	hmm_put(hmm);
>   	range->hmm = NULL;
>   }
> @@ -982,10 +979,7 @@ long hmm_range_snapshot(struct hmm_range *range)
>   	struct vm_area_struct *vma;
>   	struct mm_walk mm_walk;
>   
> -	/* Check if hmm_mm_destroy() was call. */
> -	if (hmm->mm == NULL || hmm->dead)
> -		return -EFAULT;
> -
> +	lockdep_assert_held(&hmm->mm->mmap_sem);
>   	do {
>   		/* If range is no longer valid force retry. */
>   		if (!range->valid)
> @@ -1080,9 +1074,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
>   	struct mm_walk mm_walk;
>   	int ret;
>   
> -	/* Check if hmm_mm_destroy() was call. */
> -	if (hmm->mm == NULL || hmm->dead)
> -		return -EFAULT;
> +	lockdep_assert_held(&hmm->mm->mmap_sem);
>   
>   	do {
>   		/* If range is no longer valid force retry. */
> 
