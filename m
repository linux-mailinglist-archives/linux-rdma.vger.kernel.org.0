Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCABF9A71
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 21:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfKLUWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 15:22:50 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43867 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLUWt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 15:22:49 -0500
Received: by mail-qv1-f66.google.com with SMTP id cg2so6947561qvb.10
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 12:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vnS3z876J83ixoyjmv49DG9xbHQOY1MbChbRcHTvym4=;
        b=Dzk0IYPNoeuja6Z87jLZ16h5TFzbWhhaL2hE6e59eRJAr2o3x1k/qz1haRHmaKm2Oo
         pJdjmv04a60AokPpqfbEs8fcyiISwOqa6zHSTlPcqeOyWCS8kySDbonYwBGZimXEsiCr
         m+99Yx7WlBmR7rBCtzYugbBaq8RGC03XIHbn2PpO3V8jyiqo5Hk0w/HBZzsp2aMrUtNM
         6LE16wMsLdbDUqIZRBITP0567Jo4IONU9HkH5/mvp6Sr+ybWOj9b1NnCn2oFxTupAE27
         smAd6xHPhgykqaEmfbT/1zs/1tv2/o4ldY0ZS0sj1TBlKGbqpB11Kml+kU8JiiV0ASzB
         Lu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vnS3z876J83ixoyjmv49DG9xbHQOY1MbChbRcHTvym4=;
        b=GIiIzfzn/wx+NwBxY7p9Ndj32CscfDRGmXCYzY0t6FxxcJECtPqf76RuojfcpbhTG8
         RBb2xezq9SIdSFJAVaUawSo78aym/Mz7TXEfaTpbK/+f6lXZMDB2Ih1+ORRovmPXRAae
         b3Vj1iIgVH8ZqLX9b+LegIYi+AZjJRaNQ+eKJTp6WWDjym5bA1unfJDlcaaV6aMsMXix
         ckQ161IyOP11KqsvGz6YfksFCOzo2pzoneORu13EHD31N1Kl/CXE3ykBsPOuckI0p37M
         7/QILIui9eBhs0uGxrpiAKEbvv6WIg25jcXwMYs3BdyLq9fPXEpRU714pLGcx/Ztex6Q
         lxMQ==
X-Gm-Message-State: APjAAAXN0UhZmiVa+5qsuwyHN5jRT8HCiE+gDrVV6yH+LCEs/yt4deVM
        wVi2iJH7v3WqyNpOM9z50kK6QA==
X-Google-Smtp-Source: APXvYqwt6TPTyhRT+Pf1utgCUQUY7yQF048IJVBt4Y/k4d6RD16npyce/49GYasfkdRZSZLp6DS/WQ==
X-Received: by 2002:a05:6214:14ac:: with SMTP id bo12mr30993106qvb.67.1573590168353;
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z17sm8848536qtq.69.2019.11.12.12.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcgZ-0003ja-5T; Tue, 12 Nov 2019 16:22:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v3 01/14] mm/mmu_notifier: define the header pre-processor parts even if disabled
Date:   Tue, 12 Nov 2019 16:22:18 -0400
Message-Id: <20191112202231.3856-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112202231.3856-1-jgg@ziepe.ca>
References: <20191112202231.3856-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Now that we have KERNEL_HEADER_TEST all headers are generally compile
tested, so relying on makefile tricks to avoid compiling code that depends
on CONFIG_MMU_NOTIFIER is more annoying.

Instead follow the usual pattern and provide most of the header with only
the functions stubbed out when CONFIG_MMU_NOTIFIER is disabled. This
ensures code compiles no matter what the config setting is.

While here, struct mmu_notifier_mm is private to mmu_notifier.c, move it.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/mmu_notifier.h | 46 +++++++++++++-----------------------
 mm/mmu_notifier.c            | 13 ++++++++++
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 1bd8e6a09a3c27..12bd603d318ce7 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -7,8 +7,9 @@
 #include <linux/mm_types.h>
 #include <linux/srcu.h>
 
+struct mmu_notifier_mm;
 struct mmu_notifier;
-struct mmu_notifier_ops;
+struct mmu_notifier_range;
 
 /**
  * enum mmu_notifier_event - reason for the mmu notifier callback
@@ -40,36 +41,8 @@ enum mmu_notifier_event {
 	MMU_NOTIFY_SOFT_DIRTY,
 };
 
-#ifdef CONFIG_MMU_NOTIFIER
-
-#ifdef CONFIG_LOCKDEP
-extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
-#endif
-
-/*
- * The mmu notifier_mm structure is allocated and installed in
- * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
- * critical section and it's released only when mm_count reaches zero
- * in mmdrop().
- */
-struct mmu_notifier_mm {
-	/* all mmu notifiers registerd in this mm are queued in this list */
-	struct hlist_head list;
-	/* to serialize the list modifications and hlist_unhashed */
-	spinlock_t lock;
-};
-
 #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
 
-struct mmu_notifier_range {
-	struct vm_area_struct *vma;
-	struct mm_struct *mm;
-	unsigned long start;
-	unsigned long end;
-	unsigned flags;
-	enum mmu_notifier_event event;
-};
-
 struct mmu_notifier_ops {
 	/*
 	 * Called either by mmu_notifier_unregister or when the mm is
@@ -249,6 +222,21 @@ struct mmu_notifier {
 	unsigned int users;
 };
 
+#ifdef CONFIG_MMU_NOTIFIER
+
+#ifdef CONFIG_LOCKDEP
+extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
+#endif
+
+struct mmu_notifier_range {
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+	unsigned flags;
+	enum mmu_notifier_event event;
+};
+
 static inline int mm_has_notifiers(struct mm_struct *mm)
 {
 	return unlikely(mm->mmu_notifier_mm);
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 7fde88695f35d6..367670cfd02b7b 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -27,6 +27,19 @@ struct lockdep_map __mmu_notifier_invalidate_range_start_map = {
 };
 #endif
 
+/*
+ * The mmu notifier_mm structure is allocated and installed in
+ * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
+ * critical section and it's released only when mm_count reaches zero
+ * in mmdrop().
+ */
+struct mmu_notifier_mm {
+	/* all mmu notifiers registered in this mm are queued in this list */
+	struct hlist_head list;
+	/* to serialize the list modifications and hlist_unhashed */
+	spinlock_t lock;
+};
+
 /*
  * This function can't run concurrently against mmu_notifier_register
  * because mm->mm_users > 0 during mmu_notifier_register and exit_mmap
-- 
2.24.0

