Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3605A18988D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCRJxN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 05:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgCRJxN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 05:53:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1436C2076F;
        Wed, 18 Mar 2020 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584525192;
        bh=iwBvA8t01OYmvixsS2fr+i9z9u6z9wB4d2ujfB5ml7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJmEyFTJG9K4rFX2xLjZgAilRKKV+JnGJ6Bd4q4CTy0MQsxY1Y7eg+jAEx0mTxaSv
         VbIP4vxVsI9usZjXy4vVK9Tl/qtuq4otDayVIw/dUPzLEwidqO8H8U22qKyKc/szQq
         75R6peLrxW2zx7eahSazu27HODScmNYO42RHE5QQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 3/6] RDMA/mlx5: Define RoCEv2 udp source port when set path
Date:   Wed, 18 Mar 2020 11:52:57 +0200
Message-Id: <20200318095300.45574-4-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318095300.45574-1-leon@kernel.org>
References: <20200318095300.45574-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Calculate and set UDP source port based on the flow label. If flow label is
not defined in GRH then calculate it based on lqpn/rqpn.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 9c2f0cf63d1b..d3055f3eb0b6 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2954,6 +2954,21 @@ static int modify_raw_packet_tx_affinity(struct mlx5_core_dev *dev,
 	return err;
 }
 
+static void mlx5_set_path_udp_sport(struct mlx5_qp_path *path,
+				    const struct rdma_ah_attr *ah,
+				    u32 lqpn, u32 rqpn)
+
+{
+	u32 fl = ah->grh.flow_label;
+	u16 sport;
+
+	if (!fl)
+		fl = rdma_calc_flow_label(lqpn, rqpn);
+
+	sport = rdma_flow_label_to_udp_sport(fl);
+	path->udp_sport = cpu_to_be16(sport);
+}
+
 static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			 const struct rdma_ah_attr *ah,
 			 struct mlx5_qp_path *path, u8 port, int attr_mask,
@@ -2985,12 +3000,15 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			return -EINVAL;
 
 		memcpy(path->rmac, ah->roce.dmac, sizeof(ah->roce.dmac));
-		if (qp->ibqp.qp_type == IB_QPT_RC ||
-		    qp->ibqp.qp_type == IB_QPT_UC ||
-		    qp->ibqp.qp_type == IB_QPT_XRC_INI ||
-		    qp->ibqp.qp_type == IB_QPT_XRC_TGT)
-			path->udp_sport =
-				mlx5_get_roce_udp_sport(dev, ah->grh.sgid_attr);
+		if ((qp->ibqp.qp_type == IB_QPT_RC ||
+		     qp->ibqp.qp_type == IB_QPT_UC ||
+		     qp->ibqp.qp_type == IB_QPT_XRC_INI ||
+		     qp->ibqp.qp_type == IB_QPT_XRC_TGT) &&
+		    (grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) &&
+		    (attr_mask & IB_QP_DEST_QPN))
+			mlx5_set_path_udp_sport(path, ah,
+						qp->ibqp.qp_num,
+						attr->dest_qp_num);
 		path->dci_cfi_prio_sl = (sl & 0x7) << 4;
 		gid_type = ah->grh.sgid_attr->gid_type;
 		if (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-- 
2.24.1

