Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14E8398DB
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 00:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfFGWhD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 18:37:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:13006 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbfFGWhD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 18:37:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 15:37:02 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2019 15:37:01 -0700
Date:   Fri, 7 Jun 2019 15:38:16 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 hmm 03/11] mm/hmm: Hold a mmgrab from hmm to mm
Message-ID: <20190607223815.GE14559@iweiny-DESK2.sc.intel.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-4-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606184438.31646-4-jgg@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 03:44:30PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> So long a a struct hmm pointer exists, so should the struct mm it is
> linked too. Hold the mmgrab() as soon as a hmm is created, and mmdrop() it
> once the hmm refcount goes to zero.
> 
> Since mmdrop() (ie a 0 kref on struct mm) is now impossible with a !NULL
> mm->hmm delete the hmm_hmm_destroy().
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> v2:
>  - Fix error unwind paths in hmm_get_or_create (Jerome/Jason)
> ---
>  include/linux/hmm.h |  3 ---
>  kernel/fork.c       |  1 -
>  mm/hmm.c            | 22 ++++------------------
>  3 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 2d519797cb134a..4ee3acabe5ed22 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -586,14 +586,11 @@ static inline int hmm_vma_fault(struct hmm_mirror *mirror,
>  }
>  
>  /* Below are for HMM internal use only! Not to be used by device driver! */
> -void hmm_mm_destroy(struct mm_struct *mm);
> -
>  static inline void hmm_mm_init(struct mm_struct *mm)
>  {
>  	mm->hmm = NULL;
>  }
>  #else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
> -static inline void hmm_mm_destroy(struct mm_struct *mm) {}
>  static inline void hmm_mm_init(struct mm_struct *mm) {}
>  #endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b2b87d450b80b5..588c768ae72451 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -673,7 +673,6 @@ void __mmdrop(struct mm_struct *mm)
>  	WARN_ON_ONCE(mm == current->active_mm);
>  	mm_free_pgd(mm);
>  	destroy_context(mm);
> -	hmm_mm_destroy(mm);
>  	mmu_notifier_mm_destroy(mm);
>  	check_mm(mm);
>  	put_user_ns(mm->user_ns);
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 8796447299023c..cc7c26fda3300e 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -29,6 +29,7 @@
>  #include <linux/swapops.h>
>  #include <linux/hugetlb.h>
>  #include <linux/memremap.h>
> +#include <linux/sched/mm.h>
>  #include <linux/jump_label.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/mmu_notifier.h>
> @@ -82,6 +83,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>  	hmm->notifiers = 0;
>  	hmm->dead = false;
>  	hmm->mm = mm;
> +	mmgrab(hmm->mm);
>  
>  	spin_lock(&mm->page_table_lock);
>  	if (!mm->hmm)
> @@ -109,6 +111,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>  		mm->hmm = NULL;
>  	spin_unlock(&mm->page_table_lock);
>  error:
> +	mmdrop(hmm->mm);
>  	kfree(hmm);
>  	return NULL;
>  }
> @@ -130,6 +133,7 @@ static void hmm_free(struct kref *kref)
>  		mm->hmm = NULL;
>  	spin_unlock(&mm->page_table_lock);
>  
> +	mmdrop(hmm->mm);
>  	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
>  }
>  
> @@ -138,24 +142,6 @@ static inline void hmm_put(struct hmm *hmm)
>  	kref_put(&hmm->kref, hmm_free);
>  }
>  
> -void hmm_mm_destroy(struct mm_struct *mm)
> -{
> -	struct hmm *hmm;
> -
> -	spin_lock(&mm->page_table_lock);
> -	hmm = mm_get_hmm(mm);
> -	mm->hmm = NULL;
> -	if (hmm) {
> -		hmm->mm = NULL;
> -		hmm->dead = true;
> -		spin_unlock(&mm->page_table_lock);
> -		hmm_put(hmm);
> -		return;
> -	}
> -
> -	spin_unlock(&mm->page_table_lock);
> -}
> -
>  static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  {
>  	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
> -- 
> 2.21.0
> 
