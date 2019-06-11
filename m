Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B013D167
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391545AbfFKPxG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:53:06 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33035 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391826AbfFKPxG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 11:53:06 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Jun 2019 18:52:59 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x5BFqxL5023036;
        Tue, 11 Jun 2019 18:52:59 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 03/21] RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and ib_alloc_mr_integrity API
Date:   Tue, 11 Jun 2019 18:52:39 +0300
Message-Id: <1560268377-26560-4-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

This is a preparation for signature verbs API re-design. In the new
design a single MR with IB_MR_TYPE_INTEGRITY type will be used to perform
the needed mapping for data integrity operations.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/core/device.c |  1 +
 drivers/infiniband/core/verbs.c  | 46 ++++++++++++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h          | 10 +++++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 29f7b15c81d9..e698ad34e528 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2350,6 +2350,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, alloc_fmr);
 	SET_DEVICE_OP(dev_ops, alloc_hw_stats);
 	SET_DEVICE_OP(dev_ops, alloc_mr);
+	SET_DEVICE_OP(dev_ops, alloc_mr_integrity);
 	SET_DEVICE_OP(dev_ops, alloc_mw);
 	SET_DEVICE_OP(dev_ops, alloc_pd);
 	SET_DEVICE_OP(dev_ops, alloc_rdma_netdev);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e080202ff673..80b9dc0dbd6a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2002,6 +2002,9 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 	if (!pd->device->ops.alloc_mr)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (WARN_ON_ONCE(mr_type == IB_MR_TYPE_INTEGRITY))
+		return ERR_PTR(-EINVAL);
+
 	mr = pd->device->ops.alloc_mr(pd, mr_type, max_num_sg, udata);
 	if (!IS_ERR(mr)) {
 		mr->device  = pd->device;
@@ -2019,6 +2022,49 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 }
 EXPORT_SYMBOL(ib_alloc_mr_user);
 
+/**
+ * ib_alloc_mr_integrity() - Allocates an integrity memory region
+ * @pd:                      protection domain associated with the region
+ * @max_num_data_sg:         maximum data sg entries available for registration
+ * @max_num_meta_sg:         maximum metadata sg entries available for
+ *                           registration
+ *
+ * Notes:
+ * Memory registration page/sg lists must not exceed max_num_sg,
+ * also the integrity page/sg lists must not exceed max_num_meta_sg.
+ *
+ */
+struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
+				    u32 max_num_data_sg,
+				    u32 max_num_meta_sg)
+{
+	struct ib_mr *mr;
+
+	if (!pd->device->ops.alloc_mr_integrity)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!max_num_meta_sg)
+		return ERR_PTR(-EINVAL);
+
+	mr = pd->device->ops.alloc_mr_integrity(pd, max_num_data_sg,
+						max_num_meta_sg);
+	if (IS_ERR(mr))
+		return mr;
+
+	mr->device = pd->device;
+	mr->pd = pd;
+	mr->dm = NULL;
+	mr->uobject = NULL;
+	atomic_inc(&pd->usecnt);
+	mr->need_inval = false;
+	mr->res.type = RDMA_RESTRACK_MR;
+	rdma_restrack_kadd(&mr->res);
+	mr->type = IB_MR_TYPE_INTEGRITY;
+
+	return mr;
+}
+EXPORT_SYMBOL(ib_alloc_mr_integrity);
+
 /* "Fast" memory regions */
 
 struct ib_fmr *ib_alloc_fmr(struct ib_pd *pd,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9d925b1346c4..1f0442545aae 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -799,6 +799,8 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate);
  *                            application
  * @IB_MR_TYPE_DMA:           memory region that is used for DMA operations
  *                            without address translations (VA=PA)
+ * @IB_MR_TYPE_INTEGRITY:     memory region that is used for
+ *                            data integrity operations
  */
 enum ib_mr_type {
 	IB_MR_TYPE_MEM_REG,
@@ -807,6 +809,7 @@ enum ib_mr_type {
 	IB_MR_TYPE_DM,
 	IB_MR_TYPE_USER,
 	IB_MR_TYPE_DMA,
+	IB_MR_TYPE_INTEGRITY,
 };
 
 enum ib_mr_status_check {
@@ -2370,6 +2373,9 @@ struct ib_device_ops {
 	int (*dereg_mr)(struct ib_mr *mr, struct ib_udata *udata);
 	struct ib_mr *(*alloc_mr)(struct ib_pd *pd, enum ib_mr_type mr_type,
 				  u32 max_num_sg, struct ib_udata *udata);
+	struct ib_mr *(*alloc_mr_integrity)(struct ib_pd *pd,
+					    u32 max_num_data_sg,
+					    u32 max_num_meta_sg);
 	int (*advise_mr)(struct ib_pd *pd,
 			 enum ib_uverbs_advise_mr_advice advice, u32 flags,
 			 struct ib_sge *sg_list, u32 num_sge,
@@ -4048,6 +4054,10 @@ static inline struct ib_mr *ib_alloc_mr(struct ib_pd *pd,
 	return ib_alloc_mr_user(pd, mr_type, max_num_sg, NULL);
 }
 
+struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
+				    u32 max_num_data_sg,
+				    u32 max_num_meta_sg);
+
 /**
  * ib_update_fast_reg_key - updates the key portion of the fast_reg MR
  *   R_Key and L_Key.
-- 
2.16.3

