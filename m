Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED2C394B0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfFGSwk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 14:52:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15559 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbfFGSwk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 14:52:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfab2730000>; Fri, 07 Jun 2019 11:52:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 11:52:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 11:52:37 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 18:52:33 +0000
Subject: Re: [PATCH v2 hmm 04/11] mm/hmm: Simplify hmm_get_or_create and make
 it reliable
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-5-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <b4a65f1c-3c77-4d87-ef73-105a228ef5c5@nvidia.com>
Date:   Fri, 7 Jun 2019 11:52:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-5-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559933555; bh=JqPVjfnMUsVeriG51gkWP6yZJVSw9KGyEZqOWsZkh5s=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=o3/Dw8k5XmUikUSMfkLR2Ul1W+S62I/WdXmLNUJUPldK6bbzIkRUXYmeVUKur2tk2
         hRglFo1y61L9h+ML/qFrFBzlZlDUM6JlOgJpCsG3r6s9WEWXEfgT1glvkbOjZlKqjm
         GE1lNjGpCideng6jNvECw+LuqNOBghJgxhxohC/SiemfE+Cd5+SeVW8/L90bgqv5/N
         gdoay8YDSEOL7LQDzr4xYrLARW7Ve+n/eVSP9mk6HKh6mmn2JLgEggrUhXzxQ4P2uI
         kYPKIYY6R/zyYKv/J0WRHRpC08/YADLNQQAEAjjEqo8sQf09L6FJF5RFB0CGoWQXMj
         VAlrl2LTDd8qA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> As coded this function can false-fail in various racy situations. Make it
> reliable by running only under the write side of the mmap_sem and avoiding
> the false-failing compare/exchange pattern.
> 
> Also make the locking very easy to understand by only ever reading or
> writing mm->hmm while holding the write side of the mmap_sem.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
> v2:
> - Fix error unwind of mmgrab (Jerome)
> - Use hmm local instead of 2nd container_of (Jerome)
> ---
>   mm/hmm.c | 80 ++++++++++++++++++++------------------------------------
>   1 file changed, 29 insertions(+), 51 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index cc7c26fda3300e..dc30edad9a8a02 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -40,16 +40,6 @@
>   #if IS_ENABLED(CONFIG_HMM_MIRROR)
>   static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
>   
> -static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
> -{
> -	struct hmm *hmm = READ_ONCE(mm->hmm);
> -
> -	if (hmm && kref_get_unless_zero(&hmm->kref))
> -		return hmm;
> -
> -	return NULL;
> -}
> -
>   /**
>    * hmm_get_or_create - register HMM against an mm (HMM internal)
>    *
> @@ -64,11 +54,20 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
>    */
>   static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>   {
> -	struct hmm *hmm = mm_get_hmm(mm);
> -	bool cleanup = false;
> +	struct hmm *hmm;
>   
> -	if (hmm)
> -		return hmm;
> +	lockdep_assert_held_exclusive(&mm->mmap_sem);
> +
> +	if (mm->hmm) {
> +		if (kref_get_unless_zero(&mm->hmm->kref))
> +			return mm->hmm;
> +		/*
> +		 * The hmm is being freed by some other CPU and is pending a
> +		 * RCU grace period, but this CPU can NULL now it since we
> +		 * have the mmap_sem.
> +		 */
> +		mm->hmm = NULL;
> +	}
>   
>   	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
>   	if (!hmm)
> @@ -83,57 +82,36 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>   	hmm->notifiers = 0;
>   	hmm->dead = false;
>   	hmm->mm = mm;
> -	mmgrab(hmm->mm);
> -
> -	spin_lock(&mm->page_table_lock);
> -	if (!mm->hmm)
> -		mm->hmm = hmm;
> -	else
> -		cleanup = true;
> -	spin_unlock(&mm->page_table_lock);
>   
> -	if (cleanup)
> -		goto error;
> -
> -	/*
> -	 * We should only get here if hold the mmap_sem in write mode ie on
> -	 * registration of first mirror through hmm_mirror_register()
> -	 */
>   	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
> -	if (__mmu_notifier_register(&hmm->mmu_notifier, mm))
> -		goto error_mm;
> +	if (__mmu_notifier_register(&hmm->mmu_notifier, mm)) {
> +		kfree(hmm);
> +		return NULL;
> +	}
>   
> +	mmgrab(hmm->mm);
> +	mm->hmm = hmm;
>   	return hmm;
> -
> -error_mm:
> -	spin_lock(&mm->page_table_lock);
> -	if (mm->hmm == hmm)
> -		mm->hmm = NULL;
> -	spin_unlock(&mm->page_table_lock);
> -error:
> -	mmdrop(hmm->mm);
> -	kfree(hmm);
> -	return NULL;
>   }
>   
>   static void hmm_free_rcu(struct rcu_head *rcu)
>   {
> -	kfree(container_of(rcu, struct hmm, rcu));
> +	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
> +
> +	down_write(&hmm->mm->mmap_sem);
> +	if (hmm->mm->hmm == hmm)
> +		hmm->mm->hmm = NULL;
> +	up_write(&hmm->mm->mmap_sem);
> +	mmdrop(hmm->mm);
> +
> +	kfree(hmm);
>   }
>   
>   static void hmm_free(struct kref *kref)
>   {
>   	struct hmm *hmm = container_of(kref, struct hmm, kref);
> -	struct mm_struct *mm = hmm->mm;
> -
> -	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
>   
> -	spin_lock(&mm->page_table_lock);
> -	if (mm->hmm == hmm)
> -		mm->hmm = NULL;
> -	spin_unlock(&mm->page_table_lock);
> -
> -	mmdrop(hmm->mm);
> +	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, hmm->mm);
>   	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
>   }
>   
> 
