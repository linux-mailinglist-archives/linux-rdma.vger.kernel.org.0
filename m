Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C571E449D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbgE0Ny1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 09:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388874AbgE0Ny0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 09:54:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D942078C;
        Wed, 27 May 2020 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590587666;
        bh=ySFhhdFkySNWYEtuo4spLvoSdIlEtXpM4t2Hb8NfmYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgCj7O8JCAHbQpJnD7ghB6t1BGf6oAKEVEHRPOK+pz7+ESepJhjQg/cfIM9Kvi7sB
         o8X0ar9dDs+uMH6JoOdmDCugbHC2rq2KlG+LdXuJH2YUI9Ki4JsTTo8Sw94LVGGZNe
         Tp4t2ebcslpNwsSSutoMz0UcsgQD/KS0EzjQ2fPY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH rdma-next v1 04/11] RDMA: Add dedicated MR resource tracker function
Date:   Wed, 27 May 2020 16:54:01 +0300
Message-Id: <20200527135408.480878-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527135408.480878-1-leon@kernel.org>
References: <20200527135408.480878-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

In order to avoid double multiplexing of the resource when it's MR,
add a dedicated callback function.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c       |  3 ++-
 drivers/infiniband/core/nldev.c        | 18 ++++-------------
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  1 +
 drivers/infiniband/hw/cxgb4/provider.c |  1 +
 drivers/infiniband/hw/cxgb4/restrack.c |  5 +----
 drivers/infiniband/hw/mlx5/main.c      |  4 ++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h   |  6 ++----
 drivers/infiniband/hw/mlx5/restrack.c  | 28 ++++----------------------
 include/rdma/ib_verbs.h                |  4 ++--
 9 files changed, 19 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d9f565a779df..e76875d8c101 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2618,7 +2618,8 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, drain_sq);
 	SET_DEVICE_OP(dev_ops, enable_driver);
 	SET_DEVICE_OP(dev_ops, fill_res_entry);
-	SET_DEVICE_OP(dev_ops, fill_stat_entry);
+	SET_DEVICE_OP(dev_ops, fill_res_mr_entry);
+	SET_DEVICE_OP(dev_ops, fill_stat_mr_entry);
 	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
 	SET_DEVICE_OP(dev_ops, get_dma_mr);
 	SET_DEVICE_OP(dev_ops, get_hw_stats);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 8548f09746ab..a4f3f838d6fe 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -454,14 +454,6 @@ static bool fill_res_entry(struct ib_device *dev, struct sk_buff *msg,
 	return dev->ops.fill_res_entry(msg, res);
 }
 
-static bool fill_stat_entry(struct ib_device *dev, struct sk_buff *msg,
-			    struct rdma_restrack_entry *res)
-{
-	if (!dev->ops.fill_stat_entry)
-		return false;
-	return dev->ops.fill_stat_entry(msg, res);
-}
-
 static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			     struct rdma_restrack_entry *res, uint32_t port)
 {
@@ -641,9 +633,8 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_name_pid(msg, res))
 		goto err;
 
-	if (fill_res_entry(dev, msg, res))
-		goto err;
-
+	if (dev->ops.fill_res_mr_entry)
+		return dev->ops.fill_res_mr_entry(msg, mr);
 	return 0;
 
 err:	return -EMSGSIZE;
@@ -786,9 +777,8 @@ static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
 		goto err;
 
-	if (fill_stat_entry(dev, msg, res))
-		goto err;
-
+	if (dev->ops.fill_stat_mr_entry)
+		return dev->ops.fill_stat_mr_entry(msg, mr);
 	return 0;
 
 err:
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index e8e11bd95e42..5b9884ca2f5e 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -1055,6 +1055,7 @@ struct c4iw_wr_wait *c4iw_alloc_wr_wait(gfp_t gfp);
 
 typedef int c4iw_restrack_func(struct sk_buff *msg,
 			       struct rdma_restrack_entry *res);
+int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr);
 extern c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX];
 
 #endif
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index ba83d942997c..36eeb595d41c 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -486,6 +486,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.destroy_qp = c4iw_destroy_qp,
 	.destroy_srq = c4iw_destroy_srq,
 	.fill_res_entry = fill_res_entry,
+	.fill_res_mr_entry = c4iw_fill_res_mr_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = c4iw_get_dma_mr,
 	.get_hw_stats = c4iw_get_mib,
