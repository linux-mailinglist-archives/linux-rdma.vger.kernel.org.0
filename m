Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A11C279859
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgIZKZK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgIZKZK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:25:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89DA5238E2;
        Sat, 26 Sep 2020 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115910;
        bh=+9TNJsNqHBG0vP3ub0u0gpJmup5PHK5PaYS1HfjJVSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHgHFWPssFz9401Zbd4EdbRz5Ox/fbUg3QQz/smCn31N8XgsEeKAVNBoI8ujE+wPf
         1wckAMO3hTgzYWQ0g/60QKAgdZLZLFPPs17KjnC2udp96T1dydPK2tNdQRkxoTTAO0
         UimBCijRJT/Br27AAUedItJ+B6ef8agOvVBjyh+4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 01/10] RDMA/mlx5: Embed GSI QP into general mlx5_ib QP
Date:   Sat, 26 Sep 2020 13:24:41 +0300
Message-Id: <20200926102450.2966017-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926102450.2966017-1-leon@kernel.org>
References: <20200926102450.2966017-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The GSI QPs have different create flow from the regular QPs, but it is
not really needed. Update the code to use mlx5_ib_qp as a storage class
for all outside of GSI calls.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/gsi.c     | 38 +++++++---------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 25 +++++++++++++++---
 drivers/infiniband/hw/mlx5/qp.c      |  2 +-
 3 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index d9f300f78a82..0b18558ba7b0 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -39,26 +39,6 @@ struct mlx5_ib_gsi_wr {
 	bool completed:1;
 };
 
-struct mlx5_ib_gsi_qp {
-	struct ib_qp ibqp;
-	struct ib_qp *rx_qp;
-	u8 port_num;
-	struct ib_qp_cap cap;
-	enum ib_sig_type sq_sig_type;
-	/* Serialize qp state modifications */
-	struct mutex mutex;
-	struct ib_cq *cq;
-	struct mlx5_ib_gsi_wr *outstanding_wrs;
-	u32 outstanding_pi, outstanding_ci;
-	int num_qps;
-	/* Protects access to the tx_qps. Post send operations synchronize
-	 * with tx_qp creation in setup_qp(). Also protects the
-	 * outstanding_wrs array and indices.
-	 */
-	spinlock_t lock;
-	struct ib_qp **tx_qps;
-};
-
 static struct mlx5_ib_gsi_qp *gsi_qp(struct ib_qp *qp)
 {
 	return container_of(qp, struct mlx5_ib_gsi_qp, ibqp);
@@ -116,6 +96,7 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 				    struct ib_qp_init_attr *init_attr)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	struct mlx5_ib_qp *mqp;
 	struct mlx5_ib_gsi_qp *gsi;
 	struct ib_qp_init_attr hw_init_attr = *init_attr;
 	const u8 port_num = init_attr->port_num;
@@ -130,10 +111,11 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 			num_qps = MLX5_MAX_PORTS;
 	}
 
-	gsi = kzalloc(sizeof(*gsi), GFP_KERNEL);
-	if (!gsi)
+	mqp = kzalloc(sizeof(struct mlx5_ib_qp), GFP_KERNEL);
+	if (!mqp)
 		return ERR_PTR(-ENOMEM);
 
+	gsi = &mqp->gsi;
 	gsi->tx_qps = kcalloc(num_qps, sizeof(*gsi->tx_qps), GFP_KERNEL);
 	if (!gsi->tx_qps) {
 		ret = -ENOMEM;
@@ -216,20 +198,18 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 err_free_tx:
 	kfree(gsi->tx_qps);
 err_free:
-	kfree(gsi);
+	kfree(mqp);
 	return ERR_PTR(ret);
 }
 
-int mlx5_ib_gsi_destroy_qp(struct ib_qp *qp)
+int mlx5_ib_destroy_gsi(struct mlx5_ib_qp *mqp)
 {
-	struct mlx5_ib_dev *dev = to_mdev(qp->device);
-	struct mlx5_ib_gsi_qp *gsi = gsi_qp(qp);
+	struct mlx5_ib_dev *dev = to_mdev(mqp->ibqp.device);
+	struct mlx5_ib_gsi_qp *gsi = &mqp->gsi;
 	const int port_num = gsi->port_num;
 	int qp_index;
 	int ret;
 
-	mlx5_ib_dbg(dev, "destroying GSI QP\n");
-
 	mutex_lock(&dev->devr.mutex);
 	ret = mlx5_ib_destroy_qp(gsi->rx_qp, NULL);
 	if (ret) {
@@ -253,7 +233,7 @@ int mlx5_ib_gsi_destroy_qp(struct ib_qp *qp)
 
 	kfree(gsi->outstanding_wrs);
 	kfree(gsi->tx_qps);
-	kfree(gsi);
+	kfree(mqp);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3856ee3854f6..384590d8402c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -384,6 +384,26 @@ struct mlx5_ib_dct {
 	u32                     *in;
 };
 
+struct mlx5_ib_gsi_qp {
+	struct ib_qp ibqp;
+	struct ib_qp *rx_qp;
+	u8 port_num;
+	struct ib_qp_cap cap;
+	enum ib_sig_type sq_sig_type;
+	/* Serialize qp state modifications */
+	struct mutex mutex;
+	struct ib_cq *cq;
+	struct mlx5_ib_gsi_wr *outstanding_wrs;
+	u32 outstanding_pi, outstanding_ci;
+	int num_qps;
+	/* Protects access to the tx_qps. Post send operations synchronize
+	 * with tx_qp creation in setup_qp(). Also protects the
+	 * outstanding_wrs array and indices.
+	 */
+	spinlock_t lock;
+	struct ib_qp **tx_qps;
+};
+
 struct mlx5_ib_qp {
 	struct ib_qp		ibqp;
 	union {
@@ -391,6 +411,7 @@ struct mlx5_ib_qp {
 		struct mlx5_ib_raw_packet_qp raw_packet_qp;
 		struct mlx5_ib_rss_qp rss_qp;
 		struct mlx5_ib_dct dct;
+		struct mlx5_ib_gsi_qp gsi;
 	};
 	struct mlx5_frag_buf	buf;
 
@@ -693,8 +714,6 @@ struct mlx5_mr_cache {
 	unsigned long		last_add;
 };
 
-struct mlx5_ib_gsi_qp;
-
 struct mlx5_ib_port_resources {
 	struct mlx5_ib_resources *devr;
 	struct mlx5_ib_gsi_qp *gsi;
@@ -1322,7 +1341,7 @@ void mlx5_ib_init_cong_debugfs(struct mlx5_ib_dev *dev, u8 port_num);
 /* GSI QP helper functions */
 struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 				    struct ib_qp_init_attr *init_attr);
-int mlx5_ib_gsi_destroy_qp(struct ib_qp *qp);
+int mlx5_ib_destroy_gsi(struct mlx5_ib_qp *mqp);
 int mlx5_ib_gsi_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
 			  int attr_mask);
 int mlx5_ib_gsi_query_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e8dd32d6a7ab..92dda0e50f5d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3037,7 +3037,7 @@ int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 	struct mlx5_ib_qp *mqp = to_mqp(qp);
 
 	if (unlikely(qp->qp_type == IB_QPT_GSI))
-		return mlx5_ib_gsi_destroy_qp(qp);
+		return mlx5_ib_destroy_gsi(mqp);
 
 	if (mqp->type == MLX5_IB_QPT_DCT)
 		return mlx5_ib_destroy_dct(mqp);
-- 
2.26.2

