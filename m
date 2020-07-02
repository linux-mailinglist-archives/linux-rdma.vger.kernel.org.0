Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2C3211DE7
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGBISX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 04:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGBISX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 04:18:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D98C320772;
        Thu,  2 Jul 2020 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593677901;
        bh=V6io/pZsNzHLr6E69XD9jZTttrOPpL6GFymPE6qEiXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDGZv5ahJushe2RcU5zVPmq3WVTTDjaPY9MazpkowNCM8kCZm8npt30sattbA44/N
         lIfGJbDuvjwh2P7oUzhBo9+yoI3o9dVJLFUsresysD17G1hWU8TirozFRCEhBExB0F
         lXEL0euAtMn2/lfXHi4swAWgUbX4ZEuiesQSzyu8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/6] RDMA/mlx5: Separate restrack callbacks initialization from main.c
Date:   Thu,  2 Jul 2020 11:18:05 +0300
Message-Id: <20200702081809.423482-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702081809.423482-1-leon@kernel.org>
References: <20200702081809.423482-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The restrack code has separate .c, so move callbacks initialization
to that file to improve code locality.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c     | 43 ++++++---------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h  | 38 ++---------------------
 drivers/infiniband/hw/mlx5/restrack.c | 29 +++++++++++++-----
 drivers/infiniband/hw/mlx5/restrack.h | 13 ++++++++
 4 files changed, 46 insertions(+), 77 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/restrack.h

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 4154fc2dd250..3f9588676ebf 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1,33 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright (c) 2013-2015, Mellanox Technologies. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
+ * Copyright (c) 2013-2020, Mellanox Technologies inc. All rights reserved.
  */
 
 #include <linux/debugfs.h>
@@ -62,6 +35,7 @@
 #include "srq.h"
 #include "qp.h"
 #include "wr.h"
+#include "restrack.h"
 #include <linux/mlx5/fs_helpers.h>
 #include <linux/mlx5/accel.h>
 #include <rdma/uverbs_std_types.h>
@@ -6618,11 +6592,6 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.drain_rq = mlx5_ib_drain_rq,
 	.drain_sq = mlx5_ib_drain_sq,
 	.enable_driver = mlx5_ib_enable_driver,
-	.fill_res_cq_entry_raw = mlx5_ib_fill_res_cq_entry_raw,
-	.fill_res_mr_entry = mlx5_ib_fill_res_mr_entry,
-	.fill_res_mr_entry_raw = mlx5_ib_fill_res_mr_entry_raw,
-	.fill_res_qp_entry_raw = mlx5_ib_fill_res_qp_entry_raw,
-	.fill_stat_mr_entry = mlx5_ib_fill_stat_mr_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
 	.get_link_layer = mlx5_ib_port_link_layer,
@@ -7210,6 +7179,9 @@ static const struct mlx5_ib_profile pf_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_DELAY_DROP,
 		     mlx5_ib_stage_delay_drop_init,
 		     mlx5_ib_stage_delay_drop_cleanup),
+	STAGE_CREATE(MLX5_IB_STAGE_RESTRACK,
+		     mlx5_ib_restrack_init,
+		     NULL),
 };
 
 const struct mlx5_ib_profile raw_eth_profile = {
@@ -7264,6 +7236,9 @@ const struct mlx5_ib_profile raw_eth_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
 		     mlx5_ib_stage_post_ib_reg_umr_init,
 		     NULL),
+	STAGE_CREATE(MLX5_IB_STAGE_RESTRACK,
+		     mlx5_ib_restrack_init,
+		     NULL),
 };
 
 static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 6d48f91a492c..733259567fad 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1,33 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
- * Copyright (c) 2013-2015, Mellanox Technologies. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
+ * Copyright (c) 2013-2020, Mellanox Technologies inc. All rights reserved.
  */
 
 #ifndef MLX5_IB_H
