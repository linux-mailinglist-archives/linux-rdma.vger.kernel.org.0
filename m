Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10341C322E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 07:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEDFT4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 01:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgEDFTz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 May 2020 01:19:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE02420735;
        Mon,  4 May 2020 05:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588569595;
        bh=GU9O9g0OpTLWggLgoKkVKuz2d3JzSym/lg420IrOyOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZpG2va7tCqMX5sbT0bw0uh/oST8qlTM89jOrUdzJu0ubHVapzZ5NFXdObbSjzLMr
         5w95gW5d9uAtYcsXJtSyiQD05211OH6LYId3O/w2ImLnKMEOezEvxXg7iKxGz8eO5y
         T3B/BRjIBvfOJ6jyrE+1zisR1UBq3w9gGkJPjKR8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v3 3/5] RDMA/mlx5: Define RoCEv2 udp source port when set path
Date:   Mon,  4 May 2020 08:19:33 +0300
Message-Id: <20200504051935.269708-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504051935.269708-1-leon@kernel.org>
References: <20200504051935.269708-1-leon@kernel.org>
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
index 810bbd52daec..e624886bcf85 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3133,6 +3133,21 @@ static int modify_raw_packet_tx_affinity(struct mlx5_core_dev *dev,
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
@@ -3164,12 +3179,15 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
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
2.26.2

