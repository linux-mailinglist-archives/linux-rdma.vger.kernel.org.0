Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310398E64B
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfHOI2d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:28:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46184 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHOI2c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Aug 2019 04:28:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so1476351wru.13;
        Thu, 15 Aug 2019 01:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2n57inVfSie2OKAeFsC4Tdlnlo7oR3PchxqlwbFyHws=;
        b=boxOmV2AXJMNv7ExG5zcaNwxY8gLHePrB+8HL/cmSKDM3jIErtI774h9HjnDRzm8Tx
         Wq9PWfYT0Sh5Po0fBclwEP4xbBfvwCFnk9C/SG/rshZcYo9N1euWPNu2UGL7EWCo3+MP
         O2rnBrRJ7qLQnlMsBq3iYl5Gx16rioJyY8NHWzFHk6PJR3Mao4BkmwMKCPfIMe58HB2/
         YomndBe6Ptr1r/DdLANhMMeLvEc+gN/2G78qBq1yiqedrcEA+VyitQg3m/MavBlIoO5/
         kdqkjsndmpbzsFCRWVN8vW/8XkaogWEHGqhOo5gXtwC44YcIRAqSJ/YLJRfC4UpsUc3l
         MU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=2n57inVfSie2OKAeFsC4Tdlnlo7oR3PchxqlwbFyHws=;
        b=LrCUuDJkXKtFwak2YuzHyKsmkRnk2Rjp/hoADcSiWt8Hrv/l4ERLXkwtSOu25QX5xS
         vPZufOXxmqwBGzNQu8XTh25bcfPlQv67pOTZA3RIgjF5ELMVOWNtxgclejkc7evVAa3J
         gGqzOhQl1/6Y7jPLVbcIaSFE0SDlwQGcKKdbWKZhW8Zu/C/CoLKVNuLRGQp6oRiJoP9C
         ystcNsPZmvWeQfVSOXKNrXS4iieqf7YJ0JYOU/e5Cd4osIA+oqRm1PgG6i5OFAmzDYaZ
         F4KlmJaytNvWP9PZnQIoj99GejNPGyVtmSw2gWUnc0MkG3cl6Gl5ZBouj9zd3id5ibJ7
         dFZQ==
X-Gm-Message-State: APjAAAX6t8tZDktfwV7+j/c1rkWz8Bhz2CPBERhRY6h41aGQWMC8+kxp
        J7a0RbBgE03xHkShPIcyAFA=
X-Google-Smtp-Source: APXvYqwfqKb8EbCeeUml+x+2Tj1Kf6iL08f84CLc1WiMnwcV+bykZNDjSVZQ4BJrVYueAZkugq/uJg==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr1965676wrx.50.1565857709125;
        Thu, 15 Aug 2019 01:28:29 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id w5sm711796wmm.43.2019.08.15.01.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 01:28:28 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH v3 hmm 08/11] drm/radeon: use mmu_notifier_get/put for
 struct radeon_mn
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        iommu@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        intel-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
References: <20190806231548.25242-1-jgg@ziepe.ca>
 <20190806231548.25242-9-jgg@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2baff2e5-b923-c39b-98e5-b3e7f77bd6d3@gmail.com>
Date:   Thu, 15 Aug 2019 10:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806231548.25242-9-jgg@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 07.08.19 um 01:15 schrieb Jason Gunthorpe:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> radeon is using a device global hash table to track what mmu_notifiers
> have been registered on struct mm. This is better served with the new
> get/put scheme instead.
>
> radeon has a bug where it was not blocking notifier release() until all
> the BO's had been invalidated. This could result in a use after free of
> pages the BOs. This is tied into a second bug where radeon left the
> notifiers running endlessly even once the interval tree became
> empty. This could result in a use after free with module unload.
>
> Both are fixed by changing the lifetime model, the BOs exist in the
> interval tree with their natural lifetimes independent of the mm_struct
> lifetime using the get/put scheme. The release runs synchronously and just
> does invalidate_start across the entire interval tree to create the
> required DMA fence.
>
> Additions to the interval tree after release are already impossible as
> only current->mm is used during the add.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Acked-by: Christian König <christian.koenig@amd.com>

But I'm wondering if we shouldn't completely drop radeon userptr support.

It's just to buggy,
Christian.

