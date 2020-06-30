Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E8A20F280
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 12:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbgF3KTN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 06:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732424AbgF3KTF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 06:19:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A5E20760;
        Tue, 30 Jun 2020 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593512345;
        bh=Pj8/5vgVuPKAXjpjWXzleSa3FcTFVo5Ikryzv1qw/lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0iBEyrgQRJ1mV2S6C0NYnyaWwVM3Juk21x9vWnSV8ECkOBx0jVN0x+pmJ7pMUjFY
         XaMgV0Joy29GJkIGIFpmMJDAb60QyhQealtrjiNhUQPMH7kRWrLf2IhzoZywcn5pJM
         aO3sbcjlekFilQEDOzu0Bsz2Qk4+yP/XIYlWmdhE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/4] RDMA/core: Create and destroy counters in the ib_core
Date:   Tue, 30 Jun 2020 13:18:52 +0300
Message-Id: <20200630101855.368895-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630101855.368895-1-leon@kernel.org>
References: <20200630101855.368895-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Move allocation and destruction of counters under ib_core responsibility

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c              |  1 +
 .../core/uverbs_std_types_counters.c          | 17 ++++++++--------
 drivers/infiniband/hw/mlx5/main.c             | 20 ++++++-------------
 include/rdma/ib_verbs.h                       |  7 ++++---
 4 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1da1b0731f25..088559d72d57 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2682,6 +2682,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
 
 	SET_OBJ_SIZE(dev_ops, ib_ah);
+	SET_OBJ_SIZE(dev_ops, ib_counters);
 	SET_OBJ_SIZE(dev_ops, ib_cq);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
 	SET_OBJ_SIZE(dev_ops, ib_srq);
diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index 9f013304e677..c7e7438752bc 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -46,7 +46,9 @@ static int uverbs_free_counters(struct ib_uobject *uobject,
 	if (ret)
 		return ret;
 
-	return counters->device->ops.destroy_counters(counters);
+	counters->device->ops.destroy_counters(counters);
+	kfree(counters);
+	return 0;
 }
 
 static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
@@ -66,20 +68,19 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
 	if (!ib_dev->ops.create_counters)
 		return -EOPNOTSUPP;
 
-	counters = ib_dev->ops.create_counters(ib_dev, attrs);
-	if (IS_ERR(counters)) {
-		ret = PTR_ERR(counters);
-		goto err_create_counters;
-	}
+	counters = rdma_zalloc_drv_obj(ib_dev, ib_counters);
+	if (!counters)
+		return -ENOMEM;
 
 	counters->device = ib_dev;
 	counters->uobject = uobj;
 	uobj->object = counters;
 	atomic_set(&counters->usecnt, 0);
 
-	return 0;
+	ret = ib_dev->ops.create_counters(counters, attrs);
+	if (ret)
+		kfree(counters);
 
-err_create_counters:
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 46c596a855e7..ca35394a181a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6458,7 +6458,7 @@ static int mlx5_ib_read_counters(struct ib_counters *counters,
 	return ret;
 }
 
-static int mlx5_ib_destroy_counters(struct ib_counters *counters)
+static void mlx5_ib_destroy_counters(struct ib_counters *counters)
 {
 	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
 
@@ -6466,24 +6466,15 @@ static int mlx5_ib_destroy_counters(struct ib_counters *counters)
 	if (mcounters->hw_cntrs_hndl)
 		mlx5_fc_destroy(to_mdev(counters->device)->mdev,
 				mcounters->hw_cntrs_hndl);
-
-	kfree(mcounters);
-
-	return 0;
 }
 
-static struct ib_counters *mlx5_ib_create_counters(struct ib_device *device,
-						   struct uverbs_attr_bundle *attrs)
+static int mlx5_ib_create_counters(struct ib_counters *counters,
+				   struct uverbs_attr_bundle *attrs)
 {
-	struct mlx5_ib_mcounters *mcounters;
-
-	mcounters = kzalloc(sizeof(*mcounters), GFP_KERNEL);
-	if (!mcounters)
-		return ERR_PTR(-ENOMEM);
+	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
 
 	mutex_init(&mcounters->mcntrs_mutex);
-
-	return &mcounters->ibcntrs;
+	return 0;
 }
 
 static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
@@ -6651,6 +6642,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.resize_cq = mlx5_ib_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_counters, mlx5_ib_mcounters, ibcntrs),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mlx5_ib_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mlx5_ib_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, mlx5_ib_srq, ibsrq),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 55762f0458a6..9b69bc0a53cf 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2541,9 +2541,9 @@ struct ib_device_ops {
 	struct ib_mr *(*reg_dm_mr)(struct ib_pd *pd, struct ib_dm *dm,
 				   struct ib_dm_mr_attr *attr,
 				   struct uverbs_attr_bundle *attrs);
-	struct ib_counters *(*create_counters)(
-		struct ib_device *device, struct uverbs_attr_bundle *attrs);
-	int (*destroy_counters)(struct ib_counters *counters);
+	int (*create_counters)(struct ib_counters *counters,
+			       struct uverbs_attr_bundle *attrs);
+	void (*destroy_counters)(struct ib_counters *counters);
 	int (*read_counters)(struct ib_counters *counters,
 			     struct ib_counters_read_attr *counters_read_attr,
 			     struct uverbs_attr_bundle *attrs);
@@ -2651,6 +2651,7 @@ struct ib_device_ops {
 			      struct uverbs_attr_bundle *attrs);
 
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
+	DECLARE_RDMA_OBJ_SIZE(ib_counters);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
-- 
2.26.2