diff --git a/drivers/infiniband/hw/cxgb4/restrack.c b/drivers/infiniband/hw/cxgb4/restrack.c
index f82d46ed969d..9a5ca9192c1c 100644
--- a/drivers/infiniband/hw/cxgb4/restrack.c
+++ b/drivers/infiniband/hw/cxgb4/restrack.c
@@ -433,10 +433,8 @@ static int fill_res_cq_entry(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
-static int fill_res_mr_entry(struct sk_buff *msg,
-			     struct rdma_restrack_entry *res)
+int c4iw_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
 {
-	struct ib_mr *ibmr = container_of(res, struct ib_mr, res);
 	struct c4iw_mr *mhp = to_c4iw_mr(ibmr);
 	struct c4iw_dev *dev = mhp->rhp;
 	u32 stag = mhp->attr.stag;
@@ -497,5 +495,4 @@ c4iw_restrack_func *c4iw_restrack_funcs[RDMA_RESTRACK_MAX] = {
 	[RDMA_RESTRACK_QP]	= fill_res_qp_entry,
 	[RDMA_RESTRACK_CM_ID]	= fill_res_ep_entry,
 	[RDMA_RESTRACK_CQ]	= fill_res_cq_entry,
-	[RDMA_RESTRACK_MR]	= fill_res_mr_entry,
 };
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index a8d694779b77..66f4bca1aa5d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6608,8 +6608,8 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.drain_rq = mlx5_ib_drain_rq,
 	.drain_sq = mlx5_ib_drain_sq,
 	.enable_driver = mlx5_ib_enable_driver,
-	.fill_res_entry = mlx5_ib_fill_res_entry,
-	.fill_stat_entry = mlx5_ib_fill_stat_entry,
+	.fill_res_mr_entry = mlx5_ib_fill_res_mr_entry,
+	.fill_stat_mr_entry = mlx5_ib_fill_stat_mr_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
 	.get_link_layer = mlx5_ib_port_link_layer,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 482b54eb9764..d2b36f4ce508 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1383,10 +1383,8 @@ struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *dev,
 						   u8 *native_port_num);
 void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
-int mlx5_ib_fill_res_entry(struct sk_buff *msg,
-			   struct rdma_restrack_entry *res);
-int mlx5_ib_fill_stat_entry(struct sk_buff *msg,
-			    struct rdma_restrack_entry *res);
+int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
+int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 
 extern const struct uapi_definition mlx5_ib_devx_defs[];
 extern const struct uapi_definition mlx5_ib_flow_defs[];
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 8f6c04f12531..598a09796d09 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -8,10 +8,9 @@
 #include <rdma/restrack.h>
 #include "mlx5_ib.h"
 
-static int fill_stat_mr_entry(struct sk_buff *msg,
-			      struct rdma_restrack_entry *res)
+int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg,
+			       struct ib_mr *ibmr)
 {
-	struct ib_mr *ibmr = container_of(res, struct ib_mr, res);
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
 	struct nlattr *table_attr;
 
@@ -41,10 +40,9 @@ static int fill_stat_mr_entry(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
-static int fill_res_mr_entry(struct sk_buff *msg,
-			     struct rdma_restrack_entry *res)
+int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
+			      struct ib_mr *ibmr)
 {
-	struct ib_mr *ibmr = container_of(res, struct ib_mr, res);
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
 	struct nlattr *table_attr;
 
@@ -70,21 +68,3 @@ static int fill_res_mr_entry(struct sk_buff *msg,
 	nla_nest_cancel(msg, table_attr);
 	return -EMSGSIZE;
 }
-
-int mlx5_ib_fill_res_entry(struct sk_buff *msg,
-			   struct rdma_restrack_entry *res)
-{
-	if (res->type == RDMA_RESTRACK_MR)
-		return fill_res_mr_entry(msg, res);
-
-	return 0;
-}
-
-int mlx5_ib_fill_stat_entry(struct sk_buff *msg,
-			    struct rdma_restrack_entry *res)
-{
-	if (res->type == RDMA_RESTRACK_MR)
-		return fill_stat_mr_entry(msg, res);
-
-	return 0;
-}
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3c4643cb20b1..5f2397c62f63 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2598,6 +2598,7 @@ struct ib_device_ops {
 	 */
 	int (*fill_res_entry)(struct sk_buff *msg,
 			      struct rdma_restrack_entry *entry);
+	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
 
 	/* Device lifecycle callbacks */
 	/*
@@ -2652,8 +2653,7 @@ struct ib_device_ops {
 	 * Allows rdma drivers to add their own restrack attributes
 	 * dumped via 'rdma stat' iproute2 command.
 	 */
-	int (*fill_stat_entry)(struct sk_buff *msg,
-			       struct rdma_restrack_entry *entry);
+	int (*fill_stat_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
 
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
-- 
2.26.2

