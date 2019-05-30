Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CFE2FC3C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfE3NZk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:25:40 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34898 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726169AbfE3NZk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:25:40 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 May 2019 16:25:32 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4UDPVZW007883;
        Thu, 30 May 2019 16:25:31 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 04/20] RDMA/core: Introduce ib_map_mr_sg_pi to map data/protection sgl's
Date:   Thu, 30 May 2019 16:25:15 +0300
Message-Id: <1559222731-16715-5-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This function will map the previously dma mapped SG lists for PI
(protection information) and data to an appropriate memory region for
future registration.
The given MR must be allocated as IB_MR_TYPE_INTEGRITY.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/core/device.c |  1 +
 drivers/infiniband/core/verbs.c  | 40 +++++++++++++++++++++++++++++++++++++++-
 include/rdma/ib_verbs.h          |  9 +++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 14a6d351ad1e..90c71542e76e 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2389,6 +2389,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, iw_reject);
 	SET_DEVICE_OP(dev_ops, iw_rem_ref);
 	SET_DEVICE_OP(dev_ops, map_mr_sg);
+	SET_DEVICE_OP(dev_ops, map_mr_sg_pi);
 	SET_DEVICE_OP(dev_ops, map_phys_fmr);
 	SET_DEVICE_OP(dev_ops, mmap);
 	SET_DEVICE_OP(dev_ops, modify_ah);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 80b9dc0dbd6a..96ddae029095 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2040,7 +2040,8 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 {
 	struct ib_mr *mr;
 
-	if (!pd->device->ops.alloc_mr_integrity)
+	if (!pd->device->ops.alloc_mr_integrity ||
+	    !pd->device->ops.map_mr_sg_pi)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	if (!max_num_meta_sg)
@@ -2423,6 +2424,43 @@ int ib_set_vf_guid(struct ib_device *device, int vf, u8 port, u64 guid,
 }
 EXPORT_SYMBOL(ib_set_vf_guid);
 
+/**
+ * ib_map_mr_sg_pi() - Map the dma mapped SG lists for PI (protection
+ *     information) and set an appropriate memory region for registration.
+ * @mr:             memory region
+ * @data_sg:        dma mapped scatterlist for data
+ * @data_sg_nents:  number of entries in data_sg
+ * @data_sg_offset: offset in bytes into data_sg
+ * @meta_sg:        dma mapped scatterlist for metadata
+ * @meta_sg_nents:  number of entries in meta_sg
+ * @meta_sg_offset: offset in bytes into meta_sg
+ * @page_size:      page vector desired page size
+ *
+ * Constraints:
+ * - The MR must be allocated with type IB_MR_TYPE_INTEGRITY.
+ *
+ * Returns the number of sg elements that were mapped to the memory region.
+ *
+ * After this completes successfully, the  memory region
+ * is ready for registration.
+ */
+int ib_map_mr_sg_pi(struct ib_mr *mr, struct scatterlist *data_sg,
+		    int data_sg_nents, unsigned int *data_sg_offset,
+		    struct scatterlist *meta_sg, int meta_sg_nents,
+		    unsigned int *meta_sg_offset, unsigned int page_size)
+{
+	if (unlikely(!mr->device->ops.map_mr_sg_pi ||
+		     WARN_ON_ONCE(mr->type != IB_MR_TYPE_INTEGRITY)))
+		return -EOPNOTSUPP;
+
+	mr->page_size = page_size;
+
+	return mr->device->ops.map_mr_sg_pi(mr, data_sg, data_sg_nents,
+					    data_sg_offset, meta_sg,
+					    meta_sg_nents, meta_sg_offset);
+}
+EXPORT_SYMBOL(ib_map_mr_sg_pi);
+
 /**
  * ib_map_mr_sg() - Map the largest prefix of a dma mapped SG list
  *     and set it the memory region.
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1669a3886abf..96b868a223c5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2444,6 +2444,11 @@ struct ib_device_ops {
 	int (*read_counters)(struct ib_counters *counters,
 			     struct ib_counters_read_attr *counters_read_attr,
 			     struct uverbs_attr_bundle *attrs);
+	int (*map_mr_sg_pi)(struct ib_mr *mr, struct scatterlist *data_sg,
+			    int data_sg_nents, unsigned int *data_sg_offset,
+			    struct scatterlist *meta_sg, int meta_sg_nents,
+			    unsigned int *meta_sg_offset);
+
 	/**
 	 * alloc_hw_stats - Allocate a struct rdma_hw_stats and fill in the
 	 *   driver initialized data.  The struct is kfree()'ed by the sysfs
@@ -4241,6 +4246,10 @@ int ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
 
 int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
 		 unsigned int *sg_offset, unsigned int page_size);
+int ib_map_mr_sg_pi(struct ib_mr *mr, struct scatterlist *data_sg,
+		    int data_sg_nents, unsigned int *data_sg_offset,
+		    struct scatterlist *meta_sg, int meta_sg_nents,
+		    unsigned int *meta_sg_offset, unsigned int page_size);
 
 static inline int
 ib_map_mr_sg_zbva(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
-- 
2.16.3

