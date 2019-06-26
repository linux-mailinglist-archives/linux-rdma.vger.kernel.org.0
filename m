Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C757076
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 20:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFZSS2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 14:18:28 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16829 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZSS2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jun 2019 14:18:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d13b6f10000>; Wed, 26 Jun 2019 11:18:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 26 Jun 2019 11:18:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 26 Jun 2019 11:18:25 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Jun
 2019 18:18:23 +0000
Subject: Re: [PATCH v4 hmm 12/12] mm/hmm: Fix error flows in
 hmm_invalidate_range_start
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Philip Yang <Philip.Yang@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190624210110.5098-1-jgg@ziepe.ca>
 <20190624210110.5098-13-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <035fa354-6caa-3738-b84d-20804813009a@nvidia.com>
Date:   Wed, 26 Jun 2019 11:18:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190624210110.5098-13-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561573105; bh=cYapjH49w+mpLgSg9Urbt+jP21Tl5ENB43gy2XeqD5U=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=T+UpPVnWywyEnsAY8yH8FmNePn8+ExP7J5i/rd/ELTGbm3iwXkz726U/UZsZ/ZzLr
         eWJ3bBzDBIkWNht0+2fGMfK5t1ew2XnTyEYv9+EiXZBi7FxGjfsRVervLRjZvhM15o
         Q8pIIKXKvSBx0gw70zrGn3mxkDos8O+HvYcpQl6Ca7ADmhB6m1w3DYStKBP0DeHE3G
         Fj0JkJpoog3uvEq6+42SGFjW20IY27qegm+qjH/km1KatzyW8fX5cRv67UJxW7kYBe
         XpJDp350CdiDG6Uh9m21g7QVn0/RTQDzu9Ad9/ffUuTE70megt8N0+wSJyAWDZJldF
         efBGJNPDCEolA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/24/19 2:01 PM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> If the trylock on the hmm->mirrors_sem fails the function will return
