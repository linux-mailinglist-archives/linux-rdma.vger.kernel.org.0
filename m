Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26922A6688
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgKDOk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 09:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgKDOk0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Nov 2020 09:40:26 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A1B20739;
        Wed,  4 Nov 2020 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604500825;
        bh=kL22NUVmodfSN1qRrf4Ufad8+E1u6L+r8uXRnjzHrnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlfU+Fx36O+BzUMEfzefYo47v2fNfXQJuhYWVoQpxwIDiuCF1vLxkCiJtU16Ki9ZP
         B02fSdrLE97Qjmx7k2sJn4zjoJoOBbE75Y21NssKqaO0UTKiDFxXu3l5EnK/Egr1y3
         gsGJBsiLZIXK53jm7ZWbyGdcgtRMEP4fV3DIFlYM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v4 1/5] RDMA/core: Allow drivers to disable restrack DB
Date:   Wed,  4 Nov 2020 16:40:04 +0200
Message-Id: <20201104144008.3808124-2-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104144008.3808124-1-leon@kernel.org>
References: <20201104144008.3808124-1-leon@kernel.org>
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
index 47b9ed5599b3..44534a12819a 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1561,6 +1561,11 @@ static int _mlx4_ib_create_qp(struct ib_pd *pd, struct mlx4_ib_qp *qp,
 		if (err)
 			return err;

+		if (init_attr->create_flags &
+		    (MLX4_IB_SRIOV_SQP | MLX4_IB_SRIOV_TUNNEL_QP))
+			/* Internal QP created with ib_create_qp */
+			rdma_restrack_no_track(&qp->ibqp.res);
+
 		qp->port	= init_attr->port_num;
 		qp->ibqp.qp_num = init_attr->qp_type == IB_QPT_SMI ? 0 :
 			init_attr->create_flags & MLX4_IB_QP_CREATE_ROCE_V2_GSI ? sqpn : 1;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index cfabcd4d46b6..9a04a5949d50 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2435,7 +2435,7 @@ static int create_dct(struct mlx5_ib_dev *dev, struct ib_pd *pd,
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
2.28.0

