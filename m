Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36AADD7E99
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfJOSQP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40676 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:15 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so48121883iof.7
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcVBi9ccgY4WcIiK7htGW9JC/41ZVBDU/dZyJbvS0oI=;
        b=gOR7v+Magpr20tPpBhw3su5vwBWD1crfNwZ0Z9VwQerZXk4VmKtv7ZGa/jZLOy3+Gb
         K/Q7dJA5LKZQavy+GhBoux2L8kxb3css4d9zN/qzJ6D9qjLAybfSGz5wAW9Oa8BkSVtJ
         te/l388bPwiD/m6Mv210cwaQmHe4ZhGHpALba4ndH4+4j9LOZ5xQuVmuzT9Du8DYtThP
         FU5+UPGU4MiMeGISYSD3jjKBdkSmM33uzAoSWwQ4tizM9raO+SKggS9Hv63dzChlpFDC
         P9lGy5CTBdU2CwXQdDQ23RO44PDQ6aNgRYtT68MI+iv+KJ0S/ruk9IdofQwJd83rujzd
         zcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcVBi9ccgY4WcIiK7htGW9JC/41ZVBDU/dZyJbvS0oI=;
        b=bWloV91RmVz/Wdh3MkRkimlxYAkuLhrKzQJLmVOrvEtmDxDdgwEqRfFt4P19poVgR4
         syjLjWsfPra3s5u5+8v5nYPToYJ9zpHzIfx+ZbQegVwSNjKL5YSLLXtISfvlgMb6l+N1
         CS14RpPf/ZmZeKyxwA2VZuSLulaQlAW5o7L38xh/sEsmYRl/IHPRgn7NWx3rJVcZqCng
         xSYcM4hPbhjYbbCoRTDHzRrtISqrlmCYJdgqRu0KswDEco3X7nDijDdr90aqg7i6AAH7
         152W6Kfc9+jFAsyMDy1XLlTDBwIQxUGdpdpGXqa3iORK2Rs9XpOKF7iU64YWTU/r4q/8
         BNow==
X-Gm-Message-State: APjAAAVixVeOGALBV8izhjfmZ+m6AnSvwJgRfk6njVHqIt0fu8CCdtDT
        ZR/fys7XwKe+yKc4/demJBOioA==
X-Google-Smtp-Source: APXvYqyx9iOETMkWQM2sfKJTNRp/60e+N/aCImQtCZIAbTEsdBubG9IKWgw/xkcAPqe/1cFrooZISw==
X-Received: by 2002:a5d:9e02:: with SMTP id h2mr26817595ioh.137.1571163374432;
        Tue, 15 Oct 2019 11:16:14 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id m11sm14366395ioq.5.2019.10.15.11.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:13 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002C1-CW; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH hmm 04/15] mm/hmm: define the pre-processor related parts of hmm.h even if disabled
Date:   Tue, 15 Oct 2019 15:12:31 -0300
Message-Id: <20191015181242.8343-5-jgg@ziepe.ca>
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

Only the function calls are stubbed out with static inlines that always
fail. This is the standard way to write a header for an optional component
and makes it easier for drivers that only optionally need HMM_MIRROR.

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

