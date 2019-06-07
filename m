Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2F39407
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfFGSMT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 14:12:19 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11634 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfFGSMT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 14:12:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfaa8f10000>; Fri, 07 Jun 2019 11:12:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 11:12:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Jun 2019 11:12:17 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 18:12:14 +0000
Subject: Re: [PATCH v2 hmm 01/11] mm/hmm: fix use after free with struct hmm
 in the mmu notifiers
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-2-jgg@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <377cadfa-180e-9a6a-49df-0c2c27ae6fb3@nvidia.com>
Date:   Fri, 7 Jun 2019 11:12:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-2-jgg@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559931122; bh=yvViGcleFu6fAY5Z1ueRI2Sd+W1uzOgNJahahekeWt4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GwkD8xsCGHW0KQ7XDbv8wawHd+SJN+lRqrAQpT/q6IxU90uItm8+7KTvX+8unVVF7
         Vz00qV1V8aOiQueD3BHPHHGFZQnANCqbwbnRRbBFwh3oJhF3aWr4/aVmfy0TkhKL+W
         lmrPKNeaNFVPyriJVct/0VeUfyZ1MufFzoGvniQz+6lRXlnYRx5V3xeqPhkXlq2I54
         ZO79+tNGlAT4Ihs91XWeiX8VLNCv226zJTLdk0nY1y9xEBj/6xZQqrOC13Y2hVUrI/
         ZBcxJUBuG8iMwDX7QBnuTnYytNPULKEzM6tmkNK9OnPziujs0OLxsvUVUEuBUQVLdA
         TOS8OF+mbpUPw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> mmu_notifier_unregister_no_release() is not a fence and the mmu_notifier
> system will continue to reference hmm->mn until the srcu grace period
> expires.
> 
> Resulting in use after free races like this:
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

You can add
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
> v2:
> - Spell 'free' properly (Jerome/Ralph)
> ---
>   include/linux/hmm.h |  1 +
>   mm/hmm.c            | 25 +++++++++++++++++++------
>   2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 092f0234bfe917..688c5ca7068795 100644
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
> index 8e7403f081f44a..547002f56a163d 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -113,6 +113,11 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>   	return NULL;
>   }
>   
> +static void hmm_free_rcu(struct rcu_head *rcu)
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
> +	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
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
> @@ -245,9 +256,11 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
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
