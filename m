Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957131A6733
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 15:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgDMNhc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 09:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbgDMNhb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 09:37:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E0F2073E;
        Mon, 13 Apr 2020 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586785051;
        bh=tzn2dFkrI4nUGxJKOPOzjHE8qDnRQDZ0qqZI9noZXbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N03XQlOK9y/rDNclZPbL95csSSUdr8bGbxucMTAsRAUjFS2snzFo7IcXzBH2rR6zo
         ++Hwu6VX9C7bOgE/XDotJ2ZWmdXZ30UxUetsMPheWvMHcgP5Or/Yx+MI2mFsmQzPLQ
         uR7QI4jk2vOG3RcskQVb681jztlxD+/1xaKG8PT8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v2 6/6] RDMA/mlx5: Set UDP source port based on the grh.flow_label
Date:   Mon, 13 Apr 2020 16:37:03 +0300
Message-Id: <20200413133703.932731-7-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413133703.932731-1-leon@kernel.org>
References: <20200413133703.932731-1-leon@kernel.org>
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
index 2db2309dde47..953c1d6b23aa 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -628,8 +628,8 @@ static int mlx5_ib_del_gid(const struct ib_gid_attr *attr,
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
index a7b5581a7a4d..61ea8fc70787 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1383,8 +1383,8 @@ int mlx5_ib_get_vf_guid(struct ib_device *device, int vf, u8 port,
 int mlx5_ib_set_vf_guid(struct ib_device *device, int vf, u8 port,
 			u64 guid, int type);
 
-__be16 mlx5_get_roce_udp_sport(struct mlx5_ib_dev *dev,
-			       const struct ib_gid_attr *attr);
+__be16 mlx5_get_roce_udp_sport_min(const struct mlx5_ib_dev *dev,
+				   const struct ib_gid_attr *attr);
 
 void mlx5_ib_cleanup_cong_debugfs(struct mlx5_ib_dev *dev, u8 port_num);
 void mlx5_ib_init_cong_debugfs(struct mlx5_ib_dev *dev, u8 port_num);
-- 
2.25.2

