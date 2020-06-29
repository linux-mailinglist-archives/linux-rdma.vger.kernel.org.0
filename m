Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA020DD79
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgF2S5l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 14:57:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:57281 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbgF2S5e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:34 -0400
IronPort-SDR: RSkgSFiOC35YaC2bSGBw6mIGlHhmu2ekTYfLq/NP0185Ov/oc3SLxa9nya+Eyc8gbWyrWpZTPb
 kZj3ISNXZGEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="230844128"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="230844128"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 10:19:56 -0700
IronPort-SDR: 54PT3ZBf7U6fycc0nNYb2H7icgZDYyzkP32TpGbG4Esfy5x2WwKNTkm2nSfBPVMarOyMIf9PG7
 WZSkdup8B71g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="320698658"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2020 10:19:56 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC PATCH v2 1/3] RDMA/umem: Support importing dma-buf as user memory region
Date:   Mon, 29 Jun 2020 10:31:41 -0700
Message-Id: <1593451903-30959-2-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dma-buf is a standard cross-driver buffer sharing mechanism that can be
used to support peer-to-peer access from RDMA devices.

Device memory exported via dma-buf can be associated with a file
descriptor. This is passed to the user space as a property associated
with the buffer allocation. When the buffer is registered as a memory
region, the file descriptor is passed to the RDMA driver along with
other parameters.

Implement the common code for importing dma-buf object, and pinning and
mapping dma-buf pages.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/infiniband/core/Makefile      |   2 +-
 drivers/infiniband/core/umem.c        |   4 ++
 drivers/infiniband/core/umem_dmabuf.c | 105 ++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/umem_dmabuf.h |  11 ++++
 include/rdma/ib_umem.h                |  14 ++++-
 5 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/core/umem_dmabuf.c
 create mode 100644 drivers/infiniband/core/umem_dmabuf.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index d1b14887..0d4efa0 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -37,5 +37,5 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_mr.o uverbs_std_types_counters.o \
 				uverbs_uapi.o uverbs_std_types_device.o \
 				uverbs_std_types_async_fd.o
-ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o
+ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o umem_dmabuf.o
 ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 82455a1..bf1a6c1 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2005 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005 Cisco Systems.  All rights reserved.
  * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2020 Intel Corporation. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -42,6 +43,7 @@
 #include <rdma/ib_umem_odp.h>
 
 #include "uverbs.h"
