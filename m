Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7C1BA892
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgD0Pro (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbgD0Prn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:43 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E0C20735;
        Mon, 27 Apr 2020 15:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002463;
        bh=JPySWYBtLNx2EkO8q0BvT+pBg2FfcGLk+v9cYt7HKdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scamBxkhcFqwLXcf6fRmiILv+CZJwpq3Qpk9ftJdNvY20XvXVReFHCtnR+sQ64CC1
         T3sN/iKfE1Bd5J5IqTif3vlfi7Dw0MDM0WHDgtCv/QPbwd+FvHStNl7iB/5GYWI7rz
         mrxHM7iWQMzifO7EARedmU7P5+asIta7KsToSZVg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 17/36] RDMA/mlx5: Return all configured create flags through query QP
Date:   Mon, 27 Apr 2020 18:46:17 +0300
Message-Id: <20200427154636.381474-18-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
References: <20200427154636.381474-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The "flags" field in struct mlx5_ib_qp contains all UAPI flags
configured at the create QP stage. Return all the data as is
without masking.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/qp.c      | 13 +------------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index b6467cadc384..9b2baf119823 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -443,6 +443,7 @@ struct mlx5_ib_qp {
 	/* serialize qp state modifications
 	 */
 	struct mutex		mutex;
+	/* cached variant of create_flags from struct ib_qp_init_attr */
 	u32			flags;
 	u8			port;
 	u8			state;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 6a4b20c71b40..f0385965a694 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5878,18 +5878,7 @@ int mlx5_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
 	qp_init_attr->cap	     = qp_attr->cap;
 
-	qp_init_attr->create_flags = 0;
-	if (qp->flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK)
-		qp_init_attr->create_flags |= IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK;
-
-	if (qp->flags & IB_QP_CREATE_CROSS_CHANNEL)
-		qp_init_attr->create_flags |= IB_QP_CREATE_CROSS_CHANNEL;
-	if (qp->flags & IB_QP_CREATE_MANAGED_SEND)
-		qp_init_attr->create_flags |= IB_QP_CREATE_MANAGED_SEND;
-	if (qp->flags & IB_QP_CREATE_MANAGED_RECV)
-		qp_init_attr->create_flags |= IB_QP_CREATE_MANAGED_RECV;
-	if (qp->flags & MLX5_IB_QP_CREATE_SQPN_QP1)
-		qp_init_attr->create_flags |= MLX5_IB_QP_CREATE_SQPN_QP1;
+	qp_init_attr->create_flags = qp->flags;
 
 	qp_init_attr->sq_sig_type = qp->sq_signal_bits & MLX5_WQE_CTRL_CQ_UPDATE ?
 		IB_SIGNAL_ALL_WR : IB_SIGNAL_REQ_WR;
-- 
2.25.3

