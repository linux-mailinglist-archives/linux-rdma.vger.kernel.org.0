Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644F683DBD
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 01:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfHFXQu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 19:16:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35968 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHFXQS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 19:16:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so86496521qtc.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pkHeCt/hoSJAt//UHPk0X0I7hZeOiqjMeNu5wqmOhVU=;
        b=EO1RyLd4d0AnXDRqElYRzxtyKz38WeGeNBRIkYdo+3VFgs/T0oIQs20Zy/5GKhTnqI
         UfyYPmrt29HX9vdxZVEwKEX/vOCaV33r4IcvjjLv+dvBVpY91WnTDcNJXzjaMgjBsFFt
         FdxAfV5Xk74BDXvs4obq2oP6Eu9zK7wtAWH8j4mJyF0Ged8Qf759ly97ojGQOxxLbF+m
         EBz8VKm2ELuy2OvTFchRCVHhBVH+J3NM3xKbJA1b+9RKe4syO0dO8Tpu7jcVbUS84W+G
         X1zRmwp67vSBaYZNs5bfg6X3fWLEdZzDSXoP+HJcr6VhTvigDkmOWFIoLfep3TCPpIME
         lbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pkHeCt/hoSJAt//UHPk0X0I7hZeOiqjMeNu5wqmOhVU=;
        b=mDnALaUN+wPmvSVuiHyBlxSpM/5lkF/Cu3edd9NGSNmpnnx6CXMntC86sAIUSCJdB4
         FDcf3xmAWqD/qe/DNfIzT8DNXWAjrUXmOaDzu+e0B0JWQlPUy6xtBFUOw5M+EC2zK9px
         zCj5VUrU8xoiLAJHmfE2ZU0qempT948VMvtko2dvhnAvgbAl0alUY8fljm7YTJBdIqMK
         OJnUkZ7bOLNMpwOA57LZlZK+i02+5ukD2sf5kv1RpuSmLkPRh2XYC10I+oLKnv1xIwew
         LUsN2vhHKJIMMNrQzJoIUsnOFrrGjd+USGPCeWHMVK2rhT8nSMyoLLcVs4vPowivXykt
         seNw==
X-Gm-Message-State: APjAAAWMxDE3EWmNrKd2gtXLMEvqEhCh8VEsGO0TXigouMTOh01lr6r3
        Rtc3yOQlET42A0V+w4lmogw95w==
X-Google-Smtp-Source: APXvYqy6Nsusk0wHFyYvRxTipEB7NphBo9CKaHBj+WOx7SnMsQAhKID5TREjs8PZo1+pA73I5XbxVg==
X-Received: by 2002:ac8:2b01:: with SMTP id 1mr5497725qtu.177.1565133377682;
        Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r14sm36816958qkm.100.2019.08.06.16.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv8gg-0006fG-Jc; Tue, 06 Aug 2019 20:16:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v3 hmm 11/11] mm/mmu_notifiers: remove unregister_no_release
Date:   Tue,  6 Aug 2019 20:15:48 -0300
Message-Id: <20190806231548.25242-12-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

mmu_notifier_unregister_no_release() and mmu_notifier_call_srcu() no
longer have any users, they have all been converted to use
mmu_notifier_put().

So delete this difficult to use interface.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/mmu_notifier.h |  5 -----
 mm/mmu_notifier.c            | 31 -------------------------------
 2 files changed, 36 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 31aa971315a142..52929e5ef70826 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -271,8 +271,6 @@ extern int __mmu_notifier_register(struct mmu_notifier *mn,
 				   struct mm_struct *mm);
 extern void mmu_notifier_unregister(struct mmu_notifier *mn,
 				    struct mm_struct *mm);
-extern void mmu_notifier_unregister_no_release(struct mmu_notifier *mn,
-					       struct mm_struct *mm);
 extern void __mmu_notifier_mm_destroy(struct mm_struct *mm);
 extern void __mmu_notifier_release(struct mm_struct *mm);
 extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
@@ -513,9 +511,6 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
 	set_pte_at(___mm, ___address, __ptep, ___pte);			\
 })
 
-extern void mmu_notifier_call_srcu(struct rcu_head *rcu,
-				   void (*func)(struct rcu_head *rcu));
-
 #else /* CONFIG_MMU_NOTIFIER */
 
 struct mmu_notifier_range {
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 4a770b5211b71d..2ec48f8ba9e288 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -21,18 +21,6 @@
 /* global SRCU for all MMs */
 DEFINE_STATIC_SRCU(srcu);
 
-/*
- * This function allows mmu_notifier::release callback to delay a call to
- * a function that will free appropriate resources. The function must be
- * quick and must not block.
- */
-void mmu_notifier_call_srcu(struct rcu_head *rcu,
-			    void (*func)(struct rcu_head *rcu))
-{
-	call_srcu(&srcu, rcu, func);
-}
-EXPORT_SYMBOL_GPL(mmu_notifier_call_srcu);
-
 /*
  * This function can't run concurrently against mmu_notifier_register
  * because mm->mm_users > 0 during mmu_notifier_register and exit_mmap
@@ -453,25 +441,6 @@ void mmu_notifier_unregister(struct mmu_notifier *mn, struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mmu_notifier_unregister);
 
-/*
- * Same as mmu_notifier_unregister but no callback and no srcu synchronization.
- */
-void mmu_notifier_unregister_no_release(struct mmu_notifier *mn,
-					struct mm_struct *mm)
-{
-	spin_lock(&mm->mmu_notifier_mm->lock);
-	/*
-	 * Can not use list_del_rcu() since __mmu_notifier_release
-	 * can delete it before we hold the lock.
-	 */
-	hlist_del_init_rcu(&mn->hlist);
-	spin_unlock(&mm->mmu_notifier_mm->lock);
-
-	BUG_ON(atomic_read(&mm->mm_count) <= 0);
-	mmdrop(mm);
-}
-EXPORT_SYMBOL_GPL(mmu_notifier_unregister_no_release);
-
 static void mmu_notifier_free_rcu(struct rcu_head *rcu)
 {
 	struct mmu_notifier *mn = container_of(rcu, struct mmu_notifier, rcu);
-- 
2.22.0

