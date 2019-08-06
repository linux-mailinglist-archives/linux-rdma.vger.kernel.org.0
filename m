Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A083DC3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 01:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfHFXRG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 19:17:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44675 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfHFXQQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 19:16:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so55381456qtg.11
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qo3M/m6bAMWNKeEf1KSsSvYS6KA/79bnXZ/MG9HQ7+c=;
        b=WIvITimiWkKwXR9MAnwvbjPd/jMGoFdgSbKJFYsFUTclr60pQsMdghZmIOiCh5YXC0
         UttFPobZS06cPlOZT0PF7D3HVksfWxSV4t/CAk8TXFyUTmugFgIF0+8oo8kipepx+JH2
         FaOArh02dXo+Kn1J1o19Ll/t6xFzUWU5L8C0euhgPJsWnHYPCsSB+yc+FHlEmVCAuX1U
         +F5OWyMlJ9C8l6nJvwq0WdkKMN98R7WVkx30edRvtFR93R5JGnJIrzkZgNRu9P36xdgz
         ULUtU6UxEUUqnG9agwf1nN+Htatwu+jA9bbrHaEueg4ngKDbsCMWsyahgp9VLjoDhgxe
         +acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qo3M/m6bAMWNKeEf1KSsSvYS6KA/79bnXZ/MG9HQ7+c=;
        b=KJv6fytRditkY9iNIyUqds1nZ2hqlUUgWLN/bFUfRxGAU3d4zZCsAjcL1jGPQm7Zqz
         tLvhBX6O1Xv3HQ7TW329/qJUsgidA/MKjcLv1LIeNU5DmdteSUwdDeloV2zrRcedNgLr
         2XwnqbE8njq2HPwVZ38r+zzHuh1IgkVTkIab7PcsilQjJPVPdp7pyqu0DmQ3boRbRJr1
         gGD/v/4jPKTczMCJ2NGs9zOSKqJ2f5Eh0jrqjLGKIUvYZaG6Bp4ODZsGHQLNx8EAltom
         WLI3mRb1cBGRsieOPeIHuJcCyDi82aLA2rQcS6uR/SUe/WMmjzQpt67ayeD3RgJlt5Lf
         UTJA==
X-Gm-Message-State: APjAAAWy+TNe0xualvr4cR4zRg2HFRdHrL83p0zRQnxal/IhUdiKCQQa
        oxtsVZUTGeCh60TvzwSIncRFsw==
X-Google-Smtp-Source: APXvYqwzSzqBhit7womFZned74qAW6JuvC+DaQssS9gJgppa+iNTQrGgfDRkcUg2AKLeoxFn+koswg==
X-Received: by 2002:a0c:ad6f:: with SMTP id v44mr5590212qvc.40.1565133375491;
        Tue, 06 Aug 2019 16:16:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l5sm38853627qte.9.2019.08.06.16.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 16:16:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv8gg-0006eL-1z; Tue, 06 Aug 2019 20:16:14 -0300
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
Subject: [PATCH v3 hmm 02/11] mm/mmu_notifiers: do not speculatively allocate a mmu_notifier_mm
Date:   Tue,  6 Aug 2019 20:15:39 -0300
Message-Id: <20190806231548.25242-3-jgg@ziepe.ca>
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

A prior commit e0f3c3f78da2 ("mm/mmu_notifier: init notifier if necessary")
made an attempt at doing this, but had to be reverted as calling
the GFP_KERNEL allocator under the i_mmap_mutex causes deadlock, see
commit 35cfa2b0b491 ("mm/mmu_notifier: allocate mmu_notifier in advance").

However, we can avoid that problem by doing the allocation only under
the mmap_sem, which is already happening.

Since all writers to mm->mmu_notifier_mm hold the write side of the
mmap_sem reading it under that sem is deterministic and we can use that to
decide if the allocation path is required, without speculation.

The actual update to mmu_notifier_mm must still be done under the
mm_take_all_locks() to ensure read-side coherency.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/mmu_notifier.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 218a6f108bc2d0..696810f632ade1 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -242,27 +242,32 @@ EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range);
  */
 int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct mmu_notifier_mm *mmu_notifier_mm;
+	struct mmu_notifier_mm *mmu_notifier_mm = NULL;
 	int ret;
 
 	lockdep_assert_held_write(&mm->mmap_sem);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
-	mmu_notifier_mm = kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
-	if (unlikely(!mmu_notifier_mm))
-		return -ENOMEM;
+	if (!mm->mmu_notifier_mm) {
+		/*
+		 * kmalloc cannot be called under mm_take_all_locks(), but we
+		 * know that mm->mmu_notifier_mm can't change while we hold
+		 * the write side of the mmap_sem.
+		 */
+		mmu_notifier_mm =
+			kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
+		if (!mmu_notifier_mm)
+			return -ENOMEM;
+
+		INIT_HLIST_HEAD(&mmu_notifier_mm->list);
+		spin_lock_init(&mmu_notifier_mm->lock);
+	}
 
 	ret = mm_take_all_locks(mm);
 	if (unlikely(ret))
 		goto out_clean;
 
-	if (!mm_has_notifiers(mm)) {
-		INIT_HLIST_HEAD(&mmu_notifier_mm->list);
-		spin_lock_init(&mmu_notifier_mm->lock);
-
-		mm->mmu_notifier_mm = mmu_notifier_mm;
-		mmu_notifier_mm = NULL;
-	}
+	/* Pairs with the mmdrop in mmu_notifier_unregister_* */
 	mmgrab(mm);
 
 	/*
@@ -273,14 +278,19 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * We can't race against any other mmu notifier method either
 	 * thanks to mm_take_all_locks().
 	 */
+	if (mmu_notifier_mm)
+		mm->mmu_notifier_mm = mmu_notifier_mm;
+
 	spin_lock(&mm->mmu_notifier_mm->lock);
 	hlist_add_head_rcu(&mn->hlist, &mm->mmu_notifier_mm->list);
 	spin_unlock(&mm->mmu_notifier_mm->lock);
 
 	mm_drop_all_locks(mm);
+	BUG_ON(atomic_read(&mm->mm_users) <= 0);
+	return 0;
+
 out_clean:
 	kfree(mmu_notifier_mm);
-	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__mmu_notifier_register);
-- 
2.22.0

