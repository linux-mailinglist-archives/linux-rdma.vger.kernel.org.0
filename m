Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75799D7E9E
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfJOSQX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41740 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so9966389plr.8
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMW6u8sAEpasPVClwfBBYlElWNrrf0/DwLqwZuYcSQY=;
        b=M2J/KnGOO/ynYpeFySRiBudsUiTvI2FrRfaB+aH7OnKlnUucmp2R4RQ3z95+mIc56C
         +g20pMBoKXyb31P9hQPfxdcXUYUvJHGoSxWwdPz8PdPEImr03JRyocWO5fTlrvE6O5ys
         ro8e9KyWA4yi36wrt+mpCwP6ZvL3AhynqBci5ewDZ/MRFeTdMgqY3ltqTfHL1st2ARtx
         hIxfwbvsZGs6rxOwg2BlTfWXb/3h9ed3xReb75tByFaMPai/ZH2dj9CAdDpRfbgUhcFQ
         eWSBu6EU3iiU3V7B68KEKG3nfNBpW9NI3yjcV1rsJhRwjcjZU7sLp7YJ1SVCc9CD5bJI
         o3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMW6u8sAEpasPVClwfBBYlElWNrrf0/DwLqwZuYcSQY=;
        b=pql5q2uXLG74uhKNUL2mivF2M6NDG1DwoFm9lpAP7RXjG5Xqn9MrVc/Eh+5DNqs7Y8
         EZi8zN5LNyZa+gi5hu4uLLI/LnJsjOu9mVJkfGwZVhfll6lMMIL77jj4ZMVxPn3cUe9P
         StX9tS5VeY6EfrBdq0wVaoWLulqu+EE1/sjU/FU2uq5ypSddcS+gW8uNZ6Ed9qd5JQJu
         P0iygW6froKvlk2G9fI84/VobyjFwdTLTjUjLLaK4B9zV8IVmjPkNwGIBisQ2jKwxLg4
         GIK7WWX2jlAhT7XMVOvrguaF+i+NLuyU33Vr/kLIPNWZtJLTh5WHeZxqS1gp8eFiIM1t
         c+XQ==
X-Gm-Message-State: APjAAAU5vfXdv9G6/N+9BTyVAkfCvzSfxd/lHY6P9QO4tEb7HUXnoRkn
        5XZnPZdR8J15br5Z22b/vr9K6A==
X-Google-Smtp-Source: APXvYqyhe/t6Rp9RdcodgUXqjHqLoBMW/iEiC3lVKeBbOWy+tiRj0M2CZprzUCvqWIdC9clgqoP/Uw==
X-Received: by 2002:a17:902:8689:: with SMTP id g9mr36459912plo.131.1571163382804;
        Tue, 15 Oct 2019 11:16:22 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id 206sm21017956pge.80.2019.10.15.11.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:22 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002Bm-7p; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH hmm 01/15] mm/mmu_notifier: define the header pre-processor parts even if disabled
Date:   Tue, 15 Oct 2019 15:12:28 -0300
Message-Id: <20191015181242.8343-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
MIME-Version: 1.0
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

