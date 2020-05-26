Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14EF1E242E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgEZOfD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 10:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgEZOfD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 10:35:03 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D9DF2065F;
        Tue, 26 May 2020 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590503702;
        bh=03MF/Z5VwGrNAAd3Bf7lZLsa8AaGEe+Nx6T6iObzI1I=;
        h=From:To:Cc:Subject:Date:From;
        b=mah2OKqW+5LMzh+Befzr6VEPwodiKSuD/Mn1LQYaqa8xj2yR4pQyxT4BayW953eFU
         O2UA2BGs4XgSZ2eWnC9JY4yS7uz8IVcsMr/gfbEzNSOQQx3Uzs0DClrM16m3jUK6wS
         74M1sMsQ4A/OcrC25Ra2XlEHIPGlbjsNEmMWoRYE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Support TX port affinity for VF drivers in LAG mode
Date:   Tue, 26 May 2020 17:34:57 +0300
Message-Id: <20200526143457.218840-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

The mlx5 VF driver doesn't set QP tx port affinity because it doesn't
know if the lag is active or not, since the "lag_active" works only for
PF interfaces. In this case for VF interfaces only one lag is used
which brings performance issue.

Add a lag_tx_port_affinity CAP bit; When it is enabled and
"num_lag_ports > 1", then driver always set QP tx affinity, regardless
of lag state.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 7 +++++++
 drivers/infiniband/hw/mlx5/qp.c      | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 570c519ca530..4719da201382 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1984,7 +1984,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	context->lib_caps = req.lib_caps;
 	print_lib_caps(dev, context->lib_caps);
 
-	if (dev->lag_active) {
+	if (mlx5_ib_lag_should_assign_affinity(dev)) {
 		u8 port = mlx5_core_native_port_num(dev->mdev) - 1;
 
 		atomic_set(&context->tx_port_affinity,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index b486139b08ce..0f5a713ac2a9 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1553,4 +1553,11 @@ static inline bool mlx5_ib_can_use_umr(struct mlx5_ib_dev *dev,
 
 int mlx5_ib_enable_driver(struct ib_device *dev);
 int mlx5_ib_test_wc(struct mlx5_ib_dev *dev);
+
+static inline bool mlx5_ib_lag_should_assign_affinity(struct mlx5_ib_dev *dev)
+{
+	return dev->lag_active ||
+		(MLX5_CAP_GEN(dev->mdev, num_lag_ports) &&
+		 MLX5_CAP_GEN(dev->mdev, lag_tx_port_affinity));
+}
 #endif /* MLX5_IB_H */
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 1988a0375696..9364a7a76ac2 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3653,7 +3653,8 @@ static unsigned int get_tx_affinity(struct ib_qp *qp,
 	struct mlx5_ib_qp_base *qp_base;
 	unsigned int tx_affinity;
 
-	if (!(dev->lag_active && qp_supports_affinity(qp)))
+	if (!(mlx5_ib_lag_should_assign_affinity(dev) &&
+	      qp_supports_affinity(qp)))
 		return 0;
 
 	if (mqp->flags & MLX5_IB_QP_CREATE_SQPN_QP1)
-- 
2.26.2

