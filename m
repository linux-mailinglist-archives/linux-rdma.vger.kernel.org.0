Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46DAE79B8
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 21:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfJ1UKr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 16:10:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44577 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfJ1UKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 16:10:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id z22so16490581qtq.11
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfZfiXb3zJ195gWPi/l/D27toKL96PSF+DrXZsTvCKc=;
        b=Vc58TGVq1lmjMY4eOa7KbtL6DEqVXlgPnJsOzrFIA+Kq+VIv+n8OiCivi4cUtamTnT
         1KYSo7v2A3a+ickTwHSH38kA5tGy8OuuNpGMwWxeSjiIUwF3+ru9o9EbSpkLUVe4ONKL
         vwoevPFvTqW4AXdpTwIwYVfG1lCs2EgIFUFFard0RfJWd72B2i5FrekyEo9dDa85D8eS
         IgS1EDvxvQkqOsgxFumEvEuegOpwLnX2TxR9uWKcEKPRRgLoUO9yKB4vsfjdqKaXA3Zr
         0ht0Y4lwbn51FabpNrQPAmMzXA34J6VR9wDC/ZusGDpxulAVuNULgD/MF+Wf668IbxSy
         16vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfZfiXb3zJ195gWPi/l/D27toKL96PSF+DrXZsTvCKc=;
        b=QRrU/iFGoOYj/B9R+vc1yp+pXdgLMTi498RGN6pJW859xCP+uiZFOJ48XuET8LUINR
         TCEX6vGmD4t2CRMURHIlrfOmVdhHoOqG2e9+E138ExKTxAB1HAl2YJJpqgG2N4mnykuH
         4GsHP4qRMVbTtH8JeQPgMjyR8YrZ7NR+VUMuDILfotPDAxeM90YM5/Il/ZrBI2PHA5J4
         F+WS/m6HbsH+PNBRMVSM5HusWrQehOxeHj71gQKVxdGPWws8Uc1kGT1ITngAKG1ICJWO
         bb2/JUfUr17mrxxCKdlfWMoliWudOGUogTE/Y+wvKb1ynI+/d25hknvOs3klpU5FElm9
         uh8Q==
X-Gm-Message-State: APjAAAXlSxGsS1JtkvdISiyuGkEEwigth7Q0dI77e0003oDOHtEfbay8
        iZjpIxkEidQrGui51AX38oVudg==
X-Google-Smtp-Source: APXvYqyzwQd88COzKjNYUtUi77xt5inAXAbC04JrmAuM/rVN/+ea+Lu0JHPIt/2aFSc9iA4BmT0l3w==
X-Received: by 2002:ac8:3f67:: with SMTP id w36mr271020qtk.99.1572293446378;
        Mon, 28 Oct 2019 13:10:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id r7sm6375208qkf.124.2019.10.28.13.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 13:10:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPBLf-0001gM-77; Mon, 28 Oct 2019 17:10:43 -0300
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
Subject: [PATCH v2 04/15] mm/hmm: define the pre-processor related parts of hmm.h even if disabled
Date:   Mon, 28 Oct 2019 17:10:21 -0300
Message-Id: <20191028201032.6352-5-jgg@ziepe.ca>
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

Only the function calls are stubbed out with static inlines that always
fail. This is the standard way to write a header for an optional component
and makes it easier for drivers that only optionally need HMM_MIRROR.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h | 59 ++++++++++++++++++++++++++++++++++++---------
 kernel/fork.c       |  1 -
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 8ac1fd6a81af8f..2666eb08a40615 100644
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
index f9572f41612628..4561a65d19db88 100644
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
2.23.0

