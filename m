Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B54FD642
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347779AbiDLJ51 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359451AbiDLHnD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D056FDFB1
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C8C616B2
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F29C385A6;
        Tue, 12 Apr 2022 07:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748258;
        bh=59bggVcQIHHtc4RAXdYTN2bJ76HMArkTtxTTRvXq3xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kh+GaYjjF/xqC2DygnTy01CFOiyBE8H60m96tVROPBUVeNoqroJrJbD7+jRh6yhaR
         i7oI60y3JEBijeFCWLRMyBhi0FxE8tzJ/zHXCtFxE2AWCxQmeOj+OsEZS/hBmde9df
         tpGpVwgH6qw9ehOHANsuOoAfOKoR/i/Ny06F46QivivMHc6JGLoCsosdA2pHMuIvsU
         QlnlDvkdRaXAZCofTYlEgNu5lH9EA+J4cp/7K3/cehCNNnvhOdg2NDpoDvmY072vKa
         A2wNVJL6Y5Y57dEvu3zHTp+wR9e5UDaC3buqcpQ5LSuiaifFgstddHXLeFwTsHEPKo
         FgO3yfQ4FLAdA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 01/12] RDMA/mlx5: Move init and cleanup of UMR to umr.c
Date:   Tue, 12 Apr 2022 10:23:56 +0300
Message-Id: <849e632dd1945a2534712a320cc5779f2149ba96.1649747695.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649747695.git.leonro@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

The first patch in a series to split UMR logic to a dedicated file.
As a start, move the init and cleanup of UMR resources to umr.c.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/Makefile |   1 +
 drivers/infiniband/hw/mlx5/main.c   | 109 ++--------------------------
 drivers/infiniband/hw/mlx5/umr.c    | 106 +++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/umr.h    |  12 +++
 4 files changed, 125 insertions(+), 103 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/umr.c
 create mode 100644 drivers/infiniband/hw/mlx5/umr.h

diff --git a/drivers/infiniband/hw/mlx5/Makefile b/drivers/infiniband/hw/mlx5/Makefile
index f43380106bd0..612ee8190a2d 100644
--- a/drivers/infiniband/hw/mlx5/Makefile
+++ b/drivers/infiniband/hw/mlx5/Makefile
@@ -19,6 +19,7 @@ mlx5_ib-y := ah.o \
 	     restrack.o \
 	     srq.o \
 	     srq_cmd.o \
+	     umr.o \
 	     wr.o
 
 mlx5_ib-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += odp.o
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 09a78a03cf73..e2d88027a9a7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -41,6 +41,7 @@
 #include "wr.h"
 #include "restrack.h"
 #include "counters.h"
+#include "umr.h"
 #include <rdma/uverbs_std_types.h>
 #include <rdma/uverbs_ioctl.h>
 #include <rdma/mlx5_user_ioctl_verbs.h>
@@ -4004,12 +4005,7 @@ static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
 	if (err)
 		mlx5_ib_warn(dev, "mr cache cleanup failed\n");
 
-	if (dev->umrc.qp)
-		ib_destroy_qp(dev->umrc.qp);
-	if (dev->umrc.cq)
-		ib_free_cq(dev->umrc.cq);
-	if (dev->umrc.pd)
-		ib_dealloc_pd(dev->umrc.pd);
+	mlx5r_umr_resource_cleanup(dev);
 }
 
 static void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev)
@@ -4017,112 +4013,19 @@ static void mlx5_ib_stage_ib_reg_cleanup(struct mlx5_ib_dev *dev)
 	ib_unregister_device(&dev->ib_dev);
 }
 
