Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7829B381F6
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 01:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFFXxb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 19:53:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:9181 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfFFXxb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 19:53:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 16:53:29 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2019 16:53:29 -0700
Date:   Thu, 6 Jun 2019 16:54:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 01/11] mm/hmm: Fix use after free with struct hmm in
 the mmu notifiers
Message-ID: <20190606235440.GA13674@iweiny-DESK2.sc.intel.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-2-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523153436.19102-2-jgg@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 12:34:26PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> mmu_notifier_unregister_no_release() is not a fence and the mmu_notifier
> system will continue to reference hmm->mn until the srcu grace period
> expires.
> 
> Resulting in use after free races like this:
> 
>          CPU0                                     CPU1
>                                                __mmu_notifier_invalidate_range_start()
>                                                  srcu_read_lock
>                                                  hlist_for_each ()
>                                                    // mn == hmm->mn
> hmm_mirror_unregister()
>   hmm_put()
>     hmm_free()
>       mmu_notifier_unregister_no_release()
>          hlist_del_init_rcu(hmm-mn->list)
> 			                           mn->ops->invalidate_range_start(mn, range);
> 					             mm_get_hmm()
>       mm->hmm = NULL;
>       kfree(hmm)
>                                                      mutex_lock(&hmm->lock);
> 
> Use SRCU to kfree the hmm memory so that the notifiers can rely on hmm
> existing. Get the now-safe hmm struct through container_of and directly
> check kref_get_unless_zero to lock it against free.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  include/linux/hmm.h |  1 +
>  mm/hmm.c            | 25 +++++++++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 51ec27a8466816..8b91c90d3b88cb 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -102,6 +102,7 @@ struct hmm {
>  	struct mmu_notifier	mmu_notifier;
>  	struct rw_semaphore	mirrors_sem;
>  	wait_queue_head_t	wq;
> +	struct rcu_head		rcu;
>  	long			notifiers;
>  	bool			dead;
>  };
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 816c2356f2449f..824e7e160d8167 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -113,6 +113,11 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>  	return NULL;
>  }
>  
> +static void hmm_fee_rcu(struct rcu_head *rcu)

NIT: "free"

Other than that looks good.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> +{
> +	kfree(container_of(rcu, struct hmm, rcu));
> +}
> +
>  static void hmm_free(struct kref *kref)
>  {
>  	struct hmm *hmm = container_of(kref, struct hmm, kref);
> @@ -125,7 +130,7 @@ static void hmm_free(struct kref *kref)
>  		mm->hmm = NULL;
>  	spin_unlock(&mm->page_table_lock);
>  
> -	kfree(hmm);
> +	mmu_notifier_call_srcu(&hmm->rcu, hmm_fee_rcu);
>  }
>  
>  static inline void hmm_put(struct hmm *hmm)
> @@ -153,10 +158,14 @@ void hmm_mm_destroy(struct mm_struct *mm)
>  
>  static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  {
> -	struct hmm *hmm = mm_get_hmm(mm);
> +	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>  	struct hmm_mirror *mirror;
>  	struct hmm_range *range;
>  
> +	/* hmm is in progress to free */
> +	if (!kref_get_unless_zero(&hmm->kref))
> +		return;
> +
>  	/* Report this HMM as dying. */
>  	hmm->dead = true;
>  
> @@ -194,13 +203,15 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>  			const struct mmu_notifier_range *nrange)
>  {
> -	struct hmm *hmm = mm_get_hmm(nrange->mm);
> +	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>  	struct hmm_mirror *mirror;
>  	struct hmm_update update;
>  	struct hmm_range *range;
>  	int ret = 0;
>  
> -	VM_BUG_ON(!hmm);
> +	/* hmm is in progress to free */
> +	if (!kref_get_unless_zero(&hmm->kref))
> +		return 0;
>  
>  	update.start = nrange->start;
>  	update.end = nrange->end;
> @@ -248,9 +259,11 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>  static void hmm_invalidate_range_end(struct mmu_notifier *mn,
>  			const struct mmu_notifier_range *nrange)
>  {
> -	struct hmm *hmm = mm_get_hmm(nrange->mm);
> +	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>  
> -	VM_BUG_ON(!hmm);
> +	/* hmm is in progress to free */
> +	if (!kref_get_unless_zero(&hmm->kref))
> +		return;
>  
>  	mutex_lock(&hmm->lock);
>  	hmm->notifiers--;
> -- 
> 2.21.0
> 
