Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0445FE1B9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2019 16:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKOPpD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Nov 2019 10:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbfKOPpD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Nov 2019 10:45:03 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194162072D;
        Fri, 15 Nov 2019 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573832702;
        bh=ryaAlTc25c2drKWJKQGObu8NiirnKAiaAFyc/3A91+I=;
        h=From:To:Cc:Subject:Date:From;
        b=TaaCh5HzSFh8L7yxznhWhINKt8k4wdceVFD+lcpAJc1jyvGbraVH+7Ty7Duz1L/Jg
         XjOQwJML8d2rXHdnXeWpLSLpCH3PwwL9XvHAwW1DzYB//5QD0oj/+k22v4N27Lfm6W
         El4K/jhgDVxnFAvuGCsZFTbmyLF2fIzXQqZBrJow=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Danit Goldberg <danitg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/mlx4: Update HW GID table while adding vlan GID
Date:   Fri, 15 Nov 2019 17:44:57 +0200
Message-Id: <20191115154457.247763-1-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Danit Goldberg <danitg@mellanox.com>

While adding new GID, besides comparing GID and type, compare also vlan
id, so vlan GIDs will also be updated in HW GID table although they
have same GID as the default GID.

Signed-off-by: Danit Goldberg <danitg@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/main.c    | 9 ++++++++-
 drivers/infiniband/hw/mlx4/mlx4_ib.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 211df0287f57..34055cbab38c 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -256,6 +256,8 @@ static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 	int hw_update = 0;
 	int i;
 	struct gid_entry *gids = NULL;
+	u16 vlan_id = 0xffff;
+	u8 mac[ETH_ALEN];
 
 	if (!rdma_cap_roce_gid_table(attr->device, attr->port_num))
 		return -EINVAL;
@@ -266,12 +268,16 @@ static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 	if (!context)
 		return -EINVAL;
 
+	ret = rdma_read_gid_l2_fields(attr, &vlan_id, &mac[0]);
+	if (ret)
+		return ret;
 	port_gid_table = &iboe->gids[attr->port_num - 1];
 	spin_lock_bh(&iboe->lock);
 	for (i = 0; i < MLX4_MAX_PORT_GIDS; ++i) {
 		if (!memcmp(&port_gid_table->gids[i].gid,
 			    &attr->gid, sizeof(attr->gid)) &&
-		    port_gid_table->gids[i].gid_type == attr->gid_type)  {
+		    port_gid_table->gids[i].gid_type == attr->gid_type &&
+		    port_gid_table->gids[i].vlan_id == vlan_id)  {
 			found = i;
 			break;
 		}
@@ -291,6 +297,7 @@ static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 				memcpy(&port_gid_table->gids[free].gid,
 				       &attr->gid, sizeof(attr->gid));
 				port_gid_table->gids[free].gid_type = attr->gid_type;
+				port_gid_table->gids[free].vlan_id = vlan_id;
 				port_gid_table->gids[free].ctx->real_index = free;
 				port_gid_table->gids[free].ctx->refcount = 1;
 				hw_update = 1;
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 0d846fea8fdc..d188573187fa 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -508,6 +508,7 @@ struct gid_entry {
 	union ib_gid	gid;
 	enum ib_gid_type gid_type;
 	struct gid_cache_context *ctx;
+	u16 vlan_id;
 };
 
 struct mlx4_port_gid_table {
-- 
2.20.1

