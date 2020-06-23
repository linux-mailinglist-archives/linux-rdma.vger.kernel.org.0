Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF452050C0
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 13:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgFWLb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 07:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732447AbgFWLbS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 07:31:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CA12072E;
        Tue, 23 Jun 2020 11:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592911878;
        bh=PWBw8T+Yg5YvJEDOQJefOHqDj1t96Gq39JpYBGTomjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ZQBXYDxcAm6g/4kOWQoZoWyHqtIcrqjx8vaH/UUB6IbNk+0UkpjprVjPdpSmabVr
         xP/x8NuNAG4uR0KqaJOh90f+6uX+bWsXFp4fgHfsHNJJTizYBkUOCnVMoDunedLHVO
         Ffl5aYRdjwB8WBGZ9P3Oal2eIZbHwQDWjZlVN8E4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 09/11] RDMA/mlx5: Add support to get QP resource in RAW format
Date:   Tue, 23 Jun 2020 14:30:41 +0300
Message-Id: <20200623113043.1228482-10-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623113043.1228482-1-leon@kernel.org>
References: <20200623113043.1228482-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Add a generic function that use the resource dump mechanism
to get the resource data. This patch adds the support to QP.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c     |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  1 +
 drivers/infiniband/hw/mlx5/restrack.c | 77 +++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index fa9237a10ed8..7ac75935d3c2 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6599,6 +6599,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.drain_sq = mlx5_ib_drain_sq,
 	.enable_driver = mlx5_ib_enable_driver,
 	.fill_res_mr_entry = mlx5_ib_fill_res_mr_entry,
+	.fill_res_qp_entry_raw = mlx5_ib_fill_res_qp_entry_raw,
 	.fill_stat_mr_entry = mlx5_ib_fill_stat_mr_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = mlx5_ib_get_dma_mr,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 37ead14eb317..7285c00e474d 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1376,6 +1376,7 @@ struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *dev,
 void mlx5_ib_put_native_port_mdev(struct mlx5_ib_dev *dev,
 				  u8 port_num);
 int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
+int mlx5_ib_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp);
 int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 
 extern const struct uapi_definition mlx5_ib_devx_defs[];
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 598a09796d09..c8b91d8e0f42 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -4,10 +4,79 @@
  */
 
 #include <uapi/rdma/rdma_netlink.h>
+#include <linux/mlx5/rsc_dump.h>
 #include <rdma/ib_umem_odp.h>
 #include <rdma/restrack.h>
 #include "mlx5_ib.h"
 
+#define MAX_DUMP_SIZE 1024
+
+static int dump_rsc(struct mlx5_core_dev *dev, enum mlx5_sgmt_type type,
+		    int index, void *data, int *data_len)
+{
+	struct mlx5_core_dev *mdev = dev;
+	struct mlx5_rsc_dump_cmd *cmd;
+	struct mlx5_rsc_key key = {};
+	struct page *page;
+	int offset = 0;
+	int err = 0;
+	int cmd_err;
+	int size;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	key.size = PAGE_SIZE;
+	key.rsc = type;
+	key.index1 = index;
+	key.num_of_obj1 = 1;
+
+	cmd = mlx5_rsc_dump_cmd_create(mdev, &key);
+	if (IS_ERR(cmd)) {
+		err = PTR_ERR(cmd);
+		goto free_page;
+	}
+
+	do {
+		cmd_err = mlx5_rsc_dump_next(mdev, cmd, page, &size);
+		if (cmd_err < 0 || size + offset > MAX_DUMP_SIZE) {
+			err = cmd_err;
+			goto destroy_cmd;
+		}
+		memcpy(data + offset, page_address(page), size);
+		offset += size;
+	} while (cmd_err > 0);
+	*data_len = offset;
+
+destroy_cmd:
+	mlx5_rsc_dump_cmd_destroy(cmd);
+free_page:
+	__free_page(page);
+	return err;
+}
+
+static int fill_res_raw(struct sk_buff *msg, struct mlx5_ib_dev *dev,
+			enum mlx5_sgmt_type type, u32 key)
+{
+	int len = 0;
+	void *data;
+	int err;
+
+	data = kzalloc(MAX_DUMP_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	err = dump_rsc(dev->mdev, type, key, data, &len);
+	if (err)
+		goto out;
+
+	err = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, len, data);
+out:
+	kfree(data);
+	return err;
+}
+
 int mlx5_ib_fill_stat_mr_entry(struct sk_buff *msg,
 			       struct ib_mr *ibmr)
 {
@@ -68,3 +137,11 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
 	nla_nest_cancel(msg, table_attr);
 	return -EMSGSIZE;
 }
+
+int mlx5_ib_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp)
+{
+	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
+
+	return fill_res_raw(msg, dev, MLX5_SGMT_TYPE_PRM_QUERY_QP,
+			    ibqp->qp_num);
+}
-- 
2.26.2

