Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799A619059C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 07:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCXGOu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 02:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgCXGOu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Mar 2020 02:14:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA0B22073E;
        Tue, 24 Mar 2020 06:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585030489;
        bh=m00fJwHAEPd1GFwCIZp/3bMpirkGksYCKbDcuVeGvsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAJ7fvxqc13cxkiuI1UB0zkKBhJXi4PGoUnDJa+Mlj8fMdKhHiC2NxW3gMG0IbyTi
         3bDSh1497jUTKXL5Qe6OU5Vg4hhk0BnZUMUpNiQE1Tzsh3/nFO9MXm9uzOdv8X+5Lt
         QYjRXLAfShWuGWrtlqYVcpU1tfk4dMwk6XHTrMPg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Michael Guralnik <michaelgur@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Add support for RDMA TX flow table
Date:   Tue, 24 Mar 2020 08:14:25 +0200
Message-Id: <20200324061425.1570190-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324061425.1570190-1-leon@kernel.org>
References: <20200324061425.1570190-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

Enable user application to add rules for RDMA TX steering table.
Rules in this steering table will allow to steer transmitted RDMA
traffic.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/flow.c         | 3 +++
 drivers/infiniband/hw/mlx5/main.c         | 7 +++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h      | 1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h | 1 +
 4 files changed, 12 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5/flow.c
index dbee17d22d50..862b7bf3e646 100644
--- a/drivers/infiniband/hw/mlx5/flow.c
+++ b/drivers/infiniband/hw/mlx5/flow.c
@@ -35,6 +35,9 @@ mlx5_ib_ft_type_to_namespace(enum mlx5_ib_uapi_flow_table_type table_type,
 	case MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_RX:
 		*namespace = MLX5_FLOW_NAMESPACE_RDMA_RX;
 		break;
+	case MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_TX:
+		*namespace = MLX5_FLOW_NAMESPACE_RDMA_TX;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e355e06bf3ac..5ccae3e3ba0c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4064,6 +4064,11 @@ _get_flow_table(struct mlx5_ib_dev *dev,
 			BIT(MLX5_CAP_FLOWTABLE_RDMA_RX(dev->mdev,
 						       log_max_ft_size));
 		priority = fs_matcher->priority;
+	} else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX) {
+		max_table_size =
+			BIT(MLX5_CAP_FLOWTABLE_RDMA_TX(dev->mdev,
+						       log_max_ft_size));
+		priority = fs_matcher->priority;
 	}
 
 	max_table_size = min_t(int, max_table_size, MLX5_FS_MAX_ENTRIES);
@@ -4080,6 +4085,8 @@ _get_flow_table(struct mlx5_ib_dev *dev,
 		prio = &dev->flow_db->fdb;
 	else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_RX)
 		prio = &dev->flow_db->rdma_rx[priority];
+	else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX)
+		prio = &dev->flow_db->rdma_tx[priority];
 
 	if (!prio)
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 1a2e3cf0625e..61ea8fc70787 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -229,6 +229,7 @@ struct mlx5_ib_flow_db {
 	struct mlx5_ib_flow_prio	egress[MLX5_IB_NUM_EGRESS_FTS];
 	struct mlx5_ib_flow_prio	fdb;
 	struct mlx5_ib_flow_prio	rdma_rx[MLX5_IB_NUM_FLOW_FT];
+	struct mlx5_ib_flow_prio	rdma_tx[MLX5_IB_NUM_FLOW_FT];
 	struct mlx5_flow_table		*lag_demux_ft;
 	/* Protect flow steering bypass flow tables
 	 * when add/del flow rules.
diff --git a/include/uapi/rdma/mlx5_user_ioctl_verbs.h b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
index 3f7a97c28045..56b26eaea083 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_verbs.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
@@ -44,6 +44,7 @@ enum mlx5_ib_uapi_flow_table_type {
 	MLX5_IB_UAPI_FLOW_TABLE_TYPE_NIC_TX	= 0x1,
 	MLX5_IB_UAPI_FLOW_TABLE_TYPE_FDB	= 0x2,
 	MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_RX	= 0x3,
+	MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_TX	= 0x4,
 };
 
 enum mlx5_ib_uapi_flow_action_packet_reformat_type {
-- 
2.24.1

