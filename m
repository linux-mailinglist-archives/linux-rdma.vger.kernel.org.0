Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2AC2709E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 22:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfEVUMt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 16:12:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45163 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfEVUMt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 16:12:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id t1so3985917qtc.12
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Cnh1zv+MpTD//W/ZciU7p3rLJeN3HTGu169lbfCN2g=;
        b=YE0IpP8H/ucijkv4/zVjJ988m9xdFimUhpaxBkJCS59qhW+IMnbR5pbeV+sCn5JTOS
         gnpOAP2B7c7aSbThavZLfsAIQj0lK8/J6U5K81Q9AEGVlG1oL3YLff6Xl2EKWr9XjEkA
         geDiqGupSN0dwV7h2nmanpeorMbMVIzI3K66c6I1FbvRklAixBgNAHFgUgLIYhWM7+87
         SqNE9J6Q2mU7C2V1w8oSbOzkukq9H2Wzl4FjIBKmYR1zkdE4CtQVQu2NgFSgxYgzoLx7
         EninpQWhc6XcEFj3CacFG5qrFVCVGo4ER7wIDqD+nMQ8C1GEk+QD3ezARs843/aXHBk3
         jb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Cnh1zv+MpTD//W/ZciU7p3rLJeN3HTGu169lbfCN2g=;
        b=m3NzNb1v+JttmcsItesGtwvshK8c7RYBlvx5i+hmTb6xebWIVd1RUBvPR3x28hFsKK
         U0xQWSg8MJ3qdAFZ98dswv0vo5JXLHztsHT0kL7obdGmNHinH9ln5GtQDBqHWi7Cm1sn
         uM97t5RHzhEv/x89Y4mxy0Y26XsTaiGzXC+dd3uxwkg3LZAVCCb4DvlEU/JeMua/A/qD
         OUEkFoqqQGi0KdjRf7HHpEST9x4yijBJjq8YDWhdwcqxkdSnr3vk/IvNCsTFidc0aRsk
         huxvaUHgK8K/1hEYy43DlsEh51d9fuBx1p3FWogVxm16g8glZOZmHHqUD7870MnjRs+t
         LNWQ==
X-Gm-Message-State: APjAAAUHGgP929GLcl9+AJFXn4j2c4gs0XYwVH9QcLbJmYkXvZBVMLWz
        cgOkWFapQrxoRUbACgSYvdMyCw==
X-Google-Smtp-Source: APXvYqwkv+L37w9ixCVNgbTzJP9c7J84nOh7MnCV4O6X3TGfqnjt15mUAu7vDi6h84TgA4gSyjkUXA==
X-Received: by 2002:a0c:b04f:: with SMTP id l15mr59907485qvc.191.1558555968376;
        Wed, 22 May 2019 13:12:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id g65sm1475777qkb.1.2019.05.22.13.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 13:12:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTXbT-0003PL-Eq; Wed, 22 May 2019 17:12:47 -0300
Date:   Wed, 22 May 2019 17:12:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522201247.GH6054@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522174852.GA23038@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:

>  static void put_per_mm(struct ib_umem_odp *umem_odp)
>  {
>  	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
> @@ -325,9 +283,10 @@ static void put_per_mm(struct ib_umem_odp *umem_odp)
>  	up_write(&per_mm->umem_rwsem);
>  
>  	WARN_ON(!RB_EMPTY_ROOT(&per_mm->umem_tree.rb_root));
> -	mmu_notifier_unregister_no_release(&per_mm->mn, per_mm->mm);
> +	hmm_mirror_unregister(&per_mm->mirror);
>  	put_pid(per_mm->tgid);
> -	mmu_notifier_call_srcu(&per_mm->rcu, free_per_mm);
> +
> +	kfree(per_mm);

Notice that mmu_notifier only uses SRCU to fence in-progress ops
callbacks, so I think hmm internally has the bug that this ODP
approach prevents.

hmm should follow the same pattern ODP has and 'kfree_srcu' the hmm
struct, use container_of in the mmu_notifier callbacks, and use the
otherwise vestigal kref_get_unless_zero() to bail:

From 0cb536dc0150ba964a1d655151d7b7a84d0f915a Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Wed, 22 May 2019 16:52:52 -0300
Subject: [PATCH] hmm: Fix use after free with struct hmm in the mmu notifiers

mmu_notifier_unregister_no_release() is not a fence and the mmu_notifier
system will continue to reference hmm->mn until the srcu grace period
expires.

         CPU0                                     CPU1
                                               __mmu_notifier_invalidate_range_start()
                                                 srcu_read_lock
                                                 hlist_for_each ()
                                                   // mn == hmm->mn
hmm_mirror_unregister()
  hmm_put()
    hmm_free()
      mmu_notifier_unregister_no_release()
         hlist_del_init_rcu(hmm-mn->list)
			                           mn->ops->invalidate_range_start(mn, range);
					             mm_get_hmm()
      mm->hmm = NULL;
      kfree(hmm)
                                                     mutex_lock(&hmm->lock);

Use SRCU to kfree the hmm memory so that the notifiers can rely on hmm
existing. Get the now-safe hmm struct through container_of and directly
check kref_get_unless_zero to lock it against free.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h |  1 +
 mm/hmm.c            | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 51ec27a8466816..8b91c90d3b88cb 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -102,6 +102,7 @@ struct hmm {
 	struct mmu_notifier	mmu_notifier;
 	struct rw_semaphore	mirrors_sem;
 	wait_queue_head_t	wq;
+	struct rcu_head		rcu;
 	long			notifiers;
 	bool			dead;
 };
diff --git a/mm/hmm.c b/mm/hmm.c
index 816c2356f2449f..824e7e160d8167 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -113,6 +113,11 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
 	return NULL;
 }
 
+static void hmm_fee_rcu(struct rcu_head *rcu)
+{
+	kfree(container_of(rcu, struct hmm, rcu));
+}
+
 static void hmm_free(struct kref *kref)
 {
 	struct hmm *hmm = container_of(kref, struct hmm, kref);
@@ -125,7 +130,7 @@ static void hmm_free(struct kref *kref)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 
-	kfree(hmm);
+	mmu_notifier_call_srcu(&hmm->rcu, hmm_fee_rcu);
 }
 
 static inline void hmm_put(struct hmm *hmm)
@@ -153,10 +158,14 @@ void hmm_mm_destroy(struct mm_struct *mm)
 
 static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct hmm *hmm = mm_get_hmm(mm);
+	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
 	struct hmm_range *range;
 
+	/* hmm is in progress to free */
+	if (!kref_get_unless_zero(&hmm->kref))
+		return;
+
 	/* Report this HMM as dying. */
 	hmm->dead = true;
 
@@ -194,13 +203,15 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
-	struct hmm *hmm = mm_get_hmm(nrange->mm);
+	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 	struct hmm_mirror *mirror;
 	struct hmm_update update;
 	struct hmm_range *range;
 	int ret = 0;
 
-	VM_BUG_ON(!hmm);
+	/* hmm is in progress to free */
+	if (!kref_get_unless_zero(&hmm->kref))
+		return 0;
 
 	update.start = nrange->start;
 	update.end = nrange->end;
@@ -248,9 +259,11 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 			const struct mmu_notifier_range *nrange)
 {
-	struct hmm *hmm = mm_get_hmm(nrange->mm);
+	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
 
-	VM_BUG_ON(!hmm);
+	/* hmm is in progress to free */
+	if (!kref_get_unless_zero(&hmm->kref))
+		return;
 
 	mutex_lock(&hmm->lock);
 	hmm->notifiers--;
-- 
2.21.0

