Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15E13048E7
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 20:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbhAZFhY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 00:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbhAYMSu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Jan 2021 07:18:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD5A322DFB;
        Mon, 25 Jan 2021 12:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611576433;
        bh=SMyvUhramXaCm7yPyG7YnUik3rpKmq8/Vl1U5c5K9A8=;
        h=From:To:Cc:Subject:Date:From;
        b=KIHaM4P944WLHizYKD14s+xFwzQzCVnuPN+ZiR3tYvCCr1et6wFNUGWU8pATpREnu
         aCBhgLFGZ6vAT4OyFX/ycpZkuvfrBGUDy9ATLB/37T3W9tPXVcfe/DsQHxUfaeEJmR
         KwYI9rYra6Boh0gHNwy39da/Cjes8AlH82/FCEDlfilsZ+f1N1RXEBI+IVdeeGcf2P
         khocUQabWWdVRVHvxfybux9zcXDrA7O9qFAqpGTKQAZFeJbI1IMZ9tS+dQ5aFtfIN3
         4TEHrypHg3mDLu0lhxDKxvddUIosFMc+wkX1VMUeTVoSrYOB2BmDc8ktK3m1Mm+Am+
         GRzLWWL61RWmQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Allow creating all QPs even when non RDMA profile is used
Date:   Mon, 25 Jan 2021 14:07:09 +0200
Message-Id: <20210125120709.836718-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <mbloch@nvidia.com>

The cited commit disallowed creating any QP which isn't raw ethernet,
reg umr or the special UD qp for testing WC, this proved too strict.

While modify can't be done (no GIDS/GID table for example) just creating
a QP is okay.

This patch partially reverts the bellow mentioned commit and places
the restriction at the modify QP stage and not at the creation.
DEVX commands should be used to manipulate such QPs.

Fixes: 42caf9cb5937 ("RDMA/mlx5: Allow only raw Ethernet QPs when RoCE isn't enabled")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 5353a921f468..aa5f693fe0cd 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2433,9 +2433,6 @@ static int check_qp_type(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr,
 	case MLX5_IB_QPT_HW_GSI:
 	case IB_QPT_DRIVER:
 	case IB_QPT_GSI:
-		if (dev->profile == &raw_eth_profile)
-			goto out;
-		fallthrough;
 	case IB_QPT_RAW_PACKET:
 	case IB_QPT_UD:
 	case MLX5_IB_QPT_REG_UMR:
@@ -2630,10 +2627,6 @@ static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	int create_flags = attr->create_flags;
 	bool cond;

-	if (qp->type == IB_QPT_UD && dev->profile == &raw_eth_profile)
-		if (create_flags & ~MLX5_IB_QP_CREATE_WC_TEST)
-			return -EINVAL;
-
 	if (qp_type == MLX5_IB_QPT_DCT)
 		return (create_flags) ? -EINVAL : 0;

@@ -4212,6 +4205,24 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	return 0;
 }

+static bool mlx5_ib_modify_qp_allowed(struct mlx5_ib_dev *dev,
+				      struct mlx5_ib_qp *qp,
+				      enum ib_qp_type qp_type)
+{
+	if (dev->profile != &raw_eth_profile)
+		return true;
+
+	if (qp_type == IB_QPT_RAW_PACKET ||
+	    qp_type == MLX5_IB_QPT_REG_UMR)
+		return true;
+
+	/* Internal QP used for wc testing, with NOPs in wq */
+	if (qp->flags & MLX5_IB_QP_CREATE_WC_TEST)
+		return true;
+
+	return false;
+}
+
 int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		      int attr_mask, struct ib_udata *udata)
 {
@@ -4224,6 +4235,9 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	int err = -EINVAL;
 	int port;

+	if (!mlx5_ib_modify_qp_allowed(dev, qp, ibqp->qp_type))
+		return -EOPNOTSUPP;
+
 	if (attr_mask & ~(IB_QP_ATTR_STANDARD_BITS | IB_QP_RATE_LIMIT))
 		return -EOPNOTSUPP;

--
2.29.2

