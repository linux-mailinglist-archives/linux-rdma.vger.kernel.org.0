Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18D3189892
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 10:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCRJxZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 05:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgCRJxZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 05:53:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288E420770;
        Wed, 18 Mar 2020 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584525203;
        bh=CkHmjabXtXZc6rD4zm8zt5l+yYnybmdBXNy6FahbrDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxUTfA8muzFvgLuebMxBfe9ejkat9ecBXpCqKYG7GIw/cKTjdE8kFX/FLejKcUVEm
         Km1V303DlFxiyiCmt56/eGNJmv5kWODzj8fZaIREAR59iXTxBEiS+gufCwKjB48uWs
         whCgxpHj/KQ1yPNyLtRnU3nMzOSKM5MZpEY/Ba10=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 6/6] RDMA/mlx5: Set UDP source port based on the grh.flow_label
Date:   Wed, 18 Mar 2020 11:53:00 +0200
Message-Id: <20200318095300.45574-7-leon@kernel.org>
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

Calculate UDP source port based on the grh.flow_label. If grh.flow_label
is not valid, we will use minimal supported UDP source port.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/ah.c      | 21 +++++++++++++++++++--
 drivers/infiniband/hw/mlx5/main.c    |  4 ++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 ++--
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 14ad05e7c5bf..5acf1bfb73fe 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -32,6 +32,24 @@
 
 #include "mlx5_ib.h"
 
+static __be16 mlx5_ah_get_udp_sport(const struct mlx5_ib_dev *dev,
+				  const struct rdma_ah_attr *ah_attr)
+{
+	enum ib_gid_type gid_type = ah_attr->grh.sgid_attr->gid_type;
+	__be16 sport;
+
+	if ((gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) &&
+	    (rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH) &&
+	    (ah_attr->grh.flow_label & IB_GRH_FLOWLABEL_MASK))
+		sport = cpu_to_be16(
+			rdma_flow_label_to_udp_sport(ah_attr->grh.flow_label));
+	else
+		sport = mlx5_get_roce_udp_sport_min(dev,
+						    ah_attr->grh.sgid_attr);
+
+	return sport;
+}
+
 static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 			 struct rdma_ah_attr *ah_attr)
 {
@@ -59,8 +77,7 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 
 		memcpy(ah->av.rmac, ah_attr->roce.dmac,
 		       sizeof(ah_attr->roce.dmac));
-		ah->av.udp_sport =
-			mlx5_get_roce_udp_sport(dev, ah_attr->grh.sgid_attr);
+		ah->av.udp_sport = mlx5_ah_get_udp_sport(dev, ah_attr);
 		ah->av.stat_rate_sl |= (rdma_ah_get_sl(ah_attr) & 0x7) << 1;
 		if (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
 #define MLX5_ECN_ENABLED BIT(1)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d57ebdba027e..66cd417f5d09 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -631,8 +631,8 @@ static int mlx5_ib_del_gid(const struct ib_gid_attr *attr,
 			     attr->index, NULL, NULL);
 }
 
-__be16 mlx5_get_roce_udp_sport(struct mlx5_ib_dev *dev,
-			       const struct ib_gid_attr *attr)
+__be16 mlx5_get_roce_udp_sport_min(const struct mlx5_ib_dev *dev,
+				   const struct ib_gid_attr *attr)
 {
 	if (attr->gid_type != IB_GID_TYPE_ROCE_UDP_ENCAP)
 		return 0;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 7d3e4e4942e9..85d4f3958e32 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1362,8 +1362,8 @@ int mlx5_ib_get_vf_guid(struct ib_device *device, int vf, u8 port,
 int mlx5_ib_set_vf_guid(struct ib_device *device, int vf, u8 port,
 			u64 guid, int type);
 
-__be16 mlx5_get_roce_udp_sport(struct mlx5_ib_dev *dev,
-			       const struct ib_gid_attr *attr);
+__be16 mlx5_get_roce_udp_sport_min(const struct mlx5_ib_dev *dev,
+				   const struct ib_gid_attr *attr);
 
 void mlx5_ib_cleanup_cong_debugfs(struct mlx5_ib_dev *dev, u8 port_num);
 void mlx5_ib_init_cong_debugfs(struct mlx5_ib_dev *dev, u8 port_num);
-- 
2.24.1