+#include "umem_dmabuf.h"
 
 static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
 {
@@ -317,6 +319,8 @@ void ib_umem_release(struct ib_umem *umem)
 {
 	if (!umem)
 		return;
+	if (umem->is_dmabuf)
+		return ib_umem_dmabuf_release(umem);
 	if (umem->is_odp)
 		return ib_umem_odp_release(to_ib_umem_odp(umem));
 
diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
new file mode 100644
index 0000000..406ca64
--- /dev/null
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright (c) 2020 Intel Corporation. All rights reserved.
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/dma-mapping.h>
+
+#include "uverbs.h"
+
+struct ib_umem_dmabuf {
+	struct ib_umem	umem;
+	struct dma_buf	*dmabuf;
+	struct dma_buf_attachment *attach;
+	struct sg_table *sgt;
+};
+
+static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem *umem)
+{
+	return container_of(umem, struct ib_umem_dmabuf, umem);
+}
+
+struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
+				   unsigned long addr, size_t size,
+				   int dmabuf_fd, int access)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+	struct sg_table *sgt;
+	enum dma_data_direction dir;
+	long ret;
+	unsigned long end;
+
+	if (check_add_overflow(addr, size, &end))
+		return ERR_PTR(-EINVAL);
+
+	if (unlikely(PAGE_ALIGN(end) < PAGE_SIZE))
+		return ERR_PTR(-EINVAL);
+
+	if (access & IB_ACCESS_ON_DEMAND)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	umem_dmabuf = kzalloc(sizeof(*umem_dmabuf), GFP_KERNEL);
+	if (!umem_dmabuf)
+		return ERR_PTR(-ENOMEM);
+
+	umem_dmabuf->umem.ibdev = device;
+	umem_dmabuf->umem.length = size;
+	umem_dmabuf->umem.address = addr;
+	umem_dmabuf->umem.writable = ib_access_writable(access);
+	umem_dmabuf->umem.is_dmabuf = 1;
+
+	umem_dmabuf->dmabuf = dma_buf_get(dmabuf_fd);
+	if (IS_ERR(umem_dmabuf->dmabuf)) {
+		ret = PTR_ERR(umem_dmabuf->dmabuf);
+		goto out_free_umem;
+	}
+
+	umem_dmabuf->attach = dma_buf_attach(umem_dmabuf->dmabuf,
+					     device->dma_device);
+	if (IS_ERR(umem_dmabuf->attach)) {
+		ret = PTR_ERR(umem_dmabuf->attach);
+		goto out_release_dmabuf;
+	}
+
+	dir = umem_dmabuf->umem.writable ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
+	sgt = dma_buf_map_attachment(umem_dmabuf->attach, dir);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		goto out_detach_dmabuf;
+	}
+
+	umem_dmabuf->sgt = sgt;
+	umem_dmabuf->umem.sg_head = *sgt;
+	umem_dmabuf->umem.nmap = sgt->nents;
+	return &umem_dmabuf->umem;
+
+out_detach_dmabuf:
+	dma_buf_detach(umem_dmabuf->dmabuf, umem_dmabuf->attach);
+
+out_release_dmabuf:
+	dma_buf_put(umem_dmabuf->dmabuf);
+
+out_free_umem:
+	kfree(umem_dmabuf);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_get);
+
+void ib_umem_dmabuf_release(struct ib_umem *umem)
+{
+	enum dma_data_direction dir;
+	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(umem);
+
+	dir = umem_dmabuf->umem.writable ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
+
+	/*
+	 * Only use the original sgt returned from dma_buf_map_attachment(),
+	 * otherwise the scatterlist may be freed twice due to the map caching
+	 * mechanism.
+	 */
+	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt, dir);
+	dma_buf_detach(umem_dmabuf->dmabuf, umem_dmabuf->attach);
+	dma_buf_put(umem_dmabuf->dmabuf);
+	kfree(umem_dmabuf);
+}
diff --git a/drivers/infiniband/core/umem_dmabuf.h b/drivers/infiniband/core/umem_dmabuf.h
new file mode 100644
index 0000000..485f653
--- /dev/null
+++ b/drivers/infiniband/core/umem_dmabuf.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2020 Intel Corporation. All rights reserved.
+ */
+
+#ifndef UMEM_DMABUF_H
+#define UMEM_DMABUF_H
+
+void ib_umem_dmabuf_release(struct ib_umem *umem);
+
+#endif /* UMEM_DMABUF_H */
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index e3518fd..78331ce 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2007 Cisco Systems.  All rights reserved.
+ * Copyright (c) 2020 Intel Corporation.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -40,6 +41,7 @@
 
 struct ib_ucontext;
 struct ib_umem_odp;
+struct ib_umem_dmabuf;
 
 struct ib_umem {
 	struct ib_device       *ibdev;
@@ -48,6 +50,7 @@ struct ib_umem {
 	unsigned long		address;
 	u32 writable : 1;
 	u32 is_odp : 1;
+	u32 is_dmabuf : 1;
 	struct work_struct	work;
 	struct sg_table sg_head;
 	int             nmap;
@@ -78,6 +81,9 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 				     unsigned long pgsz_bitmap,
 				     unsigned long virt);
+struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
+				   unsigned long addr, size_t size,
+				   int dmabuf_fd, int access);
 
 #else /* CONFIG_INFINIBAND_USER_MEM */
 
@@ -100,7 +106,13 @@ static inline int ib_umem_find_best_pgsz(struct ib_umem *umem,
 					 unsigned long virt) {
 	return -EINVAL;
 }
+static inline struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
+						 unsigned long addr,
+						 size_t size, int dmabuf_fd,
+						 int access)
+{
+	return ERR_PTR(-EINVAL);
+}
 
 #endif /* CONFIG_INFINIBAND_USER_MEM */
-
 #endif /* IB_UMEM_H */
-- 
1.8.3.1

