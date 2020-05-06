Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED21C6D5C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgEFJmM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 05:42:12 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33007 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729134AbgEFJmL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 05:42:11 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0Mw015448;
        Wed, 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0a7024591;
        Wed, 6 May 2020 12:42:00 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0469g056024590;
        Wed, 6 May 2020 12:42:00 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 3/8] mlx4: Delete comp_mask from verbs_srq
Date:   Wed,  6 May 2020 12:41:04 +0300
Message-Id: <1588758069-24464-4-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
References: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This is a hold over from when the driver.h was not tied to the rdma-core
version, delete it.

The only reader in mlx4 was using it to tell if the SRQ was XRC or not,
just test that directly.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 libibverbs/cmd.c       | 13 +++----------
 libibverbs/driver.h    | 19 -------------------
 providers/mlx4/mlx4.c  |  2 +-
 providers/mlx4/mlx4.h  |  1 +
 providers/mlx4/verbs.c | 11 +++++++++++
 5 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/libibverbs/cmd.c b/libibverbs/cmd.c
index 728d884..03d9143 100644
--- a/libibverbs/cmd.c
+++ b/libibverbs/cmd.c
@@ -577,21 +577,14 @@ int ibv_cmd_create_srq_ex(struct ibv_context *context,
 	 * If it is than all the others exist as well
 	 */
 	if (vext_field_avail(struct verbs_srq, srq_num, vsrq_sz)) {
-		srq->comp_mask = IBV_SRQ_INIT_ATTR_TYPE;
 		srq->srq_type = (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_TYPE) ?
 				attr_ex->srq_type : IBV_SRQT_BASIC;
-		if (srq->srq_type == IBV_SRQT_XRC) {
-			srq->comp_mask |= VERBS_SRQ_NUM;
+		if (srq->srq_type == IBV_SRQT_XRC)
 			srq->srq_num = resp->srqn;
-		}
-		if (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_XRCD) {
-			srq->comp_mask |= VERBS_SRQ_XRCD;
+		if (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_XRCD)
 			srq->xrcd = vxrcd;
-		}
-		if (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_CQ) {
-			srq->comp_mask |= VERBS_SRQ_CQ;
+		if (attr_ex->comp_mask & IBV_SRQ_INIT_ATTR_CQ)
 			srq->cq = attr_ex->cq;
-		}
 	}
 
 	attr_ex->attr.max_wr = resp->max_wr;
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index a0e6f89..9cb78a5 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -59,17 +59,8 @@ struct verbs_xrcd {
 	uint32_t		handle;
 };
 
-enum verbs_srq_mask {
-	VERBS_SRQ_TYPE		= 1 << 0,
-	VERBS_SRQ_XRCD		= 1 << 1,
-	VERBS_SRQ_CQ		= 1 << 2,
-	VERBS_SRQ_NUM		= 1 << 3,
-	VERBS_SRQ_RESERVED	= 1 << 4
-};
-
 struct verbs_srq {
 	struct ibv_srq		srq;
-	uint32_t		comp_mask;
 	enum ibv_srq_type	srq_type;
 	struct verbs_xrcd      *xrcd;
 	struct ibv_cq	       *cq;
@@ -633,16 +624,6 @@ int ibv_read_ibdev_sysfs_file(char *buf, size_t size,
 	__attribute__((format(printf, 4, 5)));
 int ibv_get_fw_ver(char *value, size_t len, struct verbs_sysfs_dev *sysfs_dev);
 
-static inline int verbs_get_srq_num(struct ibv_srq *srq, uint32_t *srq_num)
-{
-	struct verbs_srq *vsrq = container_of(srq, struct verbs_srq, srq);
-	if (vsrq->comp_mask & VERBS_SRQ_NUM) {
-		*srq_num = vsrq->srq_num;
-		return 0;
-	}
-	return EOPNOTSUPP;
-}
-
 static inline bool check_comp_mask(uint64_t input, uint64_t supported)
 {
 	return (input & ~supported) == 0;
diff --git a/providers/mlx4/mlx4.c b/providers/mlx4/mlx4.c
index 0842ff0..f04d346 100644
--- a/providers/mlx4/mlx4.c
+++ b/providers/mlx4/mlx4.c
@@ -126,7 +126,7 @@ static const struct verbs_context_ops mlx4_ctx_ops = {
 	.destroy_flow = mlx4_destroy_flow,
 	.destroy_rwq_ind_table = mlx4_destroy_rwq_ind_table,
 	.destroy_wq = mlx4_destroy_wq,
-	.get_srq_num = verbs_get_srq_num,
+	.get_srq_num = mlx4_get_srq_num,
 	.modify_cq = mlx4_modify_cq,
 	.modify_wq = mlx4_modify_wq,
 	.open_qp = mlx4_open_qp,
diff --git a/providers/mlx4/mlx4.h b/providers/mlx4/mlx4.h
index 3c161e8..16ed7d6 100644
--- a/providers/mlx4/mlx4.h
+++ b/providers/mlx4/mlx4.h
@@ -319,6 +319,7 @@ int mlx4_free_pd(struct ibv_pd *pd);
 struct ibv_xrcd *mlx4_open_xrcd(struct ibv_context *context,
 				struct ibv_xrcd_init_attr *attr);
 int mlx4_close_xrcd(struct ibv_xrcd *xrcd);
+int mlx4_get_srq_num(struct ibv_srq *srq, uint32_t *srq_num);
 
 struct ibv_mr *mlx4_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 			   uint64_t hca_va, int access);
diff --git a/providers/mlx4/verbs.c b/providers/mlx4/verbs.c
index 9f39ecd..010cd6c 100644
--- a/providers/mlx4/verbs.c
+++ b/providers/mlx4/verbs.c
@@ -274,6 +274,17 @@ int mlx4_close_xrcd(struct ibv_xrcd *ib_xrcd)
 	return 0;
 }
 
+int mlx4_get_srq_num(struct ibv_srq *srq, uint32_t *srq_num)
+{
+	struct mlx4_srq *msrq =
+		container_of(srq, struct mlx4_srq, verbs_srq.srq);
+
+	if (!msrq->verbs_srq.xrcd)
+		return EOPNOTSUPP;
+	*srq_num = msrq->verbs_srq.srq_num;
+	return 0;
+}
+
 struct ibv_mr *mlx4_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 			   uint64_t hca_va, int access)
 {
-- 
1.8.3.1