@@ -850,7 +823,7 @@ enum mlx5_ib_stages {
 	MLX5_IB_STAGE_IB_REG,
 	MLX5_IB_STAGE_POST_IB_REG_UMR,
 	MLX5_IB_STAGE_DELAY_DROP,
-	MLX5_IB_STAGE_CLASS_ATTR,
+	MLX5_IB_STAGE_RESTRACK,
 	MLX5_IB_STAGE_MAX,
 };
 
@@ -1373,11 +1346,6 @@ struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *dev,
 						   u8 *native_port_num);
 void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
-int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
-int mlx5_ib_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr);
-int mlx5_ib_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp);
-int mlx5_ib_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ibcq);
-int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 
 extern const struct uapi_definition mlx5_ib_devx_defs[];
 extern const struct uapi_definition mlx5_ib_flow_defs[];
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 32c6d0397946..887270dd3ce2 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright (c) 2019, Mellanox Technologies inc.  All rights reserved.
+ * Copyright (c) 2019-2020, Mellanox Technologies Ltd. All rights reserved.
  */
 
 #include <uapi/rdma/rdma_netlink.h>
@@ -8,6 +8,7 @@
 #include <rdma/ib_umem_odp.h>
 #include <rdma/restrack.h>
 #include "mlx5_ib.h"
+#include "restrack.h"
 
 #define MAX_DUMP_SIZE 1024
 
@@ -77,8 +78,7 @@ static int fill_res_raw(struct sk_buff *msg, struct mlx5_ib_dev *dev,
 	return err;
 }
 
-int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg,
-			       struct ib_mr *ibmr)
+static int fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
 	struct nlattr *table_attr;
@@ -112,7 +112,7 @@ int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
-int mlx5_ib_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ibmr)
+static int fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ibmr)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
 
@@ -120,8 +120,7 @@ int mlx5_ib_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ibmr)
 			    mlx5_mkey_to_idx(mr->mmkey.key));
 }
 
-int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
-			      struct ib_mr *ibmr)
+static int fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
 	struct nlattr *table_attr;
@@ -149,7 +148,7 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
-int mlx5_ib_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ibcq)
+static int fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ibcq)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibcq->device);
 	struct mlx5_ib_cq *cq = to_mcq(ibcq);
@@ -157,10 +156,24 @@ int mlx5_ib_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ibcq)
 	return fill_res_raw(msg, dev, MLX5_SGMT_TYPE_PRM_QUERY_CQ, cq->mcq.cqn);
 }
 
-int mlx5_ib_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp)
+static int fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
 
 	return fill_res_raw(msg, dev, MLX5_SGMT_TYPE_PRM_QUERY_QP,
 			    ibqp->qp_num);
 }
+
+static const struct ib_device_ops restrack_ops = {
+	.fill_res_cq_entry_raw = fill_res_cq_entry_raw,
+	.fill_res_mr_entry = fill_res_mr_entry,
+	.fill_res_mr_entry_raw = fill_res_mr_entry_raw,
+	.fill_res_qp_entry_raw = fill_res_qp_entry_raw,
+	.fill_stat_mr_entry = fill_stat_mr_entry,
+};
+
+int mlx5_ib_restrack_init(struct mlx5_ib_dev *dev)
+{
+	ib_set_device_ops(&dev->ib_dev, &restrack_ops);
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mlx5/restrack.h b/drivers/infiniband/hw/mlx5/restrack.h
new file mode 100644
index 000000000000..e8d81270f1b6
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/restrack.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2013-2020, Mellanox Technologies Ltd. All rights reserved.
+ */
+
+#ifndef _MLX5_IB_RESTRACK_H
+#define _MLX5_IB_RESTRACK_H
+
+#include "mlx5_ib.h"
+
+int mlx5_ib_restrack_init(struct mlx5_ib_dev *dev);
+
+#endif /* _MLX5_IB_RESTRACK_H */
-- 
2.26.2

