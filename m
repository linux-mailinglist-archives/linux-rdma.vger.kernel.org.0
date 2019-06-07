Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF907397DF
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfFGVhK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 17:37:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1666 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfFGVhK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 17:37:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfad8f60000>; Fri, 07 Jun 2019 14:36:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 14:37:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 14:37:09 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 21:37:08 +0000
Subject: Re: [PATCH v2 hmm 11/11] mm/hmm: Remove confusing comment and logic
 from hmm_release
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-12-jgg@ziepe.ca>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <61ea869d-43d2-d1e5-dc00-cf5e3e139169@nvidia.com>
Date:   Fri, 7 Jun 2019 14:37:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606184438.31646-12-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559943414; bh=y2l4fZUHEu5jTe1akMwM/C9NdR8qPwwFFoigSM6h8EI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RnlfJ4dm9rb0aajSZnsU9ebXq5RZwM9NQ6DFLnQY6ATII69dnW/Te8wQjfhe7r9vF
         tEkAQi10ucVG/0ko1HSqhs2P2B2UN6ppGw5i2TEsNNH3cIYD0rIEUXdM2sBPUVPbYA
         viPeu5qYlbn1t0Ao/MsRAtiG1Rpgnv4uI3LKaiiL8X19btt0dk/ntEdPf48yJPPlMJ
         5flOt6tYZ+Er1DurblUkrJ564/gbDV6H4BNQmjwQjhJKOMOJdHjzH4kT/FSo2Ri6zb
         h6Mg6XPkLg6wxI6GhqJUslefH70kHL/cWMQinfvEya8exHGBjsX7pZlMogsYdPzHat
         nooGWxUI1zOEg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> hmm_release() is called exactly once per hmm. ops->release() cannot
> accidentally trigger any action that would recurse back onto
> hmm->mirrors_sem.
> 
> This fixes a use after-free race of the form:
> 
>         CPU0                                   CPU1
>                                             hmm_release()
>                                               up_write(&hmm->mirrors_sem);
>   hmm_mirror_unregister(mirror)
>    down_write(&hmm->mirrors_sem);
>    up_write(&hmm->mirrors_sem);
>    kfree(mirror)
>                                               mirror->ops->release(mirror)
> 
> The only user we have today for ops->release is an empty function, so this
> is unambiguously safe.
> 
> As a consequence of plugging this race drivers are not allowed to
> register/unregister mirrors from within a release op.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

I agree with the analysis above but I'm not sure that release() will
always be an empty function. It might be more efficient to write back
all data migrated to a device "in one pass" instead of relying
on unmap_vmas() calling hmm_start_range_invalidate() per VMA.

I think the bigger issue is potential deadlocks while calling
sync_cpu_device_pagetables() and tasks calling hmm_mirror_unregister():

Say you have three threads:
- Thread A is in try_to_unmap(), either without holding mmap_sem or with
mmap_sem held for read.
- Thread B has some unrelated driver calling hmm_mirror_unregister().
This doesn't require mmap_sem.
- Thread C is about to call migrate_vma().

Thread A                Thread B                 Thread C
try_to_unmap            hmm_mirror_unregister    migrate_vma
----------------------  -----------------------  ----------------------
hmm_invalidate_range_start
down_read(mirrors_sem)
                         down_write(mirrors_sem)
                         // Blocked on A
                                                   device_lock
device_lock
// Blocked on C
                                                   migrate_vma()
                                                   hmm_invalidate_range_s
                                                   down_read(mirrors_sem)
                                                   // Blocked on B
                                                   // Deadlock

Perhaps we should consider using SRCU for walking the mirror->list?

> ---
>   mm/hmm.c | 28 +++++++++-------------------
>   1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 709d138dd49027..3a45dd3d778248 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -136,26 +136,16 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	WARN_ON(!list_empty(&hmm->ranges));
>   	mutex_unlock(&hmm->lock);
>   
> -	down_write(&hmm->mirrors_sem);
> -	mirror = list_first_entry_or_null(&hmm->mirrors, struct hmm_mirror,
> -					  list);
> -	while (mirror) {
> -		list_del_init(&mirror->list);
> -		if (mirror->ops->release) {
> -			/*
> -			 * Drop mirrors_sem so the release callback can wait
> -			 * on any pending work that might itself trigger a
> -			 * mmu_notifier callback and thus would deadlock with
> -			 * us.
> -			 */
> -			up_write(&hmm->mirrors_sem);
> +	down_read(&hmm->mirrors_sem);
> +	list_for_each_entry(mirror, &hmm->mirrors, list) {
> +		/*
> +		 * Note: The driver is not allowed to trigger
> +		 * hmm_mirror_unregister() from this thread.
> +		 */
> +		if (mirror->ops->release)
>   			mirror->ops->release(mirror);
> -			down_write(&hmm->mirrors_sem);
> -		}
> -		mirror = list_first_entry_or_null(&hmm->mirrors,
> -						  struct hmm_mirror, list);
>   	}
> -	up_write(&hmm->mirrors_sem);
> +	up_read(&hmm->mirrors_sem);
>   
>   	hmm_put(hmm);
>   }
> @@ -287,7 +277,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)
>   	struct hmm *hmm = mirror->hmm;
>   
>   	down_write(&hmm->mirrors_sem);
> -	list_del_init(&mirror->list);
> +	list_del(&mirror->list);
>   	up_write(&hmm->mirrors_sem);
>   	hmm_put(hmm);
>   	memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
> 
