Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326E7382B1
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 04:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFGC3O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 22:29:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19278 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFGC3N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 22:29:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf9cbf60000>; Thu, 06 Jun 2019 19:29:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 19:29:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 19:29:12 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 02:29:09 +0000
Subject: Re: [PATCH v2 hmm 01/11] mm/hmm: fix use after free with struct hmm
 in the mmu notifiers
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-2-jgg@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <9c72d18d-2924-cb90-ea44-7cd4b10b5bc2@nvidia.com>
Date:   Thu, 6 Jun 2019 19:29:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-2-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559874551; bh=R2R56MRPrIqjPZeEw7fbzIpQNK89LlEqC86AIWezMqg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=E08PdBQW7QWns3XtneChNvM+k4Mj3Hpm1wXqD3gC80a5hnrfSkAEsTdHcVOcgJ3Yd
         RStazpAX7nsLBehKZIY9KjtLbbYBPd7OAF3nseh/PvkL2ME60LVIFHybN8vj6Trf4U
         dLwYzLYgYQU4rUtkBtix+3NPH4uSNsbVbyeM+7Wn1dWfOK1pt5v2MY4HDk+oyMmBP5
         TUsaNSUmRSRUai6Q/fjo61dBOSS1erxVXoD5J/7LK+KN3HTQM8d74GteYBBe9oLAF1
         3TRo7f7ZZTZMKXtoHKhN8D1sjWGzh/qBy8UCc7s9EMXW8gxwHDTHscWUr55x7x71m4
         x+QGJnhZ6PhJQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
...
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 8e7403f081f44a..547002f56a163d 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
...
> @@ -125,7 +130,7 @@ static void hmm_free(struct kref *kref)
>  		mm->hmm = NULL;
>  	spin_unlock(&mm->page_table_lock);
>  
> -	kfree(hmm);
> +	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);


It occurred to me to wonder if it is best to use the MMU notifier's
instance of srcu, instead of creating a separate instance for HMM.
But this really does seem appropriate, since we are after all using
this to synchronize with MMU notifier callbacks. So, fine.


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

Well, sometimes, yes. :)

Maybe this wording is clearer (if we need any comment at all):

	/* Bail out if hmm is in the process of being freed */

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

Same here.

> +	if (!kref_get_unless_zero(&hmm->kref))
> +		return 0;
>  
>  	update.start = nrange->start;
>  	update.end = nrange->end;
> @@ -245,9 +256,11 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>  static void hmm_invalidate_range_end(struct mmu_notifier *mn,
>  			const struct mmu_notifier_range *nrange)
>  {
> -	struct hmm *hmm = mm_get_hmm(nrange->mm);
> +	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>  
> -	VM_BUG_ON(!hmm);
> +	/* hmm is in progress to free */

And here.

> +	if (!kref_get_unless_zero(&hmm->kref))
> +		return;
>  
>  	mutex_lock(&hmm->lock);
>  	hmm->notifiers--;
> 

Elegant fix. Regardless of the above chatter I added, you can add:

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