-enum {
-	MAX_UMR_WR = 128,
-};
-
 static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 {
-	struct ib_qp_init_attr *init_attr = NULL;
-	struct ib_qp_attr *attr = NULL;
-	struct ib_pd *pd;
-	struct ib_cq *cq;
-	struct ib_qp *qp;
 	int ret;
 
-	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
-	init_attr = kzalloc(sizeof(*init_attr), GFP_KERNEL);
-	if (!attr || !init_attr) {
-		ret = -ENOMEM;
-		goto error_0;
-	}
-
-	pd = ib_alloc_pd(&dev->ib_dev, 0);
-	if (IS_ERR(pd)) {
-		mlx5_ib_dbg(dev, "Couldn't create PD for sync UMR QP\n");
-		ret = PTR_ERR(pd);
-		goto error_0;
-	}
-
-	cq = ib_alloc_cq(&dev->ib_dev, NULL, 128, 0, IB_POLL_SOFTIRQ);
-	if (IS_ERR(cq)) {
-		mlx5_ib_dbg(dev, "Couldn't create CQ for sync UMR QP\n");
-		ret = PTR_ERR(cq);
-		goto error_2;
-	}
-
-	init_attr->send_cq = cq;
-	init_attr->recv_cq = cq;
-	init_attr->sq_sig_type = IB_SIGNAL_ALL_WR;
-	init_attr->cap.max_send_wr = MAX_UMR_WR;
-	init_attr->cap.max_send_sge = 1;
-	init_attr->qp_type = MLX5_IB_QPT_REG_UMR;
-	init_attr->port_num = 1;
-	qp = ib_create_qp(pd, init_attr);
-	if (IS_ERR(qp)) {
-		mlx5_ib_dbg(dev, "Couldn't create sync UMR QP\n");
-		ret = PTR_ERR(qp);
-		goto error_3;
-	}
-
-	attr->qp_state = IB_QPS_INIT;
-	attr->port_num = 1;
-	ret = ib_modify_qp(qp, attr,
-			   IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT);
-	if (ret) {
-		mlx5_ib_dbg(dev, "Couldn't modify UMR QP\n");
-		goto error_4;
-	}
-
-	memset(attr, 0, sizeof(*attr));
-	attr->qp_state = IB_QPS_RTR;
-	attr->path_mtu = IB_MTU_256;
-
-	ret = ib_modify_qp(qp, attr, IB_QP_STATE);
-	if (ret) {
-		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rtr\n");
-		goto error_4;
-	}
-
-	memset(attr, 0, sizeof(*attr));
-	attr->qp_state = IB_QPS_RTS;
-	ret = ib_modify_qp(qp, attr, IB_QP_STATE);
-	if (ret) {
-		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rts\n");
-		goto error_4;
-	}
-
-	dev->umrc.qp = qp;
-	dev->umrc.cq = cq;
-	dev->umrc.pd = pd;
+	ret = mlx5r_umr_resource_init(dev);
+	if (ret)
+		return ret;
 
-	sema_init(&dev->umrc.sem, MAX_UMR_WR);
 	ret = mlx5_mr_cache_init(dev);
 	if (ret) {
 		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
-		goto error_4;
+		mlx5r_umr_resource_cleanup(dev);
 	}
-
-	kfree(attr);
-	kfree(init_attr);
-
-	return 0;
-
-error_4:
-	ib_destroy_qp(qp);
-	dev->umrc.qp = NULL;
-
-error_3:
-	ib_free_cq(cq);
-	dev->umrc.cq = NULL;
-
-error_2:
-	ib_dealloc_pd(pd);
-	dev->umrc.pd = NULL;
-
-error_0:
-	kfree(attr);
-	kfree(init_attr);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
new file mode 100644
index 000000000000..46eaf919eb49
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
+
+#include "mlx5_ib.h"
+#include "umr.h"
+
+enum {
+	MAX_UMR_WR = 128,
+};
+
+static int mlx5r_umr_qp_rst2rts(struct mlx5_ib_dev *dev, struct ib_qp *qp)
+{
+	struct ib_qp_attr attr = {};
+	int ret;
+
+	attr.qp_state = IB_QPS_INIT;
+	attr.port_num = 1;
+	ret = ib_modify_qp(qp, &attr,
+			   IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT);
+	if (ret) {
+		mlx5_ib_dbg(dev, "Couldn't modify UMR QP\n");
+		return ret;
+	}
+
+	memset(&attr, 0, sizeof(attr));
+	attr.qp_state = IB_QPS_RTR;
+
+	ret = ib_modify_qp(qp, &attr, IB_QP_STATE);
+	if (ret) {
+		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rtr\n");
+		return ret;
+	}
+
+	memset(&attr, 0, sizeof(attr));
+	attr.qp_state = IB_QPS_RTS;
+	ret = ib_modify_qp(qp, &attr, IB_QP_STATE);
+	if (ret) {
+		mlx5_ib_dbg(dev, "Couldn't modify umr QP to rts\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev)
+{
+	struct ib_qp_init_attr init_attr = {};
+	struct ib_pd *pd;
+	struct ib_cq *cq;
+	struct ib_qp *qp;
+	int ret;
+
+	pd = ib_alloc_pd(&dev->ib_dev, 0);
+	if (IS_ERR(pd)) {
+		mlx5_ib_dbg(dev, "Couldn't create PD for sync UMR QP\n");
+		return PTR_ERR(pd);
+	}
+
+	cq = ib_alloc_cq(&dev->ib_dev, NULL, 128, 0, IB_POLL_SOFTIRQ);
+	if (IS_ERR(cq)) {
+		mlx5_ib_dbg(dev, "Couldn't create CQ for sync UMR QP\n");
+		ret = PTR_ERR(cq);
+		goto destroy_pd;
+	}
+
+	init_attr.send_cq = cq;
+	init_attr.recv_cq = cq;
+	init_attr.sq_sig_type = IB_SIGNAL_ALL_WR;
+	init_attr.cap.max_send_wr = MAX_UMR_WR;
+	init_attr.cap.max_send_sge = 1;
+	init_attr.qp_type = MLX5_IB_QPT_REG_UMR;
+	init_attr.port_num = 1;
+	qp = ib_create_qp(pd, &init_attr);
+	if (IS_ERR(qp)) {
+		mlx5_ib_dbg(dev, "Couldn't create sync UMR QP\n");
+		ret = PTR_ERR(qp);
+		goto destroy_cq;
+	}
+
+	ret = mlx5r_umr_qp_rst2rts(dev, qp);
+	if (ret)
+		goto destroy_qp;
+
+	dev->umrc.qp = qp;
+	dev->umrc.cq = cq;
+	dev->umrc.pd = pd;
+
+	sema_init(&dev->umrc.sem, MAX_UMR_WR);
+
+	return 0;
+
+destroy_qp:
+	ib_destroy_qp(qp);
+destroy_cq:
+	ib_free_cq(cq);
+destroy_pd:
+	ib_dealloc_pd(pd);
+	return ret;
+}
+
+void mlx5r_umr_resource_cleanup(struct mlx5_ib_dev *dev)
+{
+	ib_destroy_qp(dev->umrc.qp);
+	ib_free_cq(dev->umrc.cq);
+	ib_dealloc_pd(dev->umrc.pd);
+}
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
new file mode 100644
index 000000000000..cb1a2c95aac2
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
+
+#ifndef _MLX5_IB_UMR_H
+#define _MLX5_IB_UMR_H
+
+#include "mlx5_ib.h"
+
+int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev);
+void mlx5r_umr_resource_cleanup(struct mlx5_ib_dev *dev);
+
+#endif /* _MLX5_IB_UMR_H */
-- 
2.35.1

