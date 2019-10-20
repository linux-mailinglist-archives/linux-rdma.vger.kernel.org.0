Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8507DDD14
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 08:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJTGoL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 02:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfJTGoL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 02:44:11 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA62222C2;
        Sun, 20 Oct 2019 06:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571553849;
        bh=NEvTOi9TvFYKyB11LwIJf5dNxgyivNcj3P94jsnBLxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARbcs2e8CRliqC9m95qZdSJSdiHOKAfjK/TBLbj2f3molJUBbXcD514sY+5xwzsvH
         FiiF8Tl36+jLQUBOt5BMy9JLuF1rVoahRXrT6VwawjmqZN3NMDcbmHzYPvPfw29NG6
         oZlvM5BAGze8niqTREhWPJEPwUN53/YDmdntZSK8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: [PATCH rdma-next 1/2] IB/mlx5: Align usage of QP1 create flags with rest of mlx5 defines
Date:   Sun, 20 Oct 2019 09:43:59 +0300
Message-Id: <20191020064400.8344-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020064400.8344-1-leon@kernel.org>
References: <20191020064400.8344-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

There is little value in keeping separate function for one flag, provide
it directly like any other mlx5 define.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/gsi.c     | 2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 7 +------
 drivers/infiniband/hw/mlx5/qp.c      | 8 ++++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index 4950df3f71b6..ac4d8d1b9a07 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -263,7 +263,7 @@ static struct ib_qp *create_gsi_ud_qp(struct mlx5_ib_gsi_qp *gsi)
 		},
 		.sq_sig_type = gsi->sq_sig_type,
 		.qp_type = IB_QPT_UD,
-		.create_flags = mlx5_ib_create_qp_sqpn_qp1(),
+		.create_flags = MLX5_IB_QP_CREATE_SQPN_QP1,
 	};

 	return ib_create_qp(pd, &init_attr);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e9bdb48cf1d3..27980295aee8 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -247,12 +247,7 @@ struct mlx5_ib_flow_db {
  * These flags are intended for internal use by the mlx5_ib driver, and they
  * rely on the range reserved for that use in the ib_qp_create_flags enum.
  */
-
-/* Create a UD QP whose source QP number is 1 */
-static inline enum ib_qp_create_flags mlx5_ib_create_qp_sqpn_qp1(void)
-{
-	return IB_QP_CREATE_RESERVED_START;
-}
+#define MLX5_IB_QP_CREATE_SQPN_QP1	IB_QP_CREATE_RESERVED_START

 struct wr_list {
 	u16	opcode;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8937d72ddcf6..bb3f432e2fb6 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1041,7 +1041,7 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev,
 					IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK |
 					IB_QP_CREATE_IPOIB_UD_LSO |
 					IB_QP_CREATE_NETIF_QP |
-					mlx5_ib_create_qp_sqpn_qp1()))
+					MLX5_IB_QP_CREATE_SQPN_QP1))
 		return -EINVAL;

 	if (init_attr->qp_type == MLX5_IB_QPT_REG_UMR)
@@ -1104,7 +1104,7 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev,
 	MLX5_SET(qpc, qpc, fre, 1);
 	MLX5_SET(qpc, qpc, rlky, 1);

-	if (init_attr->create_flags & mlx5_ib_create_qp_sqpn_qp1()) {
+	if (init_attr->create_flags & MLX5_IB_QP_CREATE_SQPN_QP1) {
 		MLX5_SET(qpc, qpc, deth_sqpn, 1);
 		qp->flags |= MLX5_IB_QP_SQPN_QP1;
 	}
@@ -2140,7 +2140,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 				return -EINVAL;
 			}
 			if (init_attr->create_flags &
-			    mlx5_ib_create_qp_sqpn_qp1()) {
+			    MLX5_IB_QP_CREATE_SQPN_QP1) {
 				mlx5_ib_dbg(dev, "user-space is not allowed to create UD QPs spoofing as QP1\n");
 				return -EINVAL;
 			}
@@ -5823,7 +5823,7 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	if (qp->flags & MLX5_IB_QP_MANAGED_RECV)
 		qp_init_attr->create_flags |= IB_QP_CREATE_MANAGED_RECV;
 	if (qp->flags & MLX5_IB_QP_SQPN_QP1)
-		qp_init_attr->create_flags |= mlx5_ib_create_qp_sqpn_qp1();
+		qp_init_attr->create_flags |= MLX5_IB_QP_CREATE_SQPN_QP1;

 	qp_init_attr->sq_sig_type = qp->sq_signal_bits & MLX5_WQE_CTRL_CQ_UPDATE ?
 		IB_SIGNAL_ALL_WR : IB_SIGNAL_REQ_WR;
--
2.20.1

