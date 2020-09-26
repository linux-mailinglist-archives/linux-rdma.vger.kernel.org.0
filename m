Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793E7279846
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIZKTt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKTs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:19:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476BF238E2;
        Sat, 26 Sep 2020 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115588;
        bh=u4PB09C5eq3yWYj5S6krRPXtxQKRRFw7nYLIl/g/CqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cq23yKSAmlTlftqHUgzA4RHyEeQYTdj50zuJWoV8Yj3Ez3ry9zWgCU+VIMY13oaqq
         V2WLv89Lqd8TZLAXrm4c3IhdANtMXDolMb1aV00Sa8HcTbnYApzgpkKDgWo9jPAOTj
         ctEpIaPJXlEaqQlk0pDhTYsUjmGlA2k6U9BTvx4s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v3 1/9] RDMA/core: Allow drivers to disable restrack DB
Date:   Sat, 26 Sep 2020 13:19:30 +0300
Message-Id: <20200926101938.2964394-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926101938.2964394-1-leon@kernel.org>
References: <20200926101938.2964394-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Driver QP types are special case with no IBTA restrictions. For example,
EFA implemented creation of this QP type as regular one, while mlx5
separated create to two step: create and modify. That separation causes
to the situation where DC QP (mlx5) is always added to the same xarray
index zero.

This change allows to drivers like mlx5 simply disable restrack DB
tracking, but it doesn't disable kref on the memory.

Fixes: 52e0a118a203 ("RDMA/restrack: Track driver QP types in resource tracker")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c |  2 +-
 drivers/infiniband/core/restrack.c | 12 ++++++++++--
 drivers/infiniband/hw/mlx4/qp.c    |  5 +++++
 drivers/infiniband/hw/mlx5/qp.c    |  2 +-
 include/rdma/restrack.h            | 24 ++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index e4ff0d3328b6..fa1a4a318fd7 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -275,7 +275,7 @@ int rdma_counter_bind_qp_auto(struct ib_qp *qp, u8 port)
 	struct rdma_counter *counter;
 	int ret;
 
-	if (!qp->res.valid || rdma_is_kernel_res(&qp->res))
+	if (!rdma_restrack_is_tracked(&qp->res) || rdma_is_kernel_res(&qp->res))
 		return 0;
 
 	if (!rdma_is_port_valid(dev, port))
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 4aeeaaed0f17..e26a3213f500 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -221,11 +221,14 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 {
 	struct ib_device *dev = res_to_dev(res);
 	struct rdma_restrack_root *rt;
-	int ret;
+	int ret = 0;
 
 	if (!dev)
 		return;
 
+	if (res->no_track)
+		goto out;
+
 	rt = &dev->res[res->type];
 
 	if (res->type == RDMA_RESTRACK_QP) {
@@ -246,6 +249,7 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 				      &rt->next_id, GFP_KERNEL);
 	}
 
+out:
 	if (!ret)
 		res->valid = true;
 }
@@ -318,6 +322,9 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 		return;
 	}
 
+	if (res->no_track)
+		goto out;
+
 	dev = res_to_dev(res);
 	if (WARN_ON(!dev))
 		return;
@@ -328,8 +335,9 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
 		return;
 	WARN_ON(old != res);
-	res->valid = false;
 
+out:
+	res->valid = false;
 	rdma_restrack_put(res);
 	wait_for_completion(&res->comp);
 }
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 0cb1a6e2fed4..a52d1e9e97d9 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1627,6 +1627,11 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
 		if (err)
 			return ERR_PTR(err);
 
+		if (init_attr->create_flags &
+		    (MLX4_IB_SRIOV_SQP | MLX4_IB_SRIOV_TUNNEL_QP))
+			/* Internal QP created with ib_create_qp */
+			rdma_restrack_no_track(&qp->ibqp.res);
+
 		qp->port	= init_attr->port_num;
 		qp->ibqp.qp_num = init_attr->qp_type == IB_QPT_SMI ? 0 :
 			init_attr->create_flags & MLX4_IB_QP_CREATE_ROCE_V2_GSI ? sqpn : 1;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 55e278750b59..e8dd32d6a7ab 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2436,7 +2436,7 @@ static int create_dct(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 
 	qp->state = IB_QPS_RESET;
-
+	rdma_restrack_no_track(&qp->ibqp.res);
 	return 0;
 }
 
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index d3a1cc5be7bc..05e18839eaff 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -68,6 +68,14 @@ struct rdma_restrack_entry {
 	 * As an example for that, see mlx5 QPs with type MLX5_IB_QPT_HW_GSI
 	 */
 	bool			valid;
+	/**
+	 * @no_track: don't add this entry to restrack DB
+	 *
+	 * This field is used to mark an entry that doesn't need to be added to
+	 * internal restrack DB and presented later to the users at the nldev
+	 * query stage.
+	 */
+	u8			no_track : 1;
 	/*
 	 * @kref: Protect destroy of the resource
 	 */
@@ -145,4 +153,20 @@ int rdma_nl_stat_hwcounter_entry(struct sk_buff *msg, const char *name,
 struct rdma_restrack_entry *rdma_restrack_get_byid(struct ib_device *dev,
 						   enum rdma_restrack_type type,
 						   u32 id);
+
+/**
+ * rdma_restrack_no_track() - don't add resource to the DB
+ * @res: resource entry
+ *
+ * Every user of thie API should be cross examined.
+ * Probaby you don't need to use this function.
+ */
+static inline void rdma_restrack_no_track(struct rdma_restrack_entry *res)
+{
+	res->no_track = true;
+}
+static inline bool rdma_restrack_is_tracked(struct rdma_restrack_entry *res)
+{
+	return !res->no_track;
+}
 #endif /* _RDMA_RESTRACK_H_ */
-- 
2.26.2

