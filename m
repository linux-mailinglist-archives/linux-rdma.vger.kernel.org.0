Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E084528DE8
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 01:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbfEWXig (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 19:38:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17106 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfEWXig (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 19:38:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce72efa0000>; Thu, 23 May 2019 16:38:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 May 2019 16:38:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 May 2019 16:38:34 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 23:38:28 +0000
Subject: Re: [RFC PATCH 04/11] mm/hmm: Simplify hmm_get_or_create and make it
 reliable
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-5-jgg@ziepe.ca>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <6945b6c9-338a-54e6-64df-2590d536910a@nvidia.com>
Date:   Thu, 23 May 2019 16:38:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190523153436.19102-5-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558654714; bh=b2p6msGZOO1o6S/1xXYAPaJstC2ds8NUPA6vMi5IZfQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mD5Bb1ljRlQVnOXf6N0+Gn9PipOahIO4xwqqHApUTi/EQT0VsA0WHW2c+jZ+K/Ivv
         kbjwUw3D5GzhyV8DdOOjCYiBzzfpCingWfKO4uAbnhG4W7uhia7Ct2QqYZZMn7inO/
         M0rvAfHN0iWUHpU8LCbyNsafRXJjPqMO/ri8AmZgMRJKDwg4w7mgYlG9pr3UpvrjxD
         nvomTrVL/nhavUBfbEkKcqhg3sth0el6LVCvn3gqK8ucxmI1xVERb7evMyEIV0WYrj
         RxkbiMWNNyNOHxc99Caepn8sfrDO7xtk3xIy3yDNJBfpxIsNh08cFSYqM6peYzPjJR
         US6/8Q6ULMK1g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/23/19 8:34 AM, Jason Gunthorpe wrote:
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
> ---
>   mm/hmm.c | 75 ++++++++++++++++++++------------------------------------
>   1 file changed, 27 insertions(+), 48 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index e27058e92508b9..ec54be54d81135 100644
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
> +	lockdep_assert_held_exclusive(mm->mmap_sem);
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

Shouldn't there be a "return NULL;" here so it doesn't fall through and
allocate a struct hmm below?

> +	}
>   
>   	hmm = kmalloc(sizeof(*hmm), GFP_KERNEL);
>   	if (!hmm)
> @@ -85,54 +84,34 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>   	hmm->mm = mm;
>   	mmgrab(hmm->mm);
>   
> -	spin_lock(&mm->page_table_lock);
> -	if (!mm->hmm)
> -		mm->hmm = hmm;
> -	else
> -		cleanup = true;
> -	spin_unlock(&mm->page_table_lock);
> -
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
> +	mm->hmm = hmm;
>   	return hmm;
> -
> -error_mm:
> -	spin_lock(&mm->page_table_lock);
> -	if (mm->hmm == hmm)
> -		mm->hmm = NULL;
> -	spin_unlock(&mm->page_table_lock);
> -error:
> -	kfree(hmm);
> -	return NULL;
>   }
>   
>   static void hmm_fee_rcu(struct rcu_head *rcu)

I see Jerome already saw and named this hmm_free_rcu()
which I agree with.

>   {
> +	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
> +
> +	down_write(&hmm->mm->mmap_sem);
> +	if (hmm->mm->hmm == hmm)
> +		hmm->mm->hmm = NULL;
> +	up_write(&hmm->mm->mmap_sem);
> +	mmdrop(hmm->mm);
> +
>   	kfree(container_of(rcu, struct hmm, rcu));
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
>   	mmu_notifier_call_srcu(&hmm->rcu, hmm_fee_rcu);
>   }
>   
> 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
