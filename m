Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2487B1ACE2F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgDPQ5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 12:57:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:59302 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733127AbgDPQ5g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 12:57:36 -0400
IronPort-SDR: Hzt6CrRNOFmQleLUVltTsmxl9+dUYL+KBxvdlJ3ACvLX9rC0OkTv6l2hIabMFXPVZIUDfKP9cp
 Qkw2AaK2kVJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:57:35 -0700
IronPort-SDR: wTR1jH/36CCdDzTZQ/ZuPLRf6eDDSLoZy9F88gDyo2kiRxpvmd4gF3ozpN0ICyNpWlAopEfqzV
 xplp4d0R+aHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="364053022"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 09:57:37 -0700
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user memory region
Date:   Thu, 16 Apr 2020 10:09:31 -0700
Message-Id: <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dma-buf, a standard cross-driver buffer sharing mechanism, is chosen to
be the basis of a non-proprietary approach for supporting RDMA to/from
buffers allocated from device local memory (e.g. GPU VRAM).

Dma-buf is supported by mainstream GPU drivers. By using ioctl calls
via the devices under /dev/dri/, user space applications can allocate
and export GPU buffers as dma-buf objects with associated file
descriptors.

In order to use the exported GPU buffers for RDMA operations, the RDMA
driver needs to be able to import dma-buf objects. This happens at the
time of memory registration. A GPU buffer is registered as a special
type of user space memory region with the dma-buf file descriptor as
an extra parameter. The uverbs API needs to be extended to allow the
extra parameter be passed from user space to kernel.

Implements the common code for pinning and mapping dma-buf pages and
adds config option for RDMA driver dma-buf support. The common code
is utilized by the new uverbs commands introduced by follow-up patches.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/infiniband/Kconfig            |  10 ++++
 drivers/infiniband/core/Makefile      |   1 +
 drivers/infiniband/core/umem.c        |   3 +
 drivers/infiniband/core/umem_dmabuf.c | 100 ++++++++++++++++++++++++++++++++++
 include/rdma/ib_umem.h                |   2 +
 include/rdma/ib_umem_dmabuf.h         |  50 +++++++++++++++++
 6 files changed, 166 insertions(+)
 create mode 100644 drivers/infiniband/core/umem_dmabuf.c
 create mode 100644 include/rdma/ib_umem_dmabuf.h

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index ade8638..1dcfc59 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -63,6 +63,16 @@ config INFINIBAND_ON_DEMAND_PAGING
 	  memory regions without pinning their pages, fetching the
 	  pages on demand instead.
 
+config INFINIBAND_DMABUF
+	bool "InfiniBand dma-buf support"
+	depends on INFINIBAND_USER_MEM
+	default n
+	help
+	  Support for dma-buf based user memory.
+	  This allows userspace processes register memory regions
+	  backed by device memory exported as dma-buf, and thus
+	  enables RDMA operations using device memory.
+
 config INFINIBAND_ADDR_TRANS
 	bool "RDMA/CM"
 	depends on INFINIBAND
diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index d1b14887..7981d0f 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -39,3 +39,4 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_async_fd.o
 ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o
 ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
+ib_uverbs-$(CONFIG_INFINIBAND_DMABUF) += umem_dmabuf.o
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 82455a1..54b35df 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <rdma/ib_umem_odp.h>
+#include <rdma/ib_umem_dmabuf.h>
 
 #include "uverbs.h"
 
@@ -317,6 +318,8 @@ void ib_umem_release(struct ib_umem *umem)
 {
 	if (!umem)
 		return;
+	if (umem->is_dmabuf)
+		return ib_umem_dmabuf_release(to_ib_umem_dmabuf(umem));
 	if (umem->is_odp)
 		return ib_umem_odp_release(to_ib_umem_odp(umem));
 
diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
new file mode 100644
index 0000000..325d44f
--- /dev/null
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright (c) 2020 Intel Corporation. All rights reserved.
+ */
+
+#include <linux/mm.h>
+#include <linux/sched/mm.h>
+#include <linux/dma-mapping.h>
+#include <rdma/ib_umem_dmabuf.h>
+
+#include "uverbs.h"
+
+struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
+				   unsigned long addr, size_t size,
+				   int dmabuf_fd, int access)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+	struct sg_table *sgt;
+	enum dma_data_direction dir;
+	long ret;
+
+	if (((addr + size) < addr) ||
+	    PAGE_ALIGN(addr + size) < (addr + size))
+		return ERR_PTR(-EINVAL);
+
+	if (!can_do_mlock())
+		return ERR_PTR(-EPERM);
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
+	umem_dmabuf->umem.owning_mm = current->mm;
+	mmgrab(umem_dmabuf->umem.owning_mm);
+
+	umem_dmabuf->fd = dmabuf_fd;
+	umem_dmabuf->dmabuf = dma_buf_get(umem_dmabuf->fd);
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
+	mmdrop(umem_dmabuf->umem.owning_mm);
+	kfree(umem_dmabuf);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_get);
+
+void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	enum dma_data_direction dir;
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
+	mmdrop(umem_dmabuf->umem.owning_mm);
+	kfree(umem_dmabuf);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_release);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index e3518fd..026a3cf 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -40,6 +40,7 @@
 
 struct ib_ucontext;
 struct ib_umem_odp;
+struct ib_umem_dmabuf;
 
 struct ib_umem {
 	struct ib_device       *ibdev;
@@ -48,6 +49,7 @@ struct ib_umem {
 	unsigned long		address;
 	u32 writable : 1;
 	u32 is_odp : 1;
+	u32 is_dmabuf : 1;
 	struct work_struct	work;
 	struct sg_table sg_head;
 	int             nmap;
diff --git a/include/rdma/ib_umem_dmabuf.h b/include/rdma/ib_umem_dmabuf.h
new file mode 100644
index 0000000..e82b205
--- /dev/null
+++ b/include/rdma/ib_umem_dmabuf.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2020 Intel Corporation. All rights reserved.
+ */
+
+#ifndef IB_UMEM_DMABUF_H
+#define IB_UMEM_DMABUF_H
+
+#include <linux/dma-buf.h>
+#include <rdma/ib_umem.h>
+#include <rdma/ib_verbs.h>
+
+struct ib_umem_dmabuf {
+	struct ib_umem	umem;
+	int		fd;
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
+#ifdef CONFIG_INFINIBAND_DMABUF
+
+struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
+				   unsigned long addr, size_t size,
+				   int dmabuf_fd, int access);
+
+void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
+
+#else /* CONFIG_INFINIBAND_DMABUF */
+
+static inline struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
+						 unsigned long addr,
+						 size_t size, int dmabuf_fd,
+						 int access)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
+{
+}
+
+#endif /* CONFIG_INFINIBAND_DMABUF */
+
+#endif /* IB_UMEM_DMABUF_H */
-- 
1.8.3.1

