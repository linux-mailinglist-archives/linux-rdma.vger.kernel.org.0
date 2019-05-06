Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A550614B47
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfEFNyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:54:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:48135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfEFNyC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 09:54:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 06:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="344291811"
Received: from ssaleem-mobl4.amr.corp.intel.com ([10.255.35.243])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2019 06:54:00 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH v3 rdma-next 1/6] RDMA/umem: Add API to find best driver supported page size in an MR
Date:   Mon,  6 May 2019 08:53:32 -0500
Message-Id: <20190506135337.11324-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20190506135337.11324-1-shiraz.saleem@intel.com>
References: <20190506135337.11324-1-shiraz.saleem@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This helper iterates through the SG list to find the best page size to use
from a bitmap of HW supported page sizes. Drivers that support multiple
page sizes, but not mixed sizes in an MR can use this API.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Gal Pressman <galpress@amazon.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/umem.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/rdma/ib_umem.h         |  9 ++++++++
 include/rdma/ib_verbs.h        | 24 ++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 7e912a9..2534ddd 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -127,6 +127,57 @@ static struct scatterlist *ib_umem_add_sg_table(struct scatterlist *sg,
 }
 
 /**
+ * ib_umem_find_best_pgsz - Find best HW page size to use for this MR
+ *
+ * @umem: umem struct
+ * @pgsz_bitmap: bitmap of HW supported page sizes
+ * @virt: IOVA
+ *
+ * This helper is intended for HW that support multiple page
+ * sizes but can do only a single page size in an MR.
+ *
+ * Returns 0 if the umem requires page sizes not supported by
+ * the driver to be mapped. Drivers always supporting PAGE_SIZE
+ * or smaller will never see a 0 result.
+ */
+unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
+				     unsigned long pgsz_bitmap,
+				     unsigned long virt)
+{
+	struct scatterlist *sg;
+	unsigned int best_pg_bit;
+	unsigned long va, pgoff;
+	dma_addr_t mask;
+	int i;
+
+	/* At minimum, drivers must support PAGE_SIZE or smaller */
+	if (WARN_ON(!(pgsz_bitmap & GENMASK(PAGE_SHIFT, 0))))
+		return 0;
+
+	va = virt;
+	/* max page size not to exceed MR length */
+	mask = roundup_pow_of_two(umem->length);
+	/* offset into first SGL */
+	pgoff = umem->address & ~PAGE_MASK;
+
+	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i) {
+		/* Walk SGL and reduce max page size if VA/PA bits differ
+		 * for any address.
+		 */
+		mask |= (sg_dma_address(sg) + pgoff) ^ va;
+		if (i && i != (umem->nmap - 1))
+			/* restrict by length as well for interior SGEs */
+			mask |= sg_dma_len(sg);
+		va += sg_dma_len(sg) - pgoff;
+		pgoff = 0;
+	}
+	best_pg_bit = rdma_find_pg_bit(mask, pgsz_bitmap);
+
+	return BIT_ULL(best_pg_bit);
+}
+EXPORT_SYMBOL(ib_umem_find_best_pgsz);
+
+/**
  * ib_umem_get - Pin and DMA map userspace memory.
  *
  * If access flags indicate ODP memory, avoid pinning. Instead, stores
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index b13a2e9..917b687 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -87,6 +87,9 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 int ib_umem_page_count(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
+unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
+				     unsigned long pgsz_bitmap,
+				     unsigned long virt);
 
 #else /* CONFIG_INFINIBAND_USER_MEM */
 
@@ -104,6 +107,12 @@ static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offs
 		      		    size_t length) {
 	return -EINVAL;
 }
+static inline int ib_umem_find_best_pgsz(struct ib_umem *umem,
+					 unsigned long pgsz_bitmap,
+					 unsigned long virt) {
+	return -EINVAL;
+}
+
 #endif /* CONFIG_INFINIBAND_USER_MEM */
 
 #endif /* IB_UMEM_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index de8724e..5391c24 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3235,6 +3235,30 @@ static inline bool rdma_cap_read_inv(struct ib_device *dev, u32 port_num)
 	return rdma_protocol_iwarp(dev, port_num);
 }
 
+/**
+ * rdma_find_pg_bit - Find page bit given address and HW supported page sizes
+ *
+ * @addr: address
+ * @pgsz_bitmap: bitmap of HW supported page sizes
+ */
+static inline unsigned int rdma_find_pg_bit(unsigned long addr,
+					    unsigned long pgsz_bitmap)
+{
+	unsigned long align;
+	unsigned long pgsz;
+
+	align = addr & -addr;
+
+	/* Find page bit such that addr is aligned to the highest supported
+	 * HW page size
+	 */
+	pgsz = pgsz_bitmap & ~(-align << 1);
+	if (!pgsz)
+		return __ffs(pgsz_bitmap);
+
+	return __fls(pgsz);
+}
+
 int ib_set_vf_link_state(struct ib_device *device, int vf, u8 port,
 			 int state);
 int ib_get_vf_config(struct ib_device *device, int vf, u8 port,
-- 
1.8.3.1

