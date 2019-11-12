Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F00F9A7C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 21:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKLUW4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 15:22:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38676 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLUW4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 15:22:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id e2so15694964qkn.5
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msUbALhd2xtO/lF1E2JMgXZu+n1aQVj3OW/hKQoForA=;
        b=Ud3HNeMvcBpWwpT3gZXaL68W5jc4GRJ5drmnCYR67cEqOCjBlZs5P2wDSQe6CODuSB
         J1EAZioZQ9rcwECNjBjxhvN/h7A8p86VQI+/cscWfNwd3d0hIbRq/S2rxZ3SgPq3SQsh
         IC5AA3IVMduEINV7agpnd2NheQMqXocW+A0dljsNBHcTFpF8kfqMqZZ9OeN7jjwlh7Vu
         +RMljsG8VsNCOP//jt8ErHFHC5yQyz4YCmqouEU/yr/aAtN1riu5Te8FNu87M6hJsHPz
         F2H3fOv/F0OG7KYT7tZbF/C2LTE0BLosUZkpzCl4MCjvJ2aFpMdhYX7vyVQP+AuIs2dr
         1tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msUbALhd2xtO/lF1E2JMgXZu+n1aQVj3OW/hKQoForA=;
        b=dPHGQ6/H7ywxHp6WoxqIq6D76D5PeRQwPXrIYWYPLRACjpSPlnylucKrrIjROj4E/0
         3kiTnshK1dj7fgwRcw5K/24R2NuJgD9Db2t3sZ/TLoGE/63TA3IdBQ0tSn7FB0FmnWXq
         9SyoW7psbXsC5KTEfdjogrew9mFDvF+zwyNrv0STnHrfquCjkzzQM9+HwzSm1pW9Toue
         1vfB2E9RZZUOpP6VhsBL/kBEQtleURO08pX3IwtYpjt9U205Fp5batSOUzcS5ZaPMrQg
         DC8+wr6/QVeccG+RDct8kpAtsCcFUaMBdVptBR2e36nBZGYk6ufIE8fT4VQqcZjqJIbR
         uH3A==
X-Gm-Message-State: APjAAAUE6AXq047VZs9HbguObq59dE/r95ZcDDCbD8BaM8UQg2J5RCic
        +8Dck9duVePErKeT4krmiJChjQ==
X-Google-Smtp-Source: APXvYqwTjQHMd6Wnulr6l6RAuSHWZi+1OAZIts410/rBP3+s9ZvtJbjVwjBC9m86HVn1dWXuguyRLg==
X-Received: by 2002:a37:388:: with SMTP id 130mr17246331qkd.378.1573590173939;
        Tue, 12 Nov 2019 12:22:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j89sm10542127qte.72.2019.11.12.12.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcgZ-0003js-9n; Tue, 12 Nov 2019 16:22:47 -0400
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
Subject: [PATCH v3 04/14] mm/hmm: define the pre-processor related parts of hmm.h even if disabled
Date:   Tue, 12 Nov 2019 16:22:21 -0400
Message-Id: <20191112202231.3856-5-jgg@ziepe.ca>
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

Only the function calls are stubbed out with static inlines that always
fail. This is the standard way to write a header for an optional component
and makes it easier for drivers that only optionally need HMM_MIRROR.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h | 59 ++++++++++++++++++++++++++++++++++++---------
 kernel/fork.c       |  1 -
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index fbb35c78637e57..cb69bf10dc788c 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -62,8 +62,6 @@
 #include <linux/kconfig.h>
 #include <asm/pgtable.h>
 
-#ifdef CONFIG_HMM_MIRROR
-
 #include <linux/device.h>
 #include <linux/migrate.h>
 #include <linux/memremap.h>
@@ -374,6 +372,15 @@ struct hmm_mirror {
 	struct list_head		list;
 };
 
+/*
+ * Retry fault if non-blocking, drop mmap_sem and return -EAGAIN in that case.
+ */
+#define HMM_FAULT_ALLOW_RETRY		(1 << 0)
+
+/* Don't fault in missing PTEs, just snapshot the current state. */
+#define HMM_FAULT_SNAPSHOT		(1 << 1)
+
+#ifdef CONFIG_HMM_MIRROR
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
 void hmm_mirror_unregister(struct hmm_mirror *mirror);
 
@@ -383,14 +390,6 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
 int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirror);
 void hmm_range_unregister(struct hmm_range *range);
 
-/*
- * Retry fault if non-blocking, drop mmap_sem and return -EAGAIN in that case.
- */
-#define HMM_FAULT_ALLOW_RETRY		(1 << 0)
-
-/* Don't fault in missing PTEs, just snapshot the current state. */
-#define HMM_FAULT_SNAPSHOT		(1 << 1)
-
 long hmm_range_fault(struct hmm_range *range, unsigned int flags);
 
 long hmm_range_dma_map(struct hmm_range *range,
@@ -401,6 +400,44 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 			 struct device *device,
 			 dma_addr_t *daddrs,
 			 bool dirty);
+#else
+int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
+{
+	return -EOPNOTSUPP;
+}
+
+void hmm_mirror_unregister(struct hmm_mirror *mirror)
+{
+}
+
+int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirror)
+{
+	return -EOPNOTSUPP;
+}
+
+void hmm_range_unregister(struct hmm_range *range)
+{
+}
+
+static inline long hmm_range_fault(struct hmm_range *range, unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline long hmm_range_dma_map(struct hmm_range *range,
+				     struct device *device, dma_addr_t *daddrs,
+				     unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline long hmm_range_dma_unmap(struct hmm_range *range,
+				       struct device *device,
+				       dma_addr_t *daddrs, bool dirty)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 /*
  * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
@@ -411,6 +448,4 @@ long hmm_range_dma_unmap(struct hmm_range *range,
  */
 #define HMM_RANGE_DEFAULT_TIMEOUT 1000
 
-#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
-
 #endif /* LINUX_HMM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index bcdf5312521036..ca39cfc404e3db 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -40,7 +40,6 @@
 #include <linux/binfmts.h>
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
-#include <linux/hmm.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/vmacache.h>
-- 
2.24.0

