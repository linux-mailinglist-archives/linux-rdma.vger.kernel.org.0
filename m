Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B202716D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 23:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfEVVMi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 17:12:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9517 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbfEVVMi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 17:12:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce5bb430000>; Wed, 22 May 2019 14:12:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 14:12:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 May 2019 14:12:35 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 May
 2019 21:12:31 +0000
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "Artemy Kovalyov" <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca> <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca> <20190522174852.GA23038@redhat.com>
 <20190522201247.GH6054@ziepe.ca>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <05e7f491-b8a4-4214-ab75-9ecf1128aaa6@nvidia.com>
Date:   Wed, 22 May 2019 14:12:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190522201247.GH6054@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558559555; bh=mX/CdrHkooQO7jjbW8rAIvvhdT+nRmphKetM9at3fl4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KQ4MO4k8l+72nJLn6i84C3CQ35IQKGD8fCmAUJnqiaH43emJ+Tq4QMnDM3at0c3oG
         fKaiKcy3laigtGeONQU/lsCHwd+hKJwBy8kBAPM9CvkmalcPYHm8/SINlAY7n5SLLk
         zw5vUeGhoN9s80rB8pwmqrzjT7VEK8mPmWOGD4k0CcAfOFOMxLZksmbNYWxU7hku78
         VgBIGRWR7WGIPQ33NlYQNDB/zOJ9Phe2rNUIw723n+00aZn5TK99hVsVyz8gV9/ajv
         Bw7OrdqLmaHMwWhtpVOsMF+1IQutmqv5wLHPEhWmgmdTUwyA542iZcapvY4q7VI2aD
         ehyNrkOI11anw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/22/19 1:12 PM, Jason Gunthorpe wrote:
> On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> 
>>   static void put_per_mm(struct ib_umem_odp *umem_odp)
>>   {
>>   	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
>> @@ -325,9 +283,10 @@ static void put_per_mm(struct ib_umem_odp *umem_odp)
>>   	up_write(&per_mm->umem_rwsem);
>>   
>>   	WARN_ON(!RB_EMPTY_ROOT(&per_mm->umem_tree.rb_root));
>> -	mmu_notifier_unregister_no_release(&per_mm->mn, per_mm->mm);
>> +	hmm_mirror_unregister(&per_mm->mirror);
>>   	put_pid(per_mm->tgid);
>> -	mmu_notifier_call_srcu(&per_mm->rcu, free_per_mm);
>> +
>> +	kfree(per_mm);
> 
> Notice that mmu_notifier only uses SRCU to fence in-progress ops
> callbacks, so I think hmm internally has the bug that this ODP
> approach prevents.
> 
> hmm should follow the same pattern ODP has and 'kfree_srcu' the hmm
> struct, use container_of in the mmu_notifier callbacks, and use the
> otherwise vestigal kref_get_unless_zero() to bail:

You might also want to look at my patch where
I try to fix some of these same issues (5/5).

https://marc.info/?l=linux-mm&m=155718572908765&w=2


>  From 0cb536dc0150ba964a1d655151d7b7a84d0f915a Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Wed, 22 May 2019 16:52:52 -0300
> Subject: [PATCH] hmm: Fix use after free with struct hmm in the mmu notifiers
> 
> mmu_notifier_unregister_no_release() is not a fence and the mmu_notifier
> system will continue to reference hmm->mn until the srcu grace period
> expires.
> 
>           CPU0                                     CPU1
>                                                 __mmu_notifier_invalidate_range_start()
>                                                   srcu_read_lock
>                                                   hlist_for_each ()
>                                                     // mn == hmm->mn
> hmm_mirror_unregister()
>    hmm_put()
>      hmm_free()
>        mmu_notifier_unregister_no_release()
>           hlist_del_init_rcu(hmm-mn->list)
> 			                           mn->ops->invalidate_range_start(mn, range);
> 					             mm_get_hmm()
>        mm->hmm = NULL;
>        kfree(hmm)
>                                                       mutex_lock(&hmm->lock);
> 
> Use SRCU to kfree the hmm memory so that the notifiers can rely on hmm
> existing. Get the now-safe hmm struct through container_of and directly
> check kref_get_unless_zero to lock it against free.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>   include/linux/hmm.h |  1 +
>   mm/hmm.c            | 25 +++++++++++++++++++------
>   2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 51ec27a8466816..8b91c90d3b88cb 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -102,6 +102,7 @@ struct hmm {
>   	struct mmu_notifier	mmu_notifier;
>   	struct rw_semaphore	mirrors_sem;
>   	wait_queue_head_t	wq;
> +	struct rcu_head		rcu;
>   	long			notifiers;
>   	bool			dead;
>   };
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 816c2356f2449f..824e7e160d8167 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -113,6 +113,11 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>   	return NULL;
>   }
>   
> +static void hmm_fee_rcu(struct rcu_head *rcu)
> +{
> +	kfree(container_of(rcu, struct hmm, rcu));
> +}
> +
>   static void hmm_free(struct kref *kref)
>   {
>   	struct hmm *hmm = container_of(kref, struct hmm, kref);
> @@ -125,7 +130,7 @@ static void hmm_free(struct kref *kref)
>   		mm->hmm = NULL;
>   	spin_unlock(&mm->page_table_lock);
>   
> -	kfree(hmm);
> +	mmu_notifier_call_srcu(&hmm->rcu, hmm_fee_rcu);
>   }
>   
>   static inline void hmm_put(struct hmm *hmm)
> @@ -153,10 +158,14 @@ void hmm_mm_destroy(struct mm_struct *mm)
>   
>   static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   {
> -	struct hmm *hmm = mm_get_hmm(mm);
> +	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>   	struct hmm_mirror *mirror;
>   	struct hmm_range *range;
>   
> +	/* hmm is in progress to free */
> +	if (!kref_get_unless_zero(&hmm->kref))
> +		return;
> +
>   	/* Report this HMM as dying. */
>   	hmm->dead = true;
>   
> @@ -194,13 +203,15 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>   			const struct mmu_notifier_range *nrange)
>   {
> -	struct hmm *hmm = mm_get_hmm(nrange->mm);
> +	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>   	struct hmm_mirror *mirror;
>   	struct hmm_update update;
>   	struct hmm_range *range;
>   	int ret = 0;
>   
> -	VM_BUG_ON(!hmm);
> +	/* hmm is in progress to free */
> +	if (!kref_get_unless_zero(&hmm->kref))
> +		return 0;
>   
>   	update.start = nrange->start;
>   	update.end = nrange->end;
> @@ -248,9 +259,11 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>   static void hmm_invalidate_range_end(struct mmu_notifier *mn,
>   			const struct mmu_notifier_range *nrange)
>   {
> -	struct hmm *hmm = mm_get_hmm(nrange->mm);
> +	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>   
> -	VM_BUG_ON(!hmm);
> +	/* hmm is in progress to free */
> +	if (!kref_get_unless_zero(&hmm->kref))
> +		return;
>   
>   	mutex_lock(&hmm->lock);
>   	hmm->notifiers--;
> 