> without decrementing the notifiers that were previously incremented. Since
> the caller will not call invalidate_range_end() on EAGAIN this will result
> in notifiers becoming permanently incremented and deadlock.
> 
> If the sync_cpu_device_pagetables() required blocking the function will
> not return EAGAIN even though the device continues to touch the
> pages. This is a violation of the mmu notifier contract.
> 
> Switch, and rename, the ranges_lock to a spin lock so we can reliably
> obtain it without blocking during error unwind.
> 
> The error unwind is necessary since the notifiers count must be held
> incremented across the call to sync_cpu_device_pagetables() as we cannot
> allow the range to become marked valid by a parallel
> invalidate_start/end() pair while doing sync_cpu_device_pagetables().
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   include/linux/hmm.h |  2 +-
>   mm/hmm.c            | 72 +++++++++++++++++++++++++++------------------
>   2 files changed, 45 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index bf013e96525771..0fa8ea34ccef6d 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -86,7 +86,7 @@
>   struct hmm {
>   	struct mm_struct	*mm;
>   	struct kref		kref;
> -	struct mutex		lock;
> +	spinlock_t		ranges_lock;
>   	struct list_head	ranges;
>   	struct list_head	mirrors;
>   	struct mmu_notifier	mmu_notifier;
> diff --git a/mm/hmm.c b/mm/hmm.c
> index b224ea635a7716..89549eac03d506 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -64,7 +64,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>   	init_rwsem(&hmm->mirrors_sem);
>   	hmm->mmu_notifier.ops = NULL;
>   	INIT_LIST_HEAD(&hmm->ranges);
> -	mutex_init(&hmm->lock);
> +	spin_lock_init(&hmm->ranges_lock);
>   	kref_init(&hmm->kref);
>   	hmm->notifiers = 0;
>   	hmm->mm = mm;
> @@ -144,6 +144,23 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	hmm_put(hmm);
>   }
>   
> +static void notifiers_decrement(struct hmm *hmm)
> +{
> +	lockdep_assert_held(&hmm->ranges_lock);
> +

Why not acquire the lock here and release at the end instead
of asserting the lock is held?
It looks like everywhere notifiers_decrement() is called does
that.

> +	hmm->notifiers--;
> +	if (!hmm->notifiers) {
> +		struct hmm_range *range;
> +
> +		list_for_each_entry(range, &hmm->ranges, list) {
> +			if (range->valid)
> +				continue;
> +			range->valid = true;
> +		}
> +		wake_up_all(&hmm->wq);
> +	}
> +}
> +
>   static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>   			const struct mmu_notifier_range *nrange)
>   {
> @@ -151,6 +168,7 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>   	struct hmm_mirror *mirror;
>   	struct hmm_update update;
>   	struct hmm_range *range;
> +	unsigned long flags;
>   	int ret = 0;
>   
>   	if (!kref_get_unless_zero(&hmm->kref))
> @@ -161,12 +179,7 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>   	update.event = HMM_UPDATE_INVALIDATE;
>   	update.blockable = mmu_notifier_range_blockable(nrange);
>   
> -	if (mmu_notifier_range_blockable(nrange))
> -		mutex_lock(&hmm->lock);
> -	else if (!mutex_trylock(&hmm->lock)) {
> -		ret = -EAGAIN;
> -		goto out;
> -	}
> +	spin_lock_irqsave(&hmm->ranges_lock, flags);
>   	hmm->notifiers++;
>   	list_for_each_entry(range, &hmm->ranges, list) {
>   		if (update.end < range->start || update.start >= range->end)
> @@ -174,7 +187,7 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>   
>   		range->valid = false;
>   	}
> -	mutex_unlock(&hmm->lock);
> +	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
>   
>   	if (mmu_notifier_range_blockable(nrange))
>   		down_read(&hmm->mirrors_sem);
> @@ -182,16 +195,26 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>   		ret = -EAGAIN;
>   		goto out;
>   	}
> +
>   	list_for_each_entry(mirror, &hmm->mirrors, list) {
> -		int ret;
> +		int rc;
>   
> -		ret = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
> -		if (!update.blockable && ret == -EAGAIN)
> +		rc = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
> +		if (rc) {
> +			if (WARN_ON(update.blockable || rc != -EAGAIN))
> +				continue;
> +			ret = -EAGAIN;
>   			break;
> +		}
>   	}
>   	up_read(&hmm->mirrors_sem);
>   
>   out:
> +	if (ret) {
> +		spin_lock_irqsave(&hmm->ranges_lock, flags);
> +		notifiers_decrement(hmm);
> +		spin_unlock_irqrestore(&hmm->ranges_lock, flags);
> +	}
>   	hmm_put(hmm);
>   	return ret;
>   }
> @@ -200,23 +223,14 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
>   			const struct mmu_notifier_range *nrange)
>   {
>   	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
> +	unsigned long flags;
>   
>   	if (!kref_get_unless_zero(&hmm->kref))
>   		return;
>   
> -	mutex_lock(&hmm->lock);
> -	hmm->notifiers--;
> -	if (!hmm->notifiers) {
> -		struct hmm_range *range;
> -
> -		list_for_each_entry(range, &hmm->ranges, list) {
> -			if (range->valid)
> -				continue;
> -			range->valid = true;
> -		}
> -		wake_up_all(&hmm->wq);
> -	}
> -	mutex_unlock(&hmm->lock);
> +	spin_lock_irqsave(&hmm->ranges_lock, flags);
> +	notifiers_decrement(hmm);
> +	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
>   
>   	hmm_put(hmm);
>   }
> @@ -868,6 +882,7 @@ int hmm_range_register(struct hmm_range *range,
>   {
>   	unsigned long mask = ((1UL << page_shift) - 1UL);
>   	struct hmm *hmm = mirror->hmm;
> +	unsigned long flags;
>   
>   	range->valid = false;
>   	range->hmm = NULL;
> @@ -886,7 +901,7 @@ int hmm_range_register(struct hmm_range *range,
>   		return -EFAULT;
>   
>   	/* Initialize range to track CPU page table updates. */
> -	mutex_lock(&hmm->lock);
> +	spin_lock_irqsave(&hmm->ranges_lock, flags);
>   
>   	range->hmm = hmm;
>   	kref_get(&hmm->kref);
> @@ -898,7 +913,7 @@ int hmm_range_register(struct hmm_range *range,
>   	 */
>   	if (!hmm->notifiers)
>   		range->valid = true;
> -	mutex_unlock(&hmm->lock);
> +	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
>   
>   	return 0;
>   }
> @@ -914,10 +929,11 @@ EXPORT_SYMBOL(hmm_range_register);
>   void hmm_range_unregister(struct hmm_range *range)
>   {
>   	struct hmm *hmm = range->hmm;
> +	unsigned long flags;
>   
> -	mutex_lock(&hmm->lock);
> +	spin_lock_irqsave(&hmm->ranges_lock, flags);
>   	list_del_init(&range->list);
> -	mutex_unlock(&hmm->lock);
> +	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
>   
>   	/* Drop reference taken by hmm_range_register() */
>   	mmput(hmm->mm);
> 