> ---
>   drivers/gpu/drm/radeon/radeon.h        |   3 -
>   drivers/gpu/drm/radeon/radeon_device.c |   2 -
>   drivers/gpu/drm/radeon/radeon_drv.c    |   2 +
>   drivers/gpu/drm/radeon/radeon_mn.c     | 157 ++++++-------------------
>   4 files changed, 38 insertions(+), 126 deletions(-)
>
> AMD team: I wonder if kfd has similar lifetime issues?
>
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
> index 32808e50be12f8..918164f90b114a 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -2451,9 +2451,6 @@ struct radeon_device {
>   	/* tracking pinned memory */
>   	u64 vram_pin_size;
>   	u64 gart_pin_size;
> -
> -	struct mutex	mn_lock;
> -	DECLARE_HASHTABLE(mn_hash, 7);
>   };
>   
>   bool radeon_is_px(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index dceb554e567446..788b1d8a80e660 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1325,8 +1325,6 @@ int radeon_device_init(struct radeon_device *rdev,
>   	init_rwsem(&rdev->pm.mclk_lock);
>   	init_rwsem(&rdev->exclusive_lock);
>   	init_waitqueue_head(&rdev->irq.vblank_queue);
> -	mutex_init(&rdev->mn_lock);
> -	hash_init(rdev->mn_hash);
>   	r = radeon_gem_init(rdev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index a6cbe11f79c611..b6535ac91fdb74 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -35,6 +35,7 @@
>   #include <linux/module.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/vga_switcheroo.h>
> +#include <linux/mmu_notifier.h>
>   
>   #include <drm/drm_crtc_helper.h>
>   #include <drm/drm_drv.h>
> @@ -624,6 +625,7 @@ static void __exit radeon_exit(void)
>   {
>   	pci_unregister_driver(pdriver);
>   	radeon_unregister_atpx_handler();
> +	mmu_notifier_synchronize();
>   }
>   
>   module_init(radeon_init);
> diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
> index 8c3871ed23a9f0..fc8254273a800b 100644
> --- a/drivers/gpu/drm/radeon/radeon_mn.c
> +++ b/drivers/gpu/drm/radeon/radeon_mn.c
> @@ -37,17 +37,8 @@
>   #include "radeon.h"
>   
>   struct radeon_mn {
> -	/* constant after initialisation */
> -	struct radeon_device	*rdev;
> -	struct mm_struct	*mm;
>   	struct mmu_notifier	mn;
>   
> -	/* only used on destruction */
> -	struct work_struct	work;
> -
> -	/* protected by rdev->mn_lock */
> -	struct hlist_node	node;
> -
>   	/* objects protected by lock */
>   	struct mutex		lock;
>   	struct rb_root_cached	objects;
> @@ -58,55 +49,6 @@ struct radeon_mn_node {
>   	struct list_head		bos;
>   };
>   
> -/**
> - * radeon_mn_destroy - destroy the rmn
> - *
> - * @work: previously sheduled work item
> - *
> - * Lazy destroys the notifier from a work item
> - */
> -static void radeon_mn_destroy(struct work_struct *work)
> -{
> -	struct radeon_mn *rmn = container_of(work, struct radeon_mn, work);
> -	struct radeon_device *rdev = rmn->rdev;
> -	struct radeon_mn_node *node, *next_node;
> -	struct radeon_bo *bo, *next_bo;
> -
> -	mutex_lock(&rdev->mn_lock);
> -	mutex_lock(&rmn->lock);
> -	hash_del(&rmn->node);
> -	rbtree_postorder_for_each_entry_safe(node, next_node,
> -					     &rmn->objects.rb_root, it.rb) {
> -
> -		interval_tree_remove(&node->it, &rmn->objects);
> -		list_for_each_entry_safe(bo, next_bo, &node->bos, mn_list) {
> -			bo->mn = NULL;
> -			list_del_init(&bo->mn_list);
> -		}
> -		kfree(node);
> -	}
> -	mutex_unlock(&rmn->lock);
> -	mutex_unlock(&rdev->mn_lock);
> -	mmu_notifier_unregister(&rmn->mn, rmn->mm);
> -	kfree(rmn);
> -}
> -
> -/**
> - * radeon_mn_release - callback to notify about mm destruction
> - *
> - * @mn: our notifier
> - * @mn: the mm this callback is about
> - *
> - * Shedule a work item to lazy destroy our notifier.
> - */
> -static void radeon_mn_release(struct mmu_notifier *mn,
> -			      struct mm_struct *mm)
> -{
> -	struct radeon_mn *rmn = container_of(mn, struct radeon_mn, mn);
> -	INIT_WORK(&rmn->work, radeon_mn_destroy);
> -	schedule_work(&rmn->work);
> -}
> -
>   /**
>    * radeon_mn_invalidate_range_start - callback to notify about mm change
>    *
> @@ -183,65 +125,44 @@ static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
>   	return ret;
>   }
>   
> -static const struct mmu_notifier_ops radeon_mn_ops = {
> -	.release = radeon_mn_release,
> -	.invalidate_range_start = radeon_mn_invalidate_range_start,
> -};
> +static void radeon_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
> +{
> +	struct mmu_notifier_range range = {
> +		.mm = mm,
> +		.start = 0,
> +		.end = ULONG_MAX,
> +		.flags = 0,
> +		.event = MMU_NOTIFY_UNMAP,
> +	};
> +
> +	radeon_mn_invalidate_range_start(mn, &range);
> +}
>   
> -/**
> - * radeon_mn_get - create notifier context
> - *
> - * @rdev: radeon device pointer
> - *
> - * Creates a notifier context for current->mm.
> - */
> -static struct radeon_mn *radeon_mn_get(struct radeon_device *rdev)
> +static struct mmu_notifier *radeon_mn_alloc_notifier(struct mm_struct *mm)
>   {
> -	struct mm_struct *mm = current->mm;
>   	struct radeon_mn *rmn;
> -	int r;
> -
> -	if (down_write_killable(&mm->mmap_sem))
> -		return ERR_PTR(-EINTR);
> -
> -	mutex_lock(&rdev->mn_lock);
> -
> -	hash_for_each_possible(rdev->mn_hash, rmn, node, (unsigned long)mm)
> -		if (rmn->mm == mm)
> -			goto release_locks;
>   
>   	rmn = kzalloc(sizeof(*rmn), GFP_KERNEL);
> -	if (!rmn) {
> -		rmn = ERR_PTR(-ENOMEM);
> -		goto release_locks;
> -	}
> +	if (!rmn)
> +		return ERR_PTR(-ENOMEM);
>   
> -	rmn->rdev = rdev;
> -	rmn->mm = mm;
> -	rmn->mn.ops = &radeon_mn_ops;
>   	mutex_init(&rmn->lock);
>   	rmn->objects = RB_ROOT_CACHED;
> -	
> -	r = __mmu_notifier_register(&rmn->mn, mm);
> -	if (r)
> -		goto free_rmn;
> -
> -	hash_add(rdev->mn_hash, &rmn->node, (unsigned long)mm);
> -
> -release_locks:
> -	mutex_unlock(&rdev->mn_lock);
> -	up_write(&mm->mmap_sem);
> -
> -	return rmn;
> -
> -free_rmn:
> -	mutex_unlock(&rdev->mn_lock);
> -	up_write(&mm->mmap_sem);
> -	kfree(rmn);
> +	return &rmn->mn;
> +}
>   
> -	return ERR_PTR(r);
> +static void radeon_mn_free_notifier(struct mmu_notifier *mn)
> +{
> +	kfree(container_of(mn, struct radeon_mn, mn));
>   }
>   
> +static const struct mmu_notifier_ops radeon_mn_ops = {
> +	.release = radeon_mn_release,
> +	.invalidate_range_start = radeon_mn_invalidate_range_start,
> +	.alloc_notifier = radeon_mn_alloc_notifier,
> +	.free_notifier = radeon_mn_free_notifier,
> +};
> +
>   /**
>    * radeon_mn_register - register a BO for notifier updates
>    *
> @@ -254,15 +175,16 @@ static struct radeon_mn *radeon_mn_get(struct radeon_device *rdev)
>   int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
>   {
>   	unsigned long end = addr + radeon_bo_size(bo) - 1;
> -	struct radeon_device *rdev = bo->rdev;
> +	struct mmu_notifier *mn;
>   	struct radeon_mn *rmn;
>   	struct radeon_mn_node *node = NULL;
>   	struct list_head bos;
>   	struct interval_tree_node *it;
>   
> -	rmn = radeon_mn_get(rdev);
> -	if (IS_ERR(rmn))
> -		return PTR_ERR(rmn);
> +	mn = mmu_notifier_get(&radeon_mn_ops, current->mm);
> +	if (IS_ERR(mn))
> +		return PTR_ERR(mn);
> +	rmn = container_of(mn, struct radeon_mn, mn);
>   
>   	INIT_LIST_HEAD(&bos);
>   
> @@ -309,22 +231,13 @@ int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
>    */
>   void radeon_mn_unregister(struct radeon_bo *bo)
>   {
> -	struct radeon_device *rdev = bo->rdev;
> -	struct radeon_mn *rmn;
> +	struct radeon_mn *rmn = bo->mn;
>   	struct list_head *head;
>   
> -	mutex_lock(&rdev->mn_lock);
> -	rmn = bo->mn;
> -	if (rmn == NULL) {
> -		mutex_unlock(&rdev->mn_lock);
> -		return;
> -	}
> -
>   	mutex_lock(&rmn->lock);
>   	/* save the next list entry for later */
>   	head = bo->mn_list.next;
>   
> -	bo->mn = NULL;
>   	list_del(&bo->mn_list);
>   
>   	if (list_empty(head)) {
> @@ -335,5 +248,7 @@ void radeon_mn_unregister(struct radeon_bo *bo)
>   	}
>   
>   	mutex_unlock(&rmn->lock);
> -	mutex_unlock(&rdev->mn_lock);
> +
> +	mmu_notifier_put(&rmn->mn);
> +	bo->mn = NULL;
>   }

