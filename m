Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7EE79B5
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 21:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfJ1UKq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 16:10:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41206 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfJ1UKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 16:10:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id o3so16513330qtj.8
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1vmkJOGIS2JMKSg4aauB9VEgyiPOw7K+GpcfRESIoI=;
        b=LU+bbOjd0cz1dQjUVAwpTjm6I0OdzLxMOxP5OoMyKCWRmK92PNmFNIQUKjbHoE0awh
         pvseSw0PInn+OF/81alAmqaBN3yHzoSoswny6AKzKgyRT2YkUzVM+paRmtol46aPrKhB
         QMMBDPPQTSaHLetLANbdYa3ssCHD20beSUMzU9gm9hiKbchM7fSukllx4483KCxtEhyN
         0Mm9M8XrqlM/44ykUJTpSDhYdIpysgD+jWTg7Bkp6a2q7tAw/WZ08cKn9lLaF//6ovXU
         MNbPAJvpBLVztUrMAbJtNDCSkUdk4JNS5LcIXoJukchmgRsl1Gm23FzQw1GvQQ1wT1Cn
         HISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1vmkJOGIS2JMKSg4aauB9VEgyiPOw7K+GpcfRESIoI=;
        b=krOTH6wfv1iGZJpMamdrraxEBsBsbTNiZU5Sz4bqyIzNXitNntfkb++XXHlapp4XCp
         YeAl5BVdQNQtYKb5Cxz2BroC9Pc/j3Bqy4ErR1ZLdNLGz6JQGxRpAjAmrvnl2EeelANF
         iPuA/IN/njyCPYsceen6Zlw5AluZyvdKuX8b8BnF1agi5BeIzcV8ERYLVS5HxmGyDp5i
         zFY6IvRbPRKn4PXmUVJyvbJ170AwxqZVqKpZ4KY6XMgrWmCBrVtv78007nUofU0TbOuO
         h7KiINQBHNE0KW+FsbCqCRZKLQnFtKOfRQcZhvpsVhaP7ODNRO+RjlMbphnsFpaA10eY
         Dm9A==
X-Gm-Message-State: APjAAAUOuKZO9vYgWInDb/lY5+ml+u0HRAJxDTvYCkoXhrwoXszPUXIF
        97RCmoFH8jgMYl2uzkem8vtg4g==
X-Google-Smtp-Source: APXvYqxTDtu71nCg9F2jZDXMIik3Sf1CZYtmdCLMzyep9mn/F9AraC2jZajJbEZtCjPA2P8VltCn3g==
X-Received: by 2002:ad4:480e:: with SMTP id g14mr18897959qvy.39.1572293444691;
        Mon, 28 Oct 2019 13:10:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id m63sm6163383qkc.72.2019.10.28.13.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 13:10:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPBLf-0001g4-2o; Mon, 28 Oct 2019 17:10:43 -0300
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
Subject: [PATCH v2 01/15] mm/mmu_notifier: define the header pre-processor parts even if disabled
Date:   Mon, 28 Oct 2019 17:10:18 -0300
Message-Id: <20191028201032.6352-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
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
2.23.0

