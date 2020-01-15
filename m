Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA0713BB7D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 09:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAOIu4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 03:50:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgAOIu4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 03:50:56 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB48207E0;
        Wed, 15 Jan 2020 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579078255;
        bh=0V3umVshv5Bxqm0p3eemm1FA/YXC42BvryTY6Ov2KEs=;
        h=From:To:Cc:Subject:Date:From;
        b=G6UgEW/SsAt9XgZ5J2V/16AdS8Nk5XzgyRC3hHLFwZfYt7Q6SMjY6dL/fUafjiiXD
         2ziWAuIrCoqrCUB51tWJerUlZSsDNQ5jQjs81wBzrIz66r7Hz0AnoSz0DPR5IVQBNP
         7iLzQ7naneJlx7JiAax35E8u3KDhzUpjgI7+Hfj8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] IB/mlx4: Fix memory leak in add_gid error flow
Date:   Wed, 15 Jan 2020 10:50:50 +0200
Message-Id: <20200115085050.73746-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

In procedure mlx4_ib_add_gid(), if the driver is unable to
update the FW gid table, there is a memory leak in the driver's
copy of the gid table: the gid entry's context buffer is not freed.

If such an error occurs, free the entry's context buffer, and mark the
entry as available (by setting its context pointer to NULL).

Fixes: e26be1bfef81 ("IB/mlx4: Implement ib_device callbacks")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 34055cbab38c..2f5d9b181848 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -246,6 +246,13 @@ static int mlx4_ib_update_gids(struct gid_entry *gids,
 	return mlx4_ib_update_gids_v1(gids, ibdev, port_num);
 }
 
+static void free_gid_entry(struct gid_entry *entry)
+{
+	memset(&entry->gid, 0, sizeof(entry->gid));
+	kfree(entry->ctx);
+	entry->ctx = NULL;
+}
+
 static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 {
 	struct mlx4_ib_dev *ibdev = to_mdev(attr->device);
@@ -313,6 +320,8 @@ static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 				     GFP_ATOMIC);
 		if (!gids) {
 			ret = -ENOMEM;
+			*context = NULL;
+			free_gid_entry(&port_gid_table->gids[free]);
 		} else {
 			for (i = 0; i < MLX4_MAX_PORT_GIDS; i++) {
 				memcpy(&gids[i].gid, &port_gid_table->gids[i].gid, sizeof(union ib_gid));
@@ -324,6 +333,12 @@ static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 
 	if (!ret && hw_update) {
 		ret = mlx4_ib_update_gids(gids, ibdev, attr->port_num);
+		if (ret) {
+			spin_lock_bh(&iboe->lock);
+			*context = NULL;
+			free_gid_entry(&port_gid_table->gids[free]);
+			spin_unlock_bh(&iboe->lock);
+		}
 		kfree(gids);
 	}
 
@@ -353,10 +368,7 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 		if (!ctx->refcount) {
 			unsigned int real_index = ctx->real_index;
 
-			memset(&port_gid_table->gids[real_index].gid, 0,
-			       sizeof(port_gid_table->gids[real_index].gid));
-			kfree(port_gid_table->gids[real_index].ctx);
-			port_gid_table->gids[real_index].ctx = NULL;
+			free_gid_entry(&port_gid_table->gids[real_index]);
 			hw_update = 1;
 		}
 	}
-- 
2.20.1

